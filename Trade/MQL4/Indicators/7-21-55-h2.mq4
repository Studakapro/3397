#property indicator_chart_window
#property indicator_buffers 8
#property indicator_color1 C'155,208,225'
#property indicator_width1 12
#property indicator_color2 Thistle
#property indicator_width2 12
#property indicator_color3 DarkOrange
#property indicator_width3 2
#property indicator_color4 FireBrick
#property indicator_width4 1
#property indicator_color5 DodgerBlue
#property indicator_width5 1
#property indicator_color6 Snow
#property indicator_width6 2
#property indicator_color7 Blue
#property indicator_width7 2
#property indicator_color8 Red
#property indicator_width8 2
extern int Fast=5;
extern int Middle=21;
extern int Slow=55;
extern int Slowest=233;
extern bool ShowArrows=true;
extern bool ShowHistogram=true;
extern bool ShowCross_5_21=false;
extern bool ShowCross_5_55=true;
extern bool ShowCross_21_55=true;
extern bool ShowCross_55_233=true;
extern string note="0- 5-21;  1- 5-55;  2- 21-55;  3- 55-233";
extern int  Histogram=2;
extern bool  ShowAlert=true;
extern int BarsCount = 1000;
double Map5[], Map21[], Map55[], Map22[], Map56[], Ma233[], MapUp[], MapDn[];
 int key;
//+------------------------------------------------------------------+
int init()  {
   IndicatorDigits(Digits+1);
   if(Histogram<0 || Histogram>3)  Histogram=2;
   if(ShowHistogram)  {
     SetIndexStyle(0,DRAW_HISTOGRAM);   SetIndexBuffer(0,Map22);  SetIndexDrawBegin(0,10);
     SetIndexStyle(1,DRAW_HISTOGRAM);   SetIndexBuffer(1,Map56);  SetIndexDrawBegin(1,10);
   }
   SetIndexStyle(2,DRAW_LINE);        SetIndexBuffer(2,Ma233);  SetIndexLabel(2, "233");
   SetIndexStyle(3,DRAW_LINE);        SetIndexBuffer(3,Map55);  SetIndexLabel(3, "55");
   SetIndexStyle(4,DRAW_LINE);        SetIndexBuffer(4,Map21);  SetIndexLabel(4, "21");
   SetIndexStyle(5,DRAW_LINE);        SetIndexBuffer(5,Map5);   SetIndexLabel(5, "8");
   if(ShowArrows)  {
   SetIndexStyle(6,DRAW_ARROW);       SetIndexBuffer(6,MapUp);  SetIndexLabel(6, "Up");  SetIndexArrow(6, 233);
   SetIndexStyle(7,DRAW_ARROW);       SetIndexBuffer(7,MapDn);  SetIndexLabel(7, "Dn");  SetIndexArrow(7, 234);
   }
   return(0);
}
//+------------------------------------------------------------------+
int deinit()  {   return(0);  }
//+------------------------------------------------------------------+
int start()  {
Print(Histogram);
   int i,limit,counted_bars=IndicatorCounted();
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
   if(BarsCount==0) BarsCount=Bars;
   if(limit > BarsCount) limit = BarsCount;
   for(i=0; i<limit; i++){
      Map5[i] =NormalizeDouble(iMA(NULL,0,Fast,0,MODE_EMA,PRICE_CLOSE,i), Digits+1);
      Map21[i]=NormalizeDouble(iMA(NULL,0,Middle,0,MODE_EMA,PRICE_CLOSE,i), Digits+1);
      Map55[i]=NormalizeDouble(iMA(NULL,0,Slow,0,MODE_EMA,PRICE_CLOSE,i), Digits+1);
      Ma233[i]=NormalizeDouble(iMA(NULL,0,Slowest,0,MODE_EMA,PRICE_CLOSE,i), Digits+1);
      if(Histogram==0)  {  Map22[i]=Map5[i];    Map56[i]=Map21[i];  }
      if(Histogram==1)  {  Map22[i]=Map5[i];    Map56[i]=Map55[i];  }
      if(Histogram==2)  {  Map22[i]=Map21[i];   Map56[i]=Map55[i];  }
      if(Histogram==3)  {  Map22[i]=Map55[i];   Map56[i]=Ma233[i];  }
   }
   ArrayInitialize(MapDn, EMPTY_VALUE);
   ArrayInitialize(MapUp, EMPTY_VALUE);
   for(i=0; i<BarsCount; i++){
     if(Histogram==0)  { 
       if(Map5[i+2]>=Map21[i+2] && Map5[i+1]<Map21[i+1])   MapDn[i]=Map21[i]+3*Point;
       if(Map5[i+2]<=Map21[i+2] && Map5[i+1]>Map21[i+1])   MapUp[i]=Map21[i]-3*Point;
     }
     if(Histogram==1)  { 
       if(Map5[i+2]>=Map55[i+2] && Map5[i+1]<Map55[i+1])   MapDn[i]=Map55[i]+3*Point;
       if(Map5[i+2]<=Map55[i+2] && Map5[i+1]>Map55[i+1])   MapUp[i]=Map55[i]-3*Point;
     }
     if(Histogram==2)  { 
       if(Map21[i+2]>=Map55[i+2] && Map21[i+1]<Map55[i+1])   MapDn[i]=Map55[i]+3*Point;
       if(Map21[i+2]<=Map55[i+2] && Map21[i+1]>Map55[i+1])   MapUp[i]=Map55[i]-3*Point;
     }
     if(Histogram==3)  { 
       if(Map55[i+2]>=Ma233[i+2] && Map55[i+1]<Ma233[i+1])   MapDn[i]=Ma233[i]+3*Point;
       if(Map55[i+2]<=Ma233[i+2] && Map55[i+1]>Ma233[i+1])   MapUp[i]=Ma233[i]-3*Point;
     }
   }
   if(ShowAlert && key!=Time[0]) {
     if(ShowCross_55_233)  {
       if(Map55[2]>Ma233[2] && Map55[1]<Ma233[1])  Alert(Symbol(), "  ", Period(), "  Пересечение вниз 55-233");
       if(Map55[2]<Ma233[2] && Map55[1]>Ma233[1])  Alert(Symbol(), "  ", Period(), "  Пересечение вверх 55-233");
     }
     
     if(ShowCross_21_55)  {
       if(Map21[2]>Map55[2] && Map21[1]<Map55[1])  Alert(Symbol(), "  ", Period(), "  Пересечение вниз 21-55");
       if(Map21[2]<Map55[2] && Map21[1]>Map55[1])  Alert(Symbol(), "  ", Period(), "  Пересечение вверх 21-55");
     }
     
     if(ShowCross_5_21)  {
       if(Map5[2]>Map21[2] && Map5[1]<Map21[1])    Alert(Symbol(), "  ", Period(), "  Пересечение вниз 5-21");
       if(Map5[2]<Map21[2] && Map5[1]>Map21[1])    Alert(Symbol(), "  ", Period(), "  Пересечение вверх 5-21");
     }
     if(ShowCross_5_55)  {
       if(Map5[2]>Map55[2] && Map5[1]<Map55[1] && Map5[1]<Map21[1])    Alert(Symbol(), "  ", Period(), "  Пересечение вниз 5-ой 21 и 55");
       if(Map5[2]<Map55[2] && Map5[1]>Map55[1] && Map5[1]>Map21[1])    Alert(Symbol(), "  ", Period(), "  Пересечение вверх 5-ой 21 и 55");
     }
     key = Time[0];
   }
   return(0);
}
//+------------------------------------------------------------------+