# RSI Alert Final Edition

A powerful MetaTrader 5 Expert Advisor (EA) for multi-timeframe RSI reversal and divergence monitoring with advanced noise filtering and bilingual support.

## 🌟 Key Features

- **Multi-timeframe RSI monitoring** - Monitor up to 5 different timeframes simultaneously
- **RSI reversal detection** - Automatic detection of oversold/overbought crossovers
- **Divergence analysis** - Advanced bullish and bearish divergence detection
- **Signal fusion mechanism** - Only strongest signal per bar across timeframes, avoiding duplicates
- **Advanced noise filtering** - Integrated filtering using fractal patterns, extreme values, and signal intervals
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
| `TF1-TF5` | Monitoring timeframes (up to 5) | M15/M30/H1/H4/D1 | Customize |
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

### Signal Fusion Mechanism
**New Enhancement**: The EA now implements intelligent signal fusion to eliminate duplicate alerts:
- **Unified Collection**: All timeframe signals are collected into a centralized cache
- **Priority Filtering**: Same bar, same-type signals only keep the highest timeframe
- **Quality Enhancement**: Higher timeframes typically provide more reliable signals
- **Duplicate Elimination**: Completely avoids multiple simultaneous alerts for the same market condition

### Noise Filtering System
The EA implements sophisticated noise reduction through:
1. **Fractal Pattern Validation**: Signals only trigger on confirmed fractal tops/bottoms
2. **Extreme Value Requirements**: Divergences require extreme RSI levels
3. **Time Interval Filtering**: Prevents signal clustering with minimum interval settings
4. **Signal Fusion**: Multi-timeframe deduplication for cleaner signal output

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
- **High Volatility Markets**: Increase `MinSignalInterval` to reduce noise
- **Trending Markets**: Focus on 2-4 complementary timeframes
- **Range-bound Markets**: Use standard settings with close monitoring

### Trading Strategy
- Use signals as **trading assistance**, not automated entry/exit points
- Combine with fundamental analysis and market structure
- Test thoroughly in demo environment before live trading
- Implement proper risk management and position sizing

### Timeframe Selection
Recommended timeframe combinations:
- **Scalping**: M1, M5, M15, M30
- **Day Trading**: M15, M30, H1, H4
- **Swing Trading**: H1, H4, D1, W1

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
