#ifndef _EDGEAI_PERF_STATS_UTILS_
#define _EDGEAI_PERF_STATS_UTILS_

/* Standard headers. */
#include <stdint.h>
#include <pthread.h>

#ifdef __cplusplus
extern "C" {
#endif

/*  ################################
    UTILS FOR PERFORMANCE STATISTICS
    ################################
*/

typedef struct {

    uint64_t total_time;
    uint64_t busy_time;
    uint64_t irq_time;
    uint64_t softirq_time;
    uint32_t cpu_load; /**< divide by 100 to get load in units of xx.xx % */
    uint32_t hwi_load; /**< divide by 100 to get load in units of xx.xx % */
    uint32_t swi_load; /**< divide by 100 to get load in units of xx.xx % */
} perfStatsCpuLoad;

/**
* Utility Function to calculate cpu loading
*
* @param cpuLoad       Pointer to perfStatsCpuLoad structure
*/
void perfStatsCpuLoadCalc(perfStatsCpuLoad *cpuLoad);

/**
* Utility Function to Initialize cpuLoad stats
*/
void perfStatsCpuStatsInit(perfStatsCpuLoad *cpu_load);

/**
* Utility Function to Print CPU stats
*/
void perfStatsCpuStatsPrint(perfStatsCpuLoad *cpu_load);

/**
* Utility Function to reset perfStatsCpuLoad struct members
*
* @param cpuLoad       Pointer to perfStatsCpuLoad structure
*/
void perfStatsResetCpuLoadCalc(perfStatsCpuLoad *cpuLoad);

/**
 * \brief DDR BW information
 *
 * note, this information is retrived from MCU2-1
 *       EMIF counters are used to sample read, write access every 1ms periodicity
 */
typedef struct {

    uint32_t read_bw_avg;   /**< avg bytes read per second, in units of MB/s */
    uint32_t write_bw_avg;  /**< avg bytes written per second, in units of in MB/s */
    uint32_t read_bw_peak;  /**< peak bytes read in a sampling period, in units of MB/s */
    uint32_t write_bw_peak; /**< peak bytes read in a sampling period, in units of MB/s */
    uint32_t total_available_bw; /**< theoritical bw available to system, in units of MB/s */

    uint32_t counter0_total;  /**< sum total of counter0 values aggregated over time as defined by APP_PERF_SNAPSHOT_WINDOW_WIDTH */
    uint32_t counter1_total;  /**< sum total of counter1 values aggregated over time as defined by APP_PERF_SNAPSHOT_WINDOW_WIDTH */
    uint32_t counter2_total;  /**< sum total of counter2 values aggregated over time as defined by APP_PERF_SNAPSHOT_WINDOW_WIDTH */
    uint32_t counter3_total;  /**< sum total of counter3 values aggregated over time as defined by APP_PERF_SNAPSHOT_WINDOW_WIDTH */

} perf_stats_ddr_stats_t;

/**
* Utility Function to Get DDR stats
*
* @returns DDR Stats
*/
perf_stats_ddr_stats_t *perfStatsDdrStatsGet();

/**
* Utility Function to Print DDR stats
*/
void perfStatsDdrStatsPrintAll();

/**
* Utility Function to Clear DDR Stats
*/
void perfStatsResetDdrLoadCalcAll();
#ifdef __cplusplus
}
#endif

#endif