RSI Alert Final Edition 使用技术文档
1. 功能简介
本EA支持多周期 RSI 反转、顶底背离自动监控。
可手动切换中文/英文界面，集成降噪（形态+极值+间隔）过滤，图表横排按钮极简操作。
支持一键清除信号标记、一键清仓。所有弹窗及声音提醒可关闭。

2. 主要参数说明
参数名	含义	推荐设置
RSI_Period	RSI周期	14
Oversold_Level	超卖阈值	30
Overbought_Level	超买阈值	70
Extreme_Oversold	极端超卖，仅底背离有效	20
Extreme_Overbought	极端超买，仅顶背离有效	80
Lookback_Bars	扫描回看K线数	30
MinDivergenceGap	背离两极点最小间隔	5
MinSignalInterval	同方向最小信号间隔（K线数）	8
TF1...TF5	监控时间周期，最多5个	M15/H1/H4等
Sound_Alerts	是否开启弹窗/声音提醒	true/false
Sound_File	声音文件名	alert.wav
Use_Chinese	是否中文界面	true/false

3. 功能与界面说明
3.1 图表横排按钮
“清除”/“Clear”：一键清除所有RSI和背离信号标记

“平仓”/“Close”：一键平掉当前品种所有持仓

周期状态栏：实时显示当前监控周期（可自行设置/切换）

3.2 信号标记
底背离（Bullish Divergence）：绿色↑箭头+说明

顶背离（Bearish Divergence）：橙色↓箭头+说明

RSI反弹穿越/回落：自动标记关键反转点

3.3 降噪与信号过滤
背离仅在极端超卖/超买、且分型成立、与上次信号间隔充分时触发，极大降低重复/虚假信号

每个周期独立计数、独立监控

3.4 多语言手动切换
通过参数Use_Chinese控制显示语言（true=中文，false=英文）

3.5 警报/声音提醒
通过参数Sound_Alerts控制。设为false时不弹窗不响铃，只日志输出

4. 典型用法建议
建议仅选择2-4个常用周期组合

高波动市场建议提高MinSignalInterval降低杂音

结合主观判断，用信号作交易辅助，而非全自动买卖

支持在模拟盘环境全功能回测

5. 关键代码片段说明
Sound_Alerts 实际控制弹窗和声音：

mql
Copy
Edit
void Notify(...) {
    ...
    if(Sound_Alerts) {
        Alert(msg);
        PlaySound(Sound_File);
    }
    Print(msg); // 总是输出日志
}
6. 注意事项
请确保EA运行在MQL5/Experts目录，不要用indicator_chart_window等指标声明

按钮如未显示，可调整分辨率或缩放

各周期参数可以随时修改后重新加载
7. 技术原理与信号判据
7.1 RSI反转/穿越信号
超卖反弹：RSI[1] < Oversold_Level 且 RSI[0] > Oversold_Level，即最新一根K线RSI刚刚上穿超卖阈值。

超买回落：RSI[1] > Overbought_Level 且 RSI[0] < Overbought_Level，即最新一根K线RSI刚刚下穿超买阈值。

该信号常用于捕捉RSI极端状态下的短期反弹或回调，属于传统RSI系统的“警戒”类信号。

7.2 背离形态判据
7.2.1 底背离（Bullish Divergence）
价格形成分型底：Close[i] < Close[i-1] && Close[i] < Close[i+1]（三点分型）

RSI极端低位：RSI[i] < Extreme_Oversold && RSI[i] < Oversold_Level

与上一个信号间隔足够：当前点与上次底背离信号的时间戳之差大于MinSignalInterval*周期秒数

价格背离：当前底点价格 > 前MinDivergenceGap根K线前的底点价格，且RSI更低

全部成立才会触发信号，以最大程度去除震荡区假背离

7.2.2 顶背离（Bearish Divergence）
价格形成分型顶：Close[i] > Close[i-1] && Close[i] > Close[i+1]

RSI极端高位：RSI[i] > Extreme_Overbought && RSI[i] > Overbought_Level

间隔与去噪、RSI背离要求同底背离

降噪机制总结：
仅在极端超买/超卖、分型明确且距离上次信号有充分时间的K线上判定背离，有效过滤微震荡和虚假背离。

8. UI美化与交互细节
8.1 图表按钮和状态栏
极简配色：按钮采用clrLightSkyBlue（淡蓝）/clrIndianRed（红），字体白色，避免高对比度刺激

横排布局：居中顶栏，按钮与状态栏左右留白，避免遮挡K线主要区域

状态栏：自动汇总所有已选周期，实时显示

支持中英双语：所有UI元素随参数切换即时响应

8.2 标记风格
背离信号：用绿色（底背离↑233）/橙色（顶背离↓234）箭头，贴合传统交易习惯

文字说明：每个信号附带周期、RSI值说明（如“Bullish Divergence H1 RSI:19.4”），方便回测/对照

自动排布：标记与K线实际收盘价略有偏移，防止遮挡K线

8.3 交互与可扩展
一键清除：按钮响应快，可多次点击

一键清仓：仅针对当前品种，调用标准MQL5 CTrade.PositionClose

无弹窗/无声音时：仅日志输出，不干扰盘面

9. 代码二次开发与定制扩展建议
9.1 周期与参数扩展
可直接添加更多周期（如周线、月线）到 tfs 数组，实现多周期共振监控

参数暴露完整，适合用于优化、回测和微调

9.2 信号复合/并联
可将 Notify 拓展为多策略并行（如结合MACD、CCI等共振信号）

亦可引入持仓过滤、趋势判断，提高信号置信度

9.3 UI功能升级
状态栏可扩展为信号统计板（今日/本周信号次数、胜率等）

支持按钮自定义配色、样式，兼容深色/浅色主题

可加入快捷键响应（如Ctrl+Q清除信号等）

9.4 日志与记录
当前所有信号均Print到MT5日志，可很方便用于历史分析

可进一步扩展为写入CSV/外部文件，便于长期统计

10. 策略适用性与风险提示
背离信号本质为“逆势超跌反弹博弈”，不宜盲目全信号进场，宜结合大周期趋势、资金管理、风控配合

建议配合主观盘感、结构形态综合研判使用

实盘建议先低仓位验证，避免过度信号追单

11. 常见问题与调试建议
信号密集？
可适当调大 MinDivergenceGap 和 MinSignalInterval，并提高 Extreme_Oversold / Extreme_Overbought 阈值。

UI遮挡？
可增大按钮上方边距、或移动至其他角落。

按钮不显示？
检查EA是否运行在MQL5/Experts，不要误用为指标。

不弹窗？
检查Sound_Alerts，或测试MT5声音/弹窗设置。