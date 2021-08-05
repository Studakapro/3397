//+------------------------------------------------------------------+
//|                                        ZeroLag MACD IVT like.mq4 |
//+------------------------------------------------------------------+
#property copyright "Bompa"
//----
#property indicator_separate_window
#property indicator_buffers 4
#property indicator_color1 Green
#property indicator_color2 Red
#property indicator_color3 Green
#property indicator_color4 Red

//---- input parameters
extern int FastEMA = 12;
extern int SlowEMA = 26;
extern int SignalEMA = 9;
extern bool Alarm = False; 

//---- buffers
double MACDBuffer[];
double SignalBuffer[];
double FastEMABuffer[];
double SlowEMABuffer[];
double SignalEMABuffer[];
double SignalDiffPlus[];
double SignalDiffMinus[];
//---- variables       
bool soundme;    
double oldDiff = 0;      
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
   IndicatorBuffers(7);
   SetIndexBuffer(0, MACDBuffer);
   SetIndexBuffer(1, SignalBuffer);
   SetIndexBuffer(5, FastEMABuffer);
   SetIndexBuffer(6, SlowEMABuffer);
   SetIndexBuffer(4, SignalEMABuffer);
   SetIndexBuffer(2, SignalDiffPlus);
   SetIndexBuffer(3, SignalDiffMinus);    
   SetIndexStyle(0, DRAW_LINE,EMPTY);  
   SetIndexStyle(1, DRAW_LINE,EMPTY);
   SetIndexStyle(2, DRAW_HISTOGRAM,EMPTY);
   SetIndexStyle(3, DRAW_HISTOGRAM,EMPTY); 
   
   SetIndexDrawBegin(0, SlowEMA);
   SetIndexDrawBegin(1, SlowEMA);
   SetIndexDrawBegin(2, SlowEMA);                  
   IndicatorShortName("IVT_MACD_Zero_Lag(" + FastEMA + "," + SlowEMA + "," + SignalEMA + ")");
   SetIndexLabel(0, "MACD");
   SetIndexLabel(1, "Signal");
   SetIndexLabel(2, "Diff");                     
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counted_bars = IndicatorCounted();
   if(counted_bars < 0) return(-1);
   if(counted_bars > 0) counted_bars--;
   limit = Bars - counted_bars;
   double EMA, ZeroLagEMAp, ZeroLagEMAq;
   double myhisto = 0;
   soundme = false;
   for(int i = 0; i < limit; i++)
     {
       FastEMABuffer[i] = iMA(NULL, 0, FastEMA, 0, MODE_EMA, PRICE_CLOSE, i);
       SlowEMABuffer[i] = iMA(NULL, 0, SlowEMA, 0, MODE_EMA, PRICE_CLOSE, i);
     }
   for(i = 0; i < limit; i++)
     {
        EMA = iMAOnArray(FastEMABuffer, Bars, FastEMA, 0, MODE_EMA, i);
        ZeroLagEMAp = FastEMABuffer[i] + FastEMABuffer[i] - EMA;
        EMA = iMAOnArray(SlowEMABuffer, Bars, SlowEMA, 0, MODE_EMA, i);
        ZeroLagEMAq = SlowEMABuffer[i] + SlowEMABuffer[i] - EMA;
        MACDBuffer[i] = ZeroLagEMAp - ZeroLagEMAq;
     }
   for(i = 0; i < limit; i++)
       SignalEMABuffer[i] = iMAOnArray(MACDBuffer, Bars, SignalEMA, 0, MODE_EMA, i);
   for(i = 0; i < limit; i++)
     {
       EMA = iMAOnArray(SignalEMABuffer, Bars, SignalEMA, 0, MODE_EMA, i);
       SignalBuffer[i] = SignalEMABuffer[i] + SignalEMABuffer[i] - EMA;
     }
   for(i = 0; i < limit; i++)                                                                     
     {
       soundme = false;
       myhisto = MACDBuffer[i] - SignalBuffer[i];         
       if(myhisto > 0)
       {
         SignalDiffPlus[i] = myhisto;
         if(Alarm==true && oldDiff < 0) soundme = true;
       }
       if(myhisto < 0)
       {
         SignalDiffMinus[i] = myhisto;
         if(Alarm==true && oldDiff > 0) soundme = true;

       }
     }
     if(soundme == true) PlaySound("connect.wav");
     oldDiff = myhisto; 
   return(0);
  }
//+------------------------------------------------------------------+