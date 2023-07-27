#include <QObject>
#include <iostream>
#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include "includes/stats.h"
#include "utils/includes/perf_stats.h"

QString stats::getcpuload() {
    perfStatsCpuLoad cpuload;
    perfStatsCpuStatsInit(&cpuload);
    perfStatsCpuLoadCalc(&cpuload);
    perfStatsResetCpuLoadCalc(&cpuload);
    QString res = QString::number(cpuload.cpu_load/100);
    return res;
}

uint32_t stats::getddrtotalbw() {
    perf_stats_ddr_stats_t *ddrload;
    ddrload=perfStatsDdrStatsGet();
    perfStatsResetDdrLoadCalcAll();
    uint32_t res = ddrload->total_available_bw;
    return res;
}
perf_stats_ddr_stats_t *ddrload;
uint32_t stats::getddrload() {
    ddrload=perfStatsDdrStatsGet();
    uint32_t r= ddrload->read_bw_avg+ddrload->write_bw_avg;
    return r;
}
uint32_t stats::getddrreadbw() {
    uint32_t r= ddrload->read_bw_avg;
    return r;
}

uint32_t stats::getddrwritebw() {
    uint32_t r= ddrload->write_bw_avg;
    perfStatsResetDdrLoadCalcAll();
    return r;
}
