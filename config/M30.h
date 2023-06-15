/*
 * @file
 * Defines default strategy parameter values for the given timeframe.
 */

// Defines indicator's parameter values for the given pair symbol and timeframe.
struct Indi_XTrendLineX_Params_M30 : IndiXTrendLineXParams {
  Indi_XTrendLineX_Params_M30() : IndiXTrendLineXParams(indi_xtrendlinex_defaults, PERIOD_M30) { shift = 0; }
} indi_xtrendlinex_m30;

// Defines strategy's parameter values for the given pair symbol and timeframe.
struct Stg_XTrendLineX_Params_M30 : StgParams {
  // Struct constructor.
  Stg_XTrendLineX_Params_M30() : StgParams(stg_xtrendlinex_defaults) {}
} stg_xtrendlinex_m30;
