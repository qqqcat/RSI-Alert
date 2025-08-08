# Copilot Instructions for RSI-Alert (MT5 EA)

Purpose: Help AI coding agents work effectively in this MetaTrader 5 (MQL5) EA repo. Keep answers concrete and code-first.

## Project overview
- Type: MetaTrader 5 Expert Advisor (EA) written in MQL5.
- Primary file: `RSI Alert.mq5` — real-time, multi-timeframe RSI signal detector with:
  - Divergence detection (bullish/bearish), oversold/overbought crossovers.
  - ADX average window filtering (only signal when ADX mean < threshold).
  - Multi-timeframe signal fusion: per bar and per-type keep the highest timeframe only.
  - Lightweight UI: Clear/Close buttons + timeframe status label, bilingual text (CN/EN) via `Use_Chinese`.
- Secondary file: `RSI Optim Simple.mq5` — simplified, backtest/optimization-friendly auto-trader showcasing the RSI+ADX logic.
- Readmes: `README.md` (EN) and `README_CN.md` (CN) describe concepts and parameters.

## Architecture & flow (RSI Alert.mq5)
- Entry points:
  - `OnInit()` initializes timeframes, clears old markers, draws the UI panel.
  - `OnTick()` orchestrates scanning across TF1–TF4 by calling `AnalyzeTF(tf, idx)`, stores signals into a buffer, then calls `MergeAndDrawSignals()`.
  - `OnChartEvent()` handles button clicks for Clear/Close.
  - `OnDeinit()` removes UI objects.
- Signal pipeline:
  1) `AnalyzeTF` collects raw signals (bullish/bearish divergence; oversold/overbought crosses) into `sigbuf[]` only if ADX-average filter passes and spacing/filters are met.
  2) `MergeAndDrawSignals` deduplicates by (time, type) keeping the highest timeframe.
  3) `DrawSignal` renders arrows/text and triggers alerts (`Alert` + `PlaySound`) based on `Sound_Alerts` and `Sound_File`.
- State & data:
  - Global `tfs[4]` from `TF1..TF4` inputs; `lastBullishTime[]/lastBearishTime[]` enforce `MinSignalInterval` per-tf per-direction.
  - `sigbuf[1000]` temporary signal cache; cleared after merge/draw.
  - Uses MT5 built-ins: `iRSI`, `iADX`, `CopyBuffer`, `CopyClose`, `CopyTime`, `ObjectCreate/*`, `CTrade` for closing positions.

## Key parameters (inputs)
- RSI/thresholds: `RSI_Period`, `Oversold_Level`, `Overbought_Level`, `Extreme_Oversold`, `Extreme_Overbought`.
- Scan & spacing: `Lookback_Bars`, `MinDivergenceGap`, `MinSignalInterval`.
- ADX filtering: `ADX_Period`, `ADX_Threshold`, `ADX_Avg_Window`.
- Timeframes: `TF1..TF4` (ENUM_TIMEFRAMES). UI/alerts: `Sound_Alerts`, `Sound_File`, `Use_Chinese`.

## Conventions & patterns
- Timeframe string formatting uses `EnumToString(tf)` and `StringSubstr(..., 7)` to strip `PERIOD_`.
- UI object names prefixed with `RSI_`; cleanup removes objects containing `"RSI_", "Divergence", "Cross"`.
- Arrow codes: 233 for up, 234 for down; colors: `clrLime` (bullish), `clrOrange` (bearish).
- Signal types: `BullDiv`, `BearDiv`, `CrossUp`, `CrossDn`.
- ADX filter computed as simple mean of `ADX_Avg_Window` most recent values; block signals if mean > `ADX_Threshold`.
- Fusion rule: same bar+type across TFs → keep highest TF only (strict `==` on `datetime`).

## Developer workflows
- Build/deploy:
  - Copy `.mq5` files to `MQL5/Experts` in MetaTrader 5 data folder; compile in MetaEditor.
  - Attach `RSI Alert` EA to a chart for signals/alerts. For optimization/backtests, use `RSI Optim Simple` in Strategy Tester.
- Debugging:
  - Use Experts/Journal logs. The EA prints signal messages and ADX-filtered decisions are implicit in absence/presence of alerts.
  - UI test: click `Clear` to remove markers (`DeleteAllMarkers()`); `Close` calls `CloseAllPositions()` for current symbol via `CTrade`.
- Backtesting tips:
  - Prefer `RSI Optim Simple.mq5` for faster optimization; extends easily with more entry rules.
  - For higher determinism, throttle logic to bar-open if needed (see `RSI Optim Simple` pattern with `lastBarTime`).

## Safe extension points
- Add new signal types in `AnalyzeTF` → append to `CollectSignal(...)` with unique `type` string and rendering rules in `DrawSignal`.
- Extend fusion: modify `MergeAndDrawSignals()` to change priority (e.g., by signal quality) or time matching (tolerance around `datetime`).
- Add filters: compute more indicators inside `AnalyzeTF` and gate `allowSignal`.
- Internationalization: all user-facing strings pass through `Use_Chinese` ternaries; follow this pattern for new UI text.

## Gotchas & edge cases
- `CopyBuffer/CopyClose/CopyTime` require sufficient history per timeframe; guard with `<=0` checks as in code.
- `sigbuf` capped at 1000; avoid overflow in long sessions by frequent merges or larger buffer if adding more signals.
- Equality on `datetime` for fusion assumes bars align across TFs; keep types merged by exact open time; if mismatches appear, consider mapping to lower-TF bar time.
- Object name uniqueness: `TimeToString(..., TIME_MINUTES)` in names; collisions are unlikely but possible if multiple signals share minute—adjust if adding intrabar variants.

## File map
- `RSI Alert.mq5` — main EA (signals, UI, alerts, manual close/cleanup).
- `RSI Optim Simple.mq5` — simplified EA for Strategy Tester and example auto-trade entries.
- `README.md`, `README_CN.md` — parameter docs and operational guidance.

## Example: adding a MACD confirmation
- In `AnalyzeTF`, create `iMACD` handle; compute recent histogram mean.
- Set `allowSignal &= (macd_hist > 0)` for bullish or `< 0` for bearish before collecting.
- Update `DrawSignal` to label, e.g., `BullDiv+MACD`.

Keep instructions concise and specific to this repo. If something is unclear (e.g., preferred TF priority, additional filters), ask for clarification in a follow-up PR comment.
