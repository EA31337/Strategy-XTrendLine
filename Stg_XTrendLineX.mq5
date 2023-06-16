/**
 * @file
 * Implements XTrendLineX strategy.
 */

// Includes conditional compilation directives.
#include "config/define.h"

// Includes EA31337 framework.
#include <EA31337-classes/EA.mqh>
#include <EA31337-classes/Indicators/Price/Indi_Price.mqh>
#include <EA31337-classes/Strategy.mqh>

// Inputs.
input int Active_Tfs = M1B + M2B + M3B + M4B + M5B + M6B + M10B + M12B +
                       M15B;              // Timeframes (M1=1,M2=2,M5=16,M15=256,M30=1024,H1=2048,H2=4096,H3,H4,H6,H8)
input ENUM_LOG_LEVEL Log_Level = V_INFO;  // Log level.
input bool Info_On_Chart = true;          // Display info on chart.

// Includes strategy.
#include "Stg_XTrendLineX.mqh"

// Defines.
#define ea_name "Strategy XTrendLineX"
#define ea_version "2.000"
#define ea_desc "Strategy based XTrendLineX indicator."
#define ea_link "https://github.com/EA31337/Strategy-XTrendLineX"

// Properties.
#property version ea_version
#ifdef __MQL4__
#property description ea_name
#property description ea_desc
#endif
#property link ea_link
#ifdef __resource__
#ifdef __MQL5__
#property tester_indicator "::" + INDI_XTRENDLINE_PATH + "\\XTrendLineX.ex5"
#property tester_library "::" + INDI_XTRENDLINE_PATH + "\\XTrendLineX.ex5"
#endif
#endif

// Load external resources.
#ifdef __resource__
#ifdef __MQL5__
#resource INDI_XTRENDLINE_PATH + "\\XTrendLineX.ex5"
#endif
#endif

// Class variables.
EA *ea;

/* EA event handler functions */

/**
 * Implements "Init" event handler function.
 *
 * Invoked once on EA startup.
 */
int OnInit() {
  bool _result = true;
  EAParams ea_params(__FILE__, Log_Level);
  ea = new EA(ea_params);
  _result &= ea.StrategyAdd<Stg_XTrendLineX>(Active_Tfs);
  return (_result ? INIT_SUCCEEDED : INIT_FAILED);
}

/**
 * Implements "Tick" event handler function (EA only).
 *
 * Invoked when a new tick for a symbol is received, to the chart of which the Expert Advisor is attached.
 */
void OnTick() {
  ea.ProcessTick();
  if (!ea.GetTerminal().IsOptimization()) {
    ea.UpdateInfoOnChart();
  }
}

/**
 * Implements "Deinit" event handler function.
 *
 * Invoked once on EA exit.
 */
void OnDeinit(const int reason) { Object::Delete(ea); }
