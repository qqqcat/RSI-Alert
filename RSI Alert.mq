//+------------------------------------------------------------------+
//|         RSI Alert Final Edition (by ChatGPT, 手动语言切换)       |
//+------------------------------------------------------------------+
#property strict

#include <Trade\Trade.mqh>
CTrade trade;

//====================参数区====================
input int    RSI_Period        = 14;
input double Oversold_Level    = 30.0;
input double Overbought_Level  = 70.0;
input double Extreme_Oversold  = 20.0; // 极端超卖，底背离必须小于
input double Extreme_Overbought= 80.0; // 极端超买，顶背离必须大于
input int    Lookback_Bars     = 30;
input int    MinDivergenceGap  = 5;     // 顶/底背离最小间隔
input int    MinSignalInterval = 8;     // 最小信号重复间隔（K线）

input ENUM_TIMEFRAMES TF1 = PERIOD_M15;
input ENUM_TIMEFRAMES TF2 = PERIOD_M30;
input ENUM_TIMEFRAMES TF3 = PERIOD_H1;
input ENUM_TIMEFRAMES TF4 = PERIOD_H4;
input ENUM_TIMEFRAMES TF5 = PERIOD_D1;

input bool   Sound_Alerts     = true;
input string Sound_File       = "alert.wav";
input bool   Use_Chinese      = false;   // <--- 手动语言切换

//====================全局变量====================
ENUM_TIMEFRAMES tfs[5];
datetime lastBullishTime[5];
datetime lastBearishTime[5];

#define BTN_WIDTH 60
#define BTN_HEIGHT 26
#define BTN_PAD   10
#define STATUS_PAD 6
#define BTN_FONT  "Arial"
#define BTN_SIZE  11

//+------------------------------------------------------------------+
//| 初始化                                                           |
//+------------------------------------------------------------------+
int OnInit()
{
    tfs[0]=TF1; tfs[1]=TF2; tfs[2]=TF3; tfs[3]=TF4; tfs[4]=TF5;
    ArrayInitialize(lastBullishTime,0); ArrayInitialize(lastBearishTime,0);
    DeleteAllMarkers();
    DrawPanel();
    return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
    ObjectDelete(0,"RSI_Clear");
    ObjectDelete(0,"RSI_CloseAll");
    ObjectDelete(0,"RSI_Status");
}

//+------------------------------------------------------------------+
//| 核心轮询                                                         |
//+------------------------------------------------------------------+
void OnTick()
{
    DrawPanel();
    for(int i=0; i<ArraySize(tfs); i++) AnalyzeTF(tfs[i], i);
}

//+------------------------------------------------------------------+
//| 顶部横排按钮及状态栏                                             |
//+------------------------------------------------------------------+
void DrawPanel()
{
    int w = (int)ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
    int total_width = 2*BTN_WIDTH+BTN_PAD*3;
    int y = 12;
    int x = w/2 - total_width/2;

    // Clear按钮
    string labelClear = Use_Chinese?" 清除 ":" Clear ";
    ObjectCreate(0,"RSI_Clear",OBJ_BUTTON,0,0,0);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_XDISTANCE,x);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_YDISTANCE,y);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_WIDTH,BTN_WIDTH);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_YSIZE,BTN_HEIGHT);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_BGCOLOR,clrLightSkyBlue);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_COLOR,clrWhite);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_FONTSIZE,BTN_SIZE);
    ObjectSetString(0,"RSI_Clear",OBJPROP_TEXT,labelClear);
    ObjectSetInteger(0,"RSI_Clear",OBJPROP_BORDER_TYPE,BORDER_FLAT);

    // Close按钮
    string labelClose = Use_Chinese?" 平仓 ":" Close ";
    ObjectCreate(0,"RSI_CloseAll",OBJ_BUTTON,0,0,0);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_XDISTANCE,x+BTN_WIDTH+BTN_PAD);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_YDISTANCE,y);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_WIDTH,BTN_WIDTH);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_YSIZE,BTN_HEIGHT);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_BGCOLOR,clrIndianRed);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_COLOR,clrWhite);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_FONTSIZE,BTN_SIZE);
    ObjectSetString(0,"RSI_CloseAll",OBJPROP_TEXT,labelClose);
    ObjectSetInteger(0,"RSI_CloseAll",OBJPROP_BORDER_TYPE,BORDER_FLAT);

    // 状态栏
    string tfStr="";
    for(int i=0;i<5;i++) if(tfs[i]>0) tfStr+=StringSubstr(EnumToString(tfs[i]),7)+" ";
    string status = (Use_Chinese?"周期: ":"TF: ")+tfStr;
    ObjectCreate(0,"RSI_Status",OBJ_LABEL,0,0,0);
    ObjectSetInteger(0,"RSI_Status",OBJPROP_XDISTANCE,x+2*BTN_WIDTH+BTN_PAD*2+STATUS_PAD);
    ObjectSetInteger(0,"RSI_Status",OBJPROP_YDISTANCE,y+3);
    ObjectSetInteger(0,"RSI_Status",OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetInteger(0,"RSI_Status",OBJPROP_FONTSIZE,11);
    ObjectSetInteger(0,"RSI_Status",OBJPROP_COLOR,clrAqua);
    ObjectSetString(0,"RSI_Status",OBJPROP_TEXT,status);
}

//+------------------------------------------------------------------+
//| 处理按钮点击                                                     |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
{
    if(id==CHARTEVENT_OBJECT_CLICK)
    {
        if(sparam=="RSI_Clear") DeleteAllMarkers();
        if(sparam=="RSI_CloseAll") CloseAllPositions();
    }
}

//+------------------------------------------------------------------+
//| 删除所有RSI标记                                                  |
//+------------------------------------------------------------------+
void DeleteAllMarkers()
{
    int total=ObjectsTotal(0,0,-1);
    for(int i=total-1;i>=0;i--)
    {
        string name=ObjectName(0,i,0,-1);
        if(StringFind(name,"RSI_")!=-1 || StringFind(name,"Divergence")!=-1 || StringFind(name,"Cross")!=-1)
            ObjectDelete(0,name);
    }
}

//+------------------------------------------------------------------+
//| 一键清仓                                                         |
//+------------------------------------------------------------------+
void CloseAllPositions()
{
    for(int i=PositionsTotal()-1;i>=0;i--)
    {
        ulong ticket=PositionGetTicket(i);
        string symb=PositionGetSymbol(i);
        if(symb==_Symbol)
        {
            long type; PositionGetInteger(POSITION_TYPE,type);
            if(type==POSITION_TYPE_BUY)  trade.PositionClose(ticket);
            if(type==POSITION_TYPE_SELL) trade.PositionClose(ticket);
        }
    }
}

//+------------------------------------------------------------------+
//| 多周期RSI+背离信号检测(含降噪)                                   |
//+------------------------------------------------------------------+
void AnalyzeTF(ENUM_TIMEFRAMES tf, int idx)
{
    int rsiH = iRSI(_Symbol,tf,RSI_Period,PRICE_CLOSE); if(rsiH==INVALID_HANDLE) return;
    double rsiBuf[]; ArraySetAsSeries(rsiBuf,true);
    if(CopyBuffer(rsiH,0,0,Lookback_Bars,rsiBuf)<=0) return;
    double closes[]; ArraySetAsSeries(closes,true);
    if(CopyClose(_Symbol,tf,0,Lookback_Bars,closes)<=0) return;
    datetime times[]; ArraySetAsSeries(times,true);
    if(CopyTime(_Symbol,tf,0,Lookback_Bars,times)<=0) return;

    // 多重过滤降噪，先找背离信号
    //------底背离（极端超卖+分型+分段+间隔限制）------
    for(int i=MinDivergenceGap; i<Lookback_Bars-MinDivergenceGap; i++)
    {
        //分型底且RSI极低且与前一分型有间隔
        bool isFractal = (closes[i]<closes[i-1] && closes[i]<closes[i+1]);
        bool isExtreme = (rsiBuf[i]<Extreme_Oversold && rsiBuf[i]<Oversold_Level);
        bool enoughGap = (times[i]-lastBullishTime[idx]>PeriodSeconds(tf)*MinSignalInterval);

        // 背离形态要求：当前底点高于左侧底点，且RSI低点更低
        bool isDivergence = (closes[i]>closes[i-MinDivergenceGap] && rsiBuf[i]<rsiBuf[i-MinDivergenceGap]);

        if(isFractal && isExtreme && enoughGap && isDivergence)
        {
            Notify(tf, Use_Chinese?"底背离":"Bullish Divergence", times[i], closes[i], clrLime, rsiBuf[i], 233);
            lastBullishTime[idx]=times[i];
            break; //同一周期只标一次
        }
    }
    //------顶背离（极端超买+分型+分段+间隔限制）------
    for(int i=MinDivergenceGap; i<Lookback_Bars-MinDivergenceGap; i++)
    {
        bool isFractal = (closes[i]>closes[i-1] && closes[i]>closes[i+1]);
        bool isExtreme = (rsiBuf[i]>Extreme_Overbought && rsiBuf[i]>Overbought_Level);
        bool enoughGap = (times[i]-lastBearishTime[idx]>PeriodSeconds(tf)*MinSignalInterval);

        // 背离形态要求：当前顶点低于左侧顶点，且RSI高点更高
        bool isDivergence = (closes[i]<closes[i-MinDivergenceGap] && rsiBuf[i]>rsiBuf[i-MinDivergenceGap]);
        if(isFractal && isExtreme && enoughGap && isDivergence)
        {
            Notify(tf, Use_Chinese?"顶背离":"Bearish Divergence", times[i], closes[i], clrOrange, rsiBuf[i], 234);
            lastBearishTime[idx]=times[i];
            break;
        }
    }
    //------普通交叉------
    if(rsiBuf[1]<Oversold_Level && rsiBuf[0]>Oversold_Level)
        Notify(tf, (Use_Chinese?"上穿超卖":"CrossUp"), times[0], closes[0], clrLime, rsiBuf[0], 233);
    if(rsiBuf[1]>Overbought_Level && rsiBuf[0]<Overbought_Level)
        Notify(tf, (Use_Chinese?"下穿超买":"CrossDn"), times[0], closes[0], clrOrange, rsiBuf[0], 234);
}

//+------------------------------------------------------------------+
//| 画箭头、弹窗、声音、文字                                         |
//+------------------------------------------------------------------+
void Notify(ENUM_TIMEFRAMES tf, string label, datetime t, double price, color col, double rsiValue, int arrowcode)
{
    string tfstr=StringSubstr(EnumToString(tf),7);
    string objName=StringFormat("RSI_%s_%s_%s",label,tfstr,TimeToString(t,TIME_MINUTES));
    // 箭头
    ObjectCreate(0,objName,OBJ_ARROW,0,t,price);
    ObjectSetInteger(0,objName,OBJPROP_COLOR,col);
    ObjectSetInteger(0,objName,OBJPROP_WIDTH,2);
    ObjectSetInteger(0,objName,OBJPROP_ARROWCODE,arrowcode); // 233↑ 234↓
    // 文字
    string txt=objName+"_txt";
    ObjectCreate(0,txt,OBJ_TEXT,0,t,price*1.0012);
    ObjectSetInteger(0,txt,OBJPROP_COLOR,col);
    ObjectSetInteger(0,txt,OBJPROP_FONTSIZE,9);
    ObjectSetString(0,txt,OBJPROP_TEXT,label+" "+tfstr+" RSI:"+DoubleToString(rsiValue,1));
    // 报警
    string msg=label+" "+tfstr+" "+DoubleToString(price,4)+" RSI:"+DoubleToString(rsiValue,1);
    if(Sound_Alerts) {
        Alert(msg);
        PlaySound(Sound_File);
    }
    Print(msg);
}
