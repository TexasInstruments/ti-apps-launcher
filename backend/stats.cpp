#include <QObject>
#include <QProcess>
#include <QFile>

#include "includes/stats.h"
#include "utils/includes/perf_stats.h"

QString stats::getgpuload() {
    QProcess process;
    process.start("cat", {"/sys/kernel/debug/pvr/status"});
    process.waitForFinished(-1);
    QString output = process.readAllStandardOutput();
    return output.mid(output.indexOf("GPU Utilisation")+17,output.indexOf("%")-output.indexOf("GPU Utilisation")-17);
}

QString stats::getcpuload() {
    QFile file("/proc/stat");
    file.open(QFile::ReadOnly);
    const QList<QByteArray> times = file.readLine().simplified().split(' ').mid(1);

    int totalTime = 0;
    for (const QByteArray &time : times) {
        totalTime += time.toInt();
    }
    const int deltaTotalTime = totalTime - prevTotalTime;

    const int idleTime = times.at(3).toInt();
    const int loadTime = totalTime - idleTime;
    const int deltaLoadTime = loadTime - prevLoadTime;

    prevLoadTime = loadTime;
    prevTotalTime = totalTime;

    float loadPercent = ((float)deltaLoadTime / deltaTotalTime) * 100.0f;
    return QString::number(loadPercent, 'f', 2);
}

QString stats::get_soc_temp() {
    QProcess process;
    QString output;
    float temp = 0;

    process.start("cat", {"/sys/class/thermal/thermal_zone0/temp"});
    process.waitForFinished(-1);
    temp = process.readAllStandardOutput().toFloat();

    // The temperature value returned is in millidegree celsius, so convert to celsius before sending to QML
    return QString::number(temp / 1000, 'f', 2);
}

unsigned int stats::getddrtotalbw() {
    perf_stats_ddr_stats_t *ddrload;
    ddrload=perfStatsDdrStatsGet();
    perfStatsResetDdrLoadCalcAll();
    unsigned int res = ddrload->total_available_bw;
    return res;
}
perf_stats_ddr_stats_t *ddrload;
unsigned int stats::getddrload() {
    ddrload=perfStatsDdrStatsGet();
    unsigned int r= ddrload->read_bw_avg+ddrload->write_bw_avg;
    return r;
}
unsigned int stats::getddrreadbw() {
    unsigned int r= ddrload->read_bw_avg;
    return r;
}

unsigned int stats::getddrwritebw() {
    unsigned int r= ddrload->write_bw_avg;
    perfStatsResetDdrLoadCalcAll();
    return r;
}
