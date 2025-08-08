//+------------------------------------------------------------------+
//|   RSI+ADX 多周期信号自动交易优化EA (简化版，便于参数优化)        |
//+------------------------------------------------------------------+
#property strict
#include <Trade\Trade.mqh>
CTrade trade;

input int    RSI_Period        = 14;
input double Oversold_Level    = 30.0;
input double Overbought_Level  = 70.0;
input double Extreme_Oversold  = 20.0;
input double Extreme_Overbought= 80.0;
input int    ADX_Period        = 14;
input double ADX_Threshold     = 25.0;
input int    ADX_Avg_Window    = 5;
input double Lots              = 0.1;
input double SL_Points         = 200;
input double TP_Points         = 400;

input ENUM_TIMEFRAMES TF1 = PERIOD_H1;
input ENUM_TIMEFRAMES TF2 = PERIOD_H4;
input ENUM_TIMEFRAMES TF3 = PERIOD_D1;

ENUM_TIMEFRAMES tfs[3];

//+------------------------------------------------------------------+
//| 初始化                                                           |
//+------------------------------------------------------------------+
int OnInit() { tfs[0]=TF1; tfs[1]=TF2; tfs[2]=TF3; return(INIT_SUCCEEDED); }

//+------------------------------------------------------------------+
//| 核心轮询:每根新K线处理一次                                      |
//+------------------------------------------------------------------+
datetime lastBarTime = 0;
void OnTick()
{
    if(Bars(_Symbol,_Period)<100) return;
    datetime curBar = iTime(_Symbol,_Period,0);
    if(curBar == lastBarTime) return;
    lastBarTime = curBar;
    for(int i=0; i<ArraySize(tfs); i++) if(tfs[i]>0) AnalyzeTF(tfs[i]);
}

void AnalyzeTF(ENUM_TIMEFRAMES tf)
{
    int rsiH = iRSI(_Symbol,tf,RSI_Period,PRICE_CLOSE); if(rsiH==INVALID_HANDLE) return;
    double rsiBuf[]; ArraySetAsSeries(rsiBuf,true);
    if(CopyBuffer(rsiH,0,0,3,rsiBuf)<=0) return;

    int adxH = iADX(_Symbol,tf,ADX_Period); if(adxH==INVALID_HANDLE) return;
    double adxBuf[]; ArraySetAsSeries(adxBuf,true);
    if(CopyBuffer(adxH,0,0,ADX_Avg_Window,adxBuf)<=0) return;
    double adxAvg=0; for(int i=0;i<ADX_Avg_Window;i++) adxAvg+=adxBuf[i];
    adxAvg/=ADX_Avg_Window;

    double price = iClose(_Symbol,tf,0);

    // 只举例RSI普通交叉（可扩展为背离等）
    if(rsiBuf[1]<Oversold_Level && rsiBuf[0]>Oversold_Level && adxAvg<ADX_Threshold)
    {
        if(!PositionSelect(_Symbol)) // 没有持仓才开多
            trade.Buy(Lots,_Symbol,price,price-SL_Points*_Point,price+TP_Points*_Point);
    }
    if(rsiBuf[1]>Overbought_Level && rsiBuf[0]<Overbought_Level && adxAvg<ADX_Threshold)
    {
        if(!PositionSelect(_Symbol)) // 没有持仓才开空
            trade.Sell(Lots,_Symbol,price,price+SL_Points*_Point,price-TP_Points*_Point);
    }
}
