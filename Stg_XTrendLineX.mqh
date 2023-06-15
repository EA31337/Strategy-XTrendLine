/**
 * @file
 * Implements XTrendLineX strategy based on the XTrendLineX indicator.
 */

// User input params.
INPUT_GROUP("XTrendLineX strategy: strategy params");
INPUT float XTrendLineX_LotSize = 0;                // Lot size
INPUT int XTrendLineX_SignalOpenMethod = 0;         // Signal open method
INPUT float XTrendLineX_SignalOpenLevel = 0;        // Signal open level
INPUT int XTrendLineX_SignalOpenFilterMethod = 32;  // Signal open filter method
INPUT int XTrendLineX_SignalOpenFilterTime = 3;     // Signal open filter time (0-31)
INPUT int XTrendLineX_SignalOpenBoostMethod = 0;    // Signal open boost method
INPUT int XTrendLineX_SignalCloseMethod = 0;        // Signal close method
INPUT int XTrendLineX_SignalCloseFilter = 32;       // Signal close filter (-127-127)
INPUT float XTrendLineX_SignalCloseLevel = 0;       // Signal close level
INPUT int XTrendLineX_PriceStopMethod = 0;          // Price limit method
INPUT float XTrendLineX_PriceStopLevel = 2;         // Price limit level
INPUT int XTrendLineX_TickFilterMethod = 32;        // Tick filter method (0-255)
INPUT float XTrendLineX_MaxSpread = 4.0;            // Max spread to trade (in pips)
INPUT short XTrendLineX_Shift = 0;                  // Shift
INPUT float XTrendLineX_OrderCloseLoss = 80;        // Order close loss
INPUT float XTrendLineX_OrderCloseProfit = 80;      // Order close profit
INPUT int XTrendLineX_OrderCloseTime = -30;         // Order close time in mins (>0) or bars (<0)
INPUT_GROUP("XTrendLineX strategy: XTrendLineX indicator params");
INPUT int XTrendLineX_Indi_XTrendLineX_Shift = 0;                                        // Shift
INPUT ENUM_IDATA_SOURCE_TYPE XTrendLineX_Indi_XTrendLineX_SourceType = IDATA_INDICATOR;  // Source type

// Structs.

// Defines struct with default user strategy values.
struct Stg_XTrendLineX_Params_Defaults : StgParams {
  Stg_XTrendLineX_Params_Defaults()
      : StgParams(::XTrendLineX_SignalOpenMethod, ::XTrendLineX_SignalOpenFilterMethod, ::XTrendLineX_SignalOpenLevel,
                  ::XTrendLineX_SignalOpenBoostMethod, ::XTrendLineX_SignalCloseMethod, ::XTrendLineX_SignalCloseFilter,
                  ::XTrendLineX_SignalCloseLevel, ::XTrendLineX_PriceStopMethod, ::XTrendLineX_PriceStopLevel,
                  ::XTrendLineX_TickFilterMethod, ::XTrendLineX_MaxSpread, ::XTrendLineX_Shift) {
    Set(STRAT_PARAM_LS, XTrendLineX_LotSize);
    Set(STRAT_PARAM_OCL, XTrendLineX_OrderCloseLoss);
    Set(STRAT_PARAM_OCP, XTrendLineX_OrderCloseProfit);
    Set(STRAT_PARAM_OCT, XTrendLineX_OrderCloseTime);
    Set(STRAT_PARAM_SOFT, XTrendLineX_SignalOpenFilterTime);
  }
};

class Stg_XTrendLineX : public Strategy {
 public:
  Stg_XTrendLineX(StgParams &_sparams, TradeParams &_tparams, ChartParams &_cparams, string _name = "")
      : Strategy(_sparams, _tparams, _cparams, _name) {}

  static Stg_XTrendLineX *Init(ENUM_TIMEFRAMES _tf = NULL, EA *_ea = NULL) {
    // Initialize strategy initial values.
    Stg_XTrendLineX_Params_Defaults stg_xtrendlinex_defaults;
    StgParams _stg_params(stg_xtrendlinex_defaults);
    // Initialize indicator.
    // Initialize Strategy instance.
    ChartParams _cparams(_tf, _Symbol);
    TradeParams _tparams;
    Strategy *_strat = new Stg_XTrendLineX(_stg_params, _tparams, _cparams, "XTrendLineX");
    return _strat;
  }

  /**
   * Event on strategy's init.
   */
  void OnInit() {
    // IndiXTrendLineXParams _indi_params(::XTrendLineX_Indi_XTrendLineX_Shift);
    //_indi_params.SetTf(Get<ENUM_TIMEFRAMES>(STRAT_PARAM_TF));
    // SetIndicator(new Indi_XTrendLineX(_indi_params));
  }

  /**
   * Check strategy's opening signal.
   */
  bool SignalOpen(ENUM_ORDER_TYPE _cmd, int _method, float _level = 0.0f, int _shift = 0) {
    /*
    Indi_XTrendLineX *_indi = GetIndicator();
    bool _result =
        _indi.GetFlag(INDI_ENTRY_FLAG_IS_VALID, _shift) && _indi.GetFlag(INDI_ENTRY_FLAG_IS_VALID, _shift + 1);
    if (!_result) {
      // Returns false when indicator data is not valid.
      return false;
    }
    IndicatorSignal _signals = _indi.GetSignals(4, _shift);
    switch (_cmd) {
      case ORDER_TYPE_BUY:
        // Buy signal.
        _result &= _indi.IsIncreasing(1, 0, _shift);
        _result &= _indi.IsIncByPct(_level / 10, 0, _shift, 2);
        _result &= _method > 0 ? _signals.CheckSignals(_method) : _signals.CheckSignalsAll(-_method);
        break;
      case ORDER_TYPE_SELL:
        // Sell signal.
        _result &= _indi.IsDecreasing(1, 0, _shift);
        _result &= _indi.IsDecByPct(_level / 10, 0, _shift, 2);
        _result &= _method > 0 ? _signals.CheckSignals(_method) : _signals.CheckSignalsAll(-_method);
        break;
    }
    return _result;
    */
    return true;
  }
};
