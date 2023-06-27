#include <QObject>
#include <iostream>
#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include "includes/stats.h"
#include "../utils/includes/perf_stats.h"


QString stats::getgpuload() {
    QProcess process;
    process.start("cat /sys/kernel/debug/pvr/status");
    process.waitForFinished(-1);
    QString output = process.readAllStandardOutput();
    return output.mid(output.indexOf("GPU Utilisation")+17,output.indexOf("%")-output.indexOf("GPU Utilisation")-17);
}
QString stats::getcpuload() {
    perfStatsCpuLoad cpuload;
    perfStatsCpuStatsInit(&cpuload);
    perfStatsCpuLoadCalc(&cpuload);
    perfStatsResetCpuLoadCalc(&cpuload);
    QString res = QString::number(cpuload.cpu_load/100)+"."+QString::number(cpuload.cpu_load%100);
    return res;
}

uint32_t stats::getddrtotalbw() {
    perf_stats_ddr_stats_t *ddrload;
    ddrload=perfStatsDdrStatsGet();
    perfStatsResetDdrLoadCalcAll();
    uint32_t res = ddrload->total_available_bw;
    return res;
}

uint32_t stats::getddrload() {
    perf_stats_ddr_stats_t *ddrload;
    ddrload=perfStatsDdrStatsGet();
    uint32_t r= ddrload->read_bw_avg+ddrload->write_bw_avg;
    perfStatsResetDdrLoadCalcAll();
    return r;
}