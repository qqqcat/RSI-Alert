# RSI Alert Final Edition
## (August 2025 Update - ADX Average Noise Filtering Support)

A powerful MetaTrader 5 Expert Advisor (EA) for multi-timeframe RSI reversal and divergence monitoring with advanced signal fusion noise reduction, ADX trend strength filtering, and bilingual support.

## 🌟 Key Features

- **Multi-timeframe RSI monitoring** - Monitor up to 4 different timeframes simultaneously (M30/H1/H4/D1 etc.)
- **ADX average filtering** - Alerts only in ranging/weak trend zones, filtering strong trend false signals
- **RSI reversal detection** - Automatic detection of oversold/overbought crossovers
- **Divergence analysis** - Advanced bullish and bearish divergence detection
- **Signal fusion mechanism** - Only strongest signal per bar across timeframes, avoiding duplicates
- **Triple noise filtering** - Integrated fractal patterns, extreme values, signal intervals, and ADX trend filtering
- **Bilingual interface** - Switch between Chinese and English interfaces
- **One-click controls** - Clear all signals and close all positions with single button clicks
- **Customizable alerts** - Optional popup and sound notifications
- **Clean UI design** - Horizontal button layout with real-time status display

## 📊 Signal Types

### RSI Reversal Signals
- **Bullish Crossover**: RSI crosses above oversold level (default: 30)
- **Bearish Crossover**: RSI crosses below overbought level (default: 70)

### Divergence Signals
- **Bullish Divergence** (底背离): Price makes lower lows while RSI makes higher lows
- **Bearish Divergence** (顶背离): Price makes higher highs while RSI makes lower highs

## ⚙️ Parameters

| Parameter | Description | Default | Recommended |
|-----------|-------------|---------|-------------|
| `RSI_Period` | RSI calculation period | 14 | 14 |
| `Oversold_Level` | Oversold threshold | 30.0 | 30 |
| `Overbought_Level` | Overbought threshold | 70.0 | 70 |
| `Extreme_Oversold` | Extreme oversold level for divergence | 20.0 | 20 |
| `Extreme_Overbought` | Extreme overbought level for divergence | 80.0 | 80 |
| `Lookback_Bars` | Number of bars to scan | 30 | 30 |
| `MinDivergenceGap` | Minimum gap between divergence points | 5 | 5 |
| `MinSignalInterval` | Minimum interval between same-direction signals | 8 | 8 |
| `ADX_Period` | **New**: ADX calculation period | 14 | 14 |
| `ADX_Threshold` | **New**: ADX average filter ceiling | 25.0 | 15-30 |
| `ADX_Avg_Window` | **New**: ADX average window | 5 | 3-8 |
| `TF1-TF4` | Monitoring timeframes (up to 4) | M30/H1/H4/D1 | Customize |
| `Sound_Alerts` | Enable popup/sound alerts | true | true/false |
| `Sound_File` | Sound file name | alert.wav | alert.wav |
| `Use_Chinese` | Use Chinese interface | false | true/false |

## 🎯 Installation

1. Copy `RSI Alert.mq5` to your MetaTrader 5 `MQL5/Experts` folder
2. Ensure the sound file (`alert.wav`) is in the `MQL5/Sounds` folder (if using sound alerts)
3. Restart MetaTrader 5 or refresh the Navigator
4. Drag the EA onto your desired chart

## 🖱️ Interface Controls

### Horizontal Button Bar
- **清除/Clear**: Remove all RSI and divergence signal markers from the chart
- **平仓/Close**: Close all positions for the current symbol
- **Status Bar**: Shows currently monitored timeframes

### Visual Signals
- **Green ↑ Arrow**: Bullish divergence or oversold crossover
- **Orange ↓ Arrow**: Bearish divergence or overbought crossover
- **Text Labels**: Show signal type, timeframe, and RSI value

## 🔧 Advanced Features

### ADX Average Trend Filtering (Core New Feature)
**Smart Trend Filtering System**: EA now integrates ADX (Average Directional Index) filtering mechanism:
- **Trend Strength Detection**: Real-time calculation of ADX average over recent N bars
- **Smart Filtering**: Only allow signals when ADX average is below set threshold
- **Avoid Counter-Trend Operations**: Effectively filter false reversal signals in strong trends
- **Focus on Ranging Zones**: Signals concentrated in ranging markets or trend decay zones, significantly improving accuracy

### Signal Fusion Mechanism
**Enhanced Feature**: The EA now implements intelligent signal fusion to eliminate duplicate alerts:
- **Unified Collection**: All timeframe signals are collected into a centralized cache
- **Priority Filtering**: Same bar, same-type signals only keep the highest timeframe
- **Quality Enhancement**: Higher timeframes typically provide more reliable signals
- **Duplicate Elimination**: Completely avoids multiple simultaneous alerts for the same market condition

### Triple Noise Reduction System
The EA implements sophisticated noise reduction through:
1. **Fractal Pattern Validation**: Signals only trigger on confirmed fractal tops/bottoms
2. **Extreme Value Requirements**: Divergences require extreme RSI levels
3. **Time Interval Filtering**: Prevents signal clustering with minimum interval settings
4. **ADX Trend Filtering**: Filter counter-trend signals in strong trends
5. **Signal Fusion**: Multi-timeframe deduplication for cleaner signal output

### Multi-Language Support
Switch between Chinese and English interfaces using the `Use_Chinese` parameter:
- `true` = Chinese interface (中文界面)
- `false` = English interface

### Alert System
Configurable alert system supporting:
- Visual popup alerts
- Sound notifications
- Log file output (always enabled)
- Complete silence mode for backtesting

## 📈 Usage Recommendations

### Optimal Settings
- **High Volatility Markets**: Increase `MinSignalInterval` to reduce noise, adjust `ADX_Threshold` to 20-25
- **Ranging Markets**: Lower `ADX_Threshold` to 15-20, increase signal sensitivity
- **Trending Markets**: Raise `ADX_Threshold` to 25-30, focus on filtering counter-trend signals
- **Instrument-Specific Optimization**:
  - Gold/Forex: ADX_Threshold = 20-25
  - Indices/Stocks: ADX_Threshold = 25-30

### Trading Strategy
- Use signals as **trading assistance**, not automated entry/exit points
- Combine with fundamental analysis and market structure
- Test thoroughly in demo environment before live trading
- Implement proper risk management and position sizing
- **ADX filtering significantly improves signal quality but reduces quantity**

### Timeframe Selection
Recommended timeframe combinations:
- **Day Trading**: M30, H1, H4
- **Swing Trading**: H1, H4, D1
- **Long-term Analysis**: H4, D1, W1

## ⚠️ Risk Disclaimer

- This EA is designed as a **signal detection tool**, not an automated trading system
- Divergence signals are contrarian in nature - use with proper risk management
- Always test in demo environment before live trading
- Past performance does not guarantee future results
- Consider market conditions, trends, and fundamental factors

## 🛠️ Technical Requirements

- **Platform**: MetaTrader 5
- **Language**: MQL5
- **Dependencies**: Trade.mqh library (included in MT5)
- **Chart Requirements**: Any chart with sufficient historical data

## 📝 Changelog

### Latest Version Features
- **New**: ADX average trend filtering - Signals only in ranging/weak trend zones, greatly reducing false positives
- **New**: Triple noise reduction system - Traditional filtering + Signal fusion + ADX filtering
- **Updated**: Monitoring timeframes adjusted to max 4 (TF1-TF4), optimizing performance
- Multi-timeframe RSI monitoring and advanced divergence detection
- Bilingual interface support
- One-click signal clearing and position management
- Customizable visual and audio alerts
- Clean, non-intrusive UI design

### ADX Filtering Enhancement
- Smart trend strength detection and filtering
- Customizable ADX threshold and averaging window
- Significantly improves signal quality, reduces false alerts
- Especially suitable for ranging markets and trend reversal capture

## 📝 Changelog

### Latest Version Features
- **NEW**: Signal fusion mechanism - eliminates duplicate alerts across timeframes
- Multi-timeframe RSI monitoring (up to 5 timeframes)
- Advanced divergence detection with noise filtering
- Bilingual interface support
- One-click signal clearing and position management
- Customizable visual and audio alerts
- Clean, non-intrusive UI design

### Signal Fusion Enhancement
- Unified signal collection across all monitored timeframes
- Automatic prioritization by timeframe hierarchy
- Elimination of simultaneous duplicate alerts
- Enhanced signal quality and reduced noise

## 🔍 Troubleshooting

### Common Issues

**Too few signals?**
- This may be normal behavior with ADX filtering active
- Appropriately raise `ADX_Threshold` (e.g., from 20 to 25)
- Increase `ADX_Avg_Window` for smoother filtering
- Adjust `Extreme_Oversold`/`Extreme_Overbought` thresholds

**How to verify ADX filtering effectiveness?**
- Check ADX filtering information in MT5 logs
- Compare signal quantity with/without ADX filtering
- Test different ADX parameters in Strategy Tester

**Buttons not displaying?**
- Ensure EA is in `MQL5/Experts` folder, not Indicators
- Check screen resolution and zoom settings
- Restart MetaTrader 5

**No sound alerts?**
- Verify `Sound_Alerts` parameter is set to `true`
- Check sound file exists in `MQL5/Sounds` folder
- Test MT5 sound settings

**Too many signals?**
- Increase `MinSignalInterval` value
- Raise `Extreme_Oversold`/`Extreme_Overbought` thresholds
- Reduce number of monitored timeframes
- The new signal fusion mechanism automatically reduces duplicate alerts

**Missing signals from certain timeframes?**
- This is normal behavior with signal fusion enabled
- Higher timeframes take priority over lower ones
- Check logs to see all detected signals before fusion

## 📞 Support

For technical issues or questions:
- Review the included technical documentation
- Check MT5 Experts log for error messages
- Ensure all parameters are within valid ranges

## 📄 License

This project is provided as-is for educational and trading purposes. Use at your own risk.

---

*Last Updated: August 2025*
