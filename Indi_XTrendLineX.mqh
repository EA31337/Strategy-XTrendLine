//+------------------------------------------------------------------+
//|                                 Copyright 2016-2022, EA31337 Ltd |
//|                                       https://github.com/EA31337 |
//+------------------------------------------------------------------+

/*
 * This file is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

// Prevents processing the same indicator file twice.
#ifndef INDI_XTRENDLINE_MQH
#define INDI_XTRENDLINE_MQH

// Defines
#define INDI_XTRENDLINE_PATH "indicators-other\\PriceRange"

// Indicator line identifiers used in the indicator.
enum ENUM_XTRENDLINE_MODE {
  XTRENDLINE_OPEN = 0,  // Open.
  XTRENDLINE_HIGH,      // High.
  XTRENDLINE_LOW,       // Low.
  XTRENDLINE_CLOSE,     // Close.
  XTRENDLINE_LAST,      // Last.
  FINAL_XTRENDLINE_MODE_ENTRY,
};

// Structs.

// Defines struct to store indicator parameter values.
struct IndiXTrendLineXParams : public IndicatorParams {
  // Indicator params.
  // Struct constructors.
  IndiXTrendLineXParams(int _shift = 0)
      : IndicatorParams(INDI_CUSTOM /*INDI_XTRENDLINE*/, FINAL_XTRENDLINE_MODE_ENTRY, TYPE_DOUBLE) {
#ifdef __resource__
    custom_indi_name = "::" + INDI_XTRENDLINE_PATH + "\\XTrendLineX";
#else
    custom_indi_name = "XTrendLineX";
#endif
    SetDataSourceType(IDATA_ICUSTOM);
    SetShift(_shift);
  };

  IndiXTrendLineXParams(IndiXTrendLineXParams &_params, ENUM_TIMEFRAMES _tf) {
    THIS_REF = _params;
    tf = _tf;
  }
};

/**
 * Implements indicator class.
 */
class Indi_XTrendLineX : public Indicator<IndiXTrendLineXParams> {
 public:
  /**
   * Class constructor.
   */
  Indi_XTrendLineX(IndiXTrendLineXParams &_p, IndicatorBase *_indi_src = NULL)
      : Indicator<IndiXTrendLineXParams>(_p, _indi_src) {}
  Indi_XTrendLineX(ENUM_TIMEFRAMES _tf = PERIOD_CURRENT) : Indicator(INDI_CUSTOM /*INDI_XTRENDLINE*/, _tf){};

  /**
   * Returns the indicator's value.
   *
   */
  IndicatorDataEntryValue GetEntryValue(int _mode = 0, int _shift = -1) {
    double _value = EMPTY_VALUE;
    int _ishift = _shift >= 0 ? _shift : iparams.GetShift();
    switch (iparams.idstype) {
      case IDATA_ICUSTOM:
        _value = iCustom(istate.handle, Get<string>(CHART_PARAM_SYMBOL), Get<ENUM_TIMEFRAMES>(CHART_PARAM_TF),
                         iparams.custom_indi_name, true, STYLE_DOT, 1, clrLimeGreen, clrRed, _mode, _ishift);
        break;
      default:
        SetUserError(ERR_INVALID_PARAMETER);
        _value = EMPTY_VALUE;
        break;
    }
    return _value;
  }

  /**
   * Checks if indicator entry values are valid.
   */
  virtual bool IsValidEntry(IndicatorDataEntry &_entry) {
    return Indicator<IndiXTrendLineXParams>::IsValidEntry(_entry) && _entry.GetMin<double>() > 0 &&
           _entry.values[(int)XTRENDLINE_HIGH].IsGt<double>(_entry[(int)XTRENDLINE_LOW]);
  }
};

#endif  // INDI_XTRENDLINE_MQH
