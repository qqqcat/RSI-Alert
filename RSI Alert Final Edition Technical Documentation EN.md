# RSI Alert Final Edition Technical Documentation

## 📋 Table of Contents

- [Features Overview](#features-overview)
- [Main Parameters](#main-parameters)
- [Functions and Interface](#functions-and-interface)
- [Typical Usage Guidelines](#typical-usage-guidelines)
- [Key Code Snippets](#key-code-snippets)
- [Important Notes](#important-notes)
- [MetaTrader 5 Compatibility](#metatrader-5-compatibility)
- [Technical Principles and Signal Criteria](#technical-principles-and-signal-criteria)
- [UI Design and Interaction Details](#ui-design-and-interaction-details)
- [Secondary Development and Customization](#secondary-development-and-customization)
- [Strategy Applicability and Risk Warnings](#strategy-applicability-and-risk-warnings)
- [Common Issues and Troubleshooting](#common-issues-and-troubleshooting)

---

## 🚀 Features Overview

This EA supports multi-timeframe RSI reversal and bullish/bearish divergence automatic monitoring.

### Core Features

- ✅ Manual Chinese/English interface switching
- ✅ Integrated noise reduction (pattern + extreme + interval) filtering
- ✅ **Signal Fusion Mechanism**: Only keep strongest signal per bar across timeframes
- ✅ Minimalist horizontal button operations on charts
- ✅ One-click signal clearing and position closing
- ✅ All popup and sound alerts can be disabled
- ✅ **Fully compatible with MetaTrader 5 platform**

---

## ⚙️ Main Parameters

| Parameter | Description | Recommended Setting |
|-----------|-------------|---------------------|
| **RSI_Period** | RSI period | `14` |
| **Oversold_Level** | Oversold threshold | `30` |
| **Overbought_Level** | Overbought threshold | `70` |
| **Extreme_Oversold** | Extreme oversold, effective only for bullish divergence | `20` |
| **Extreme_Overbought** | Extreme overbought, effective only for bearish divergence | `80` |
| **Lookback_Bars** | Number of bars to scan back | `30` |
| **MinDivergenceGap** | Minimum gap between divergence extremes | `5` |
| **MinSignalInterval** | Minimum signal interval in same direction (bars) | `8` |
| **TF1...TF5** | Monitoring timeframes, up to 5 | `M15/H1/H4 etc` |
| **Sound_Alerts** | Enable popup/sound alerts | `true/false` |
| **Sound_File** | Sound file name | `alert.wav` |
| **Use_Chinese** | Use Chinese interface | `true/false` |

---

## 💻 Functions and Interface

### 🖱️ Chart Horizontal Buttons

- **"Clear"**: One-click removal of all RSI and divergence signal markers
- **"Close"**: One-click closure of all positions for current symbol
- **Timeframe Status Bar**: Real-time display of current monitoring timeframes (customizable)

### 📊 Signal Markers

- **Bullish Divergence**: 🟢 Green ↑ arrow + description
- **Bearish Divergence**: 🟠 Orange ↓ arrow + description
- **RSI Bounce/Retreat**: Automatic marking of key reversal points

### 🔧 Noise Reduction and Signal Filtering

#### Traditional Noise Reduction
- Divergence triggers only under extreme oversold/overbought conditions with established patterns and sufficient interval from last signal, greatly reducing duplicate/false signals
- Each timeframe operates independently with separate counting and monitoring

#### 🎯 Signal Fusion Mechanism (New)
- **Unified Collection**: All monitored timeframe signals are collected into a unified cache
- **Smart Filtering**: For same bar same-type signals (bullish/bearish divergence), only keep the **highest timeframe** signal
- **Avoid Duplicates**: Completely eliminate duplicate signal alerts at the same time point
- **Enhanced Quality**: Higher timeframe signals are typically more reliable with higher priority

> 📊 **Working Principle**: When each bar completes, the system checks if multiple timeframes generated same-type signals on that bar, automatically keeps the largest timeframe signal (e.g., H4 over H1, H1 over M15), discards other signals, and only fused signals trigger alerts and chart markers.

### 🌐 Manual Language Switching

- Control display language through `Use_Chinese` parameter (`true=Chinese`, `false=English`)

### 🔔 Alert/Sound Notifications

- Controlled by `Sound_Alerts` parameter
- When set to `false`, no popups or sounds, only log output

---

## 📝 Typical Usage Guidelines

> 💡 **Best Practice Guide**

1. **Timeframe Selection**: Recommend selecting only 2-4 common timeframe combinations
2. **Noise Reduction**: In high volatility markets, increase `MinSignalInterval` to reduce noise
3. **Trading Strategy**: Use signals as trading assistance combined with subjective judgment, not for fully automated trading
4. **Backtesting**: Supports full functionality backtesting in demo environments

---

## 🔍 Key Code Snippets

`Sound_Alerts` actually controls popups and sounds:

```mql5
void Notify(...) {
    ...
    if(Sound_Alerts) {
        Alert(msg);
        PlaySound(Sound_File);
    }
    Print(msg); // Always output to log
}
```

---

## ⚠️ Important Notes

> ⚡ **Important Reminders**

- ✅ Ensure EA runs in `MQL5/Experts` directory, do not use `indicator_chart_window` or other indicator declarations
- ✅ If buttons don't display, adjust resolution or scaling
- ✅ All timeframe parameters can be modified and reloaded at any time

---

## 🔧 MetaTrader 5 Compatibility

### Platform Requirements

- **Supported Version**: MetaTrader 5 (Build 2000+)
- **Operating System**: Windows 7/8/10/11, macOS, Linux
- **Architecture Support**: Compatible with both 32-bit and 64-bit systems

### Installation and Deployment

#### 1. File Location

```
MetaTrader 5/
├── MQL5/
│   ├── Experts/
│   │   └── RSI Alert.mq5  ← EA main file
│   ├── Include/
│   └── Libraries/
└── Sounds/
    └── alert.wav  ← Sound file (optional)
```

#### 2. Compilation Requirements

- **MQL5 Language**: Completely uses standard MQL5 syntax
- **Compiler**: MetaEditor built-in compiler
- **Dependencies**: Uses only MT5 standard libraries, no third-party dependencies

#### 3. Permission Settings

Enable the following permissions in MT5:

- ✅ **Allow Algorithmic Trading**: Tools → Options → Expert Advisors → Allow algorithmic trading
- ✅ **Allow DLL Import**: Not required (this EA has no DLL dependencies)
- ✅ **Allow Import of External Expert Advisors**: If needed

### Compatibility Features

#### Market Compatibility

- ✅ **Forex Market**: All major currency pairs
- ✅ **Precious Metals**: Gold, silver, etc.
- ✅ **Indices**: Stock index CFDs
- ✅ **Commodities**: Crude oil, natural gas, etc.
- ✅ **Stocks**: Individual stock CFDs
- ✅ **Cryptocurrencies**: Bitcoin and other digital assets

#### Account Types

- ✅ **Standard Accounts**: Full support
- ✅ **ECN Accounts**: Full support
- ✅ **Demo Accounts**: Full support, recommended for initial testing

#### Timeframes

Supports all MT5 standard timeframes:

| Timeframe | Code | Support Status |
|-----------|------|----------------|
| 1 Minute | M1 | ✅ |
| 5 Minutes | M5 | ✅ |
| 15 Minutes | M15 | ✅ |
| 30 Minutes | M30 | ✅ |
| 1 Hour | H1 | ✅ |
| 4 Hours | H4 | ✅ |
| Daily | D1 | ✅ |
| Weekly | W1 | ✅ |
| Monthly | MN1 | ✅ |

### Performance Optimization

#### Resource Usage

- **CPU Usage**: Less than 5% (under normal market conditions)
- **Memory Usage**: Less than 50MB
- **Network Traffic**: Receives only necessary price data

#### Optimization Recommendations

1. **Simultaneous Monitoring Timeframes**: Recommend no more than 5 timeframes
2. **Historical Data**: Ensure at least 1000 bars of history
3. **Server Connection**: Maintain stable network connection

### Troubleshooting

#### Common Issues

**Issue 1: EA Cannot Load**
```
Solutions:
1. Check if file is in correct directory
2. Recompile the EA
3. Check if MT5 version is supported
```

**Issue 2: Buttons Don't Display**
```
Solutions:
1. Adjust chart display scale
2. Check if Expert Advisors are enabled
3. Restart MT5 terminal
```

**Issue 3: No Signals Appear**
```
Solutions:
1. Check if parameter settings are reasonable
2. Confirm sufficient historical data
3. Check if market is open
```

#### Technical Support

For compatibility issues:

1. **Log Check**: Review MT5 Expert Advisor logs
2. **Version Confirmation**: Confirm MT5 version number
3. **Parameter Validation**: Check all parameter settings

> 📝 **Note**: This EA is completely developed based on MQL5 standards, 100% compatible with MT5 platform, with no dependencies on third-party libraries or plugins.

---

## 🔬 Technical Principles and Signal Criteria

### 7.1 RSI Reversal/Cross Signals

#### Oversold Bounce

```
RSI[1] < Oversold_Level and RSI[0] > Oversold_Level
```

The latest bar's RSI just crossed above the oversold threshold.

#### Overbought Retreat

```
RSI[1] > Overbought_Level and RSI[0] < Overbought_Level
```

The latest bar's RSI just crossed below the overbought threshold.

> These signals are commonly used to capture short-term bounces or pullbacks during RSI extreme conditions, belonging to "alert" type signals in traditional RSI systems.

### 7.2 Divergence Pattern Criteria

#### 7.2.1 Bullish Divergence

Judgment Conditions:

1. **Price Forms Fractal Bottom**: `Close[i] < Close[i-1] && Close[i] < Close[i+1]` (three-point fractal)
2. **RSI Extreme Low**: `RSI[i] < Extreme_Oversold && RSI[i] < Oversold_Level`
3. **Sufficient Interval from Last Signal**: Time difference between current point and last bullish divergence signal exceeds `MinSignalInterval * timeframe seconds`
4. **Price Divergence**: Current bottom price > bottom price from `MinDivergenceGap` bars ago, with lower RSI

> All conditions must be met to trigger signal, maximizing removal of false divergences in ranging markets

#### 7.2.2 Bearish Divergence

Judgment Conditions:

1. **Price Forms Fractal Top**: `Close[i] > Close[i-1] && Close[i] > Close[i+1]`
2. **RSI Extreme High**: `RSI[i] > Extreme_Overbought && RSI[i] > Overbought_Level`
3. **Interval and Noise Reduction, RSI Divergence Requirements**: Same as bullish divergence

#### 📊 Noise Reduction Mechanism Summary

**Traditional Noise Reduction**: Divergence is determined only on bars with extreme overbought/oversold conditions, clear fractals, and sufficient time from last signal, effectively filtering micro-oscillations and false divergences.

**Signal Fusion Noise Reduction**: Building on traditional noise reduction, adds multi-timeframe signal fusion mechanism:
1. **Cache Collection**: All monitored timeframe signals first enter unified cache
2. **Priority Sorting**: Sort by timeframe size (Monthly>Weekly>Daily>4H>1H>15M etc.)
3. **Same-type Filtering**: Same bar same-type signals only keep highest timeframe
4. **Final Output**: Only fused signals trigger alerts and markers

> 🎯 **Effect**: Completely avoids "multiple timeframes alerting simultaneously" duplicate interference, significantly improving signal quality and user experience.

---

## 🎨 UI Design and Interaction Details

### 8.1 Chart Buttons and Status Bar

- **Minimalist Colors**: Buttons use `clrLightSkyBlue` (light blue)/`clrIndianRed` (red), white text, avoiding high-contrast stimulation
- **Horizontal Layout**: Centered top bar, buttons and status bar with left-right margins, avoiding obstruction of main candlestick area
- **Status Bar**: Automatically summarizes all selected timeframes, real-time display
- **Bilingual Support**: All UI elements respond instantly to parameter switching

### 8.2 Marker Styles

- **Divergence Signals**: Use green (bullish divergence ↑233)/orange (bearish divergence ↓234) arrows, adhering to traditional trading habits
- **Text Description**: Each signal includes timeframe and RSI value description (e.g., "Bullish Divergence H1 RSI:19.4"), convenient for backtesting/comparison
- **Auto Layout**: Markers slightly offset from actual candlestick closing prices to prevent obstruction

### 8.3 Interaction and Extensibility

- **One-Click Clear**: Fast button response, multiple clicks supported
- **One-Click Close**: Only for current symbol, calls standard MQL5 `CTrade.PositionClose`
- **No Popup/No Sound Mode**: Only log output, no interference with chart

---

## 🛠️ Secondary Development and Customization

### 9.1 Timeframe and Parameter Extension

- Can directly add more timeframes (like weekly, monthly) to `tfs` array for multi-timeframe resonance monitoring
- Complete parameter exposure, suitable for optimization, backtesting, and fine-tuning

### 9.2 Signal Combination/Parallel

- Can extend `Notify` for multi-strategy parallel operation (combining MACD, CCI and other resonance signals)
- Can introduce position filtering and trend judgment to improve signal confidence
- **Signal Fusion Mechanism** can serve as template for extending to other signal types deduplication

### 9.3 Signal Fusion Algorithm Optimization

- Can customize timeframe priority weights, not only by time period but also by success rate
- Can add signal strength scoring system, combining RSI deviation, price divergence magnitude and other factors
- Can extend to cross-strategy signal fusion (e.g., RSI+MACD+Bollinger Bands comprehensive signals)

### 9.3 UI Function Upgrades

- Status bar can be extended to signal statistics board (today/this week signal count, win rate, etc.)
- Support custom button colors and styles, compatible with dark/light themes
- Can add shortcut key responses (like `Ctrl+Q` to clear signals)

### 9.4 Logging and Recording

- All signals currently Print to MT5 logs, very convenient for historical analysis
- Can be further extended to write CSV/external files for long-term statistics

---

## ⚖️ Strategy Applicability and Risk Warnings

> ⚠️ **Important Warnings**

- Divergence signals are essentially **"contrarian oversold bounce speculation"**, should not blindly enter on all signals
- Should be combined with major timeframe trends, money management, and risk control
- Recommend combining with subjective market sense and structural pattern comprehensive analysis
- For live trading, recommend starting with low position sizes to avoid excessive signal chasing

---

## ❓ Common Issues and Troubleshooting

### Signals Too Dense?

Appropriately increase `MinDivergenceGap` and `MinSignalInterval`, and raise `Extreme_Oversold` / `Extreme_Overbought` thresholds.

### UI Obstruction?

Increase button top margin or move to other corners.

### Buttons Not Displaying?

Check if EA is running in `MQL5/Experts`, not mistakenly used as indicator. Also confirm:
- MT5 version is Build 2000+
- Algorithmic trading permissions are enabled
- Chart display scale is appropriate

### No Popups?

Check `Sound_Alerts`, or test MT5 sound/popup settings. Ensure:
- MT5 terminal sound settings are enabled
- System volume settings are normal
- `alert.wav` file exists in Sounds directory

---

## 📞 Support and Contact

For questions or suggestions, please contact the developer or refer to relevant documentation.

---

*Last Updated: August 2025*
