//+------------------------------------------------------------------+
//|                                                newMACD_Alert.mq4 |
//|                                Copyright © 2005, David W. Thomas |
//|                                           mailto:davidwt@usa.net |
//+------------------------------------------------------------------+
// This is the correct computation and display of MACD.
#property copyright "Copyright © 2005, David W. Thomas"
#property link      "mailto:davidwt@usa.net"

#property indicator_separate_window
#property indicator_buffers 3
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 Green

//---- input parameters
extern int FastMAPeriod    =  1;
extern int SlowMAPeriod    = 120;
extern int SignalMAPeriod  =  3000;
extern bool Show_Alert = true;

//---- buffers
double MACDLineBuffer[];
double SignalLineBuffer[];
double HistogramBuffer[];

//---- variables
double alpha = 0;
double alpha_1 = 0;
int PrevAlertTime=0;

/*void SetArrow(datetime ArrowTime, double Price, double ArrowCode, color ArrowColor)
{
 int err;
 string ArrowName = DoubleToStr(ArrowTime,0);
   if (ObjectFind(ArrowName) != -1) ObjectDelete(ArrowName);
   if(!ObjectCreate(ArrowName, OBJ_ARROW, 0, ArrowTime, Price))
    {
      err=GetLastError();
      Print("error: can't create Arrow! code #",err);
      return;
    }
   else
   {
     ObjectSet(ArrowName, OBJPROP_ARROWCODE, ArrowCode);
     ObjectSet(ArrowName, OBJPROP_COLOR , ArrowColor);
     ObjectsRedraw();
     if(ArrowCode==241)Alert("NMACD ",Period()," ",Symbol()," BUY");
     if(ArrowCode==242)Alert("NMACD ",Period()," ",Symbol()," SELL");
     PlaySound("alert2.wav");
   }
}
*/
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
{
   IndicatorDigits(Digits + 1);
   //---- indicators
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexBuffer(0, MACDLineBuffer);
   SetIndexDrawBegin(0, SlowMAPeriod);
   SetIndexStyle(1, DRAW_LINE, STYLE_DOT);
   SetIndexBuffer(1, SignalLineBuffer);
   SetIndexDrawBegin(1, SlowMAPeriod + SignalMAPeriod);
   SetIndexStyle(2, DRAW_HISTOGRAM);
   SetIndexBuffer(2, HistogramBuffer);
   SetIndexDrawBegin(2, SlowMAPeriod + SignalMAPeriod);
   //---- name for DataWindow and indicator subwindow label
   IndicatorShortName("NMACD_Alert(" + FastMAPeriod+"," + SlowMAPeriod + "," + SignalMAPeriod + ")");
   SetIndexLabel(0, "NMACD");
   SetIndexLabel(1, "Signal");
   SetIndexLabel(2, "Histogr");   
   //----
	  alpha = 2.0 / (SignalMAPeriod + 1.0);
	  alpha_1 = 1.0 - alpha;
   //----
   return(0);
}
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   //----
   ObjectsDeleteAll(0,OBJ_ARROW);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int limit;
   int counter, setalert;
   double Range, AvgRange;
   static datetime prevtime = 0;
   string pattern, period;
   int counted_bars = IndicatorCounted();
   //---- check for possible errors
   if(counted_bars < 0) 
       return(-1);
   //---- last counted bar will be recounted
   if(counted_bars > 0) 
       counted_bars--;
   limit = Bars - counted_bars;
   switch (Period()) 
    {
      case 1:
         period = "M1";
         break;
      case 5:
         period = "M5";
         break;
      case 15:
         period = "M15";
         break;
      case 30:
         period = "M30";
         break;      
      case 60:
         period = "H1";
         break;
      case 240:
         period = "H4";
         break;
      case 1440:
         period = "D1";
         break;
      case 10080:
         period = "W1";
         break;
      case 43200:
         period = "MN";
         break;
    }
//----
   for(int i = limit; i >= 0; i--)
     {
       MACDLineBuffer[i] = iMA(NULL,0,FastMAPeriod,0,MODE_EMA,PRICE_CLOSE,i)-iMA(NULL,0,SlowMAPeriod,0,MODE_EMA,PRICE_CLOSE,i);
       SignalLineBuffer[i] = alpha*MACDLineBuffer[i] + alpha_1*SignalLineBuffer[i+1];
       HistogramBuffer[i] =6*MACDLineBuffer[i] - 6*SignalLineBuffer[i];
     }
   if(prevtime == Time[0]) 
    {
      return(0);
    }
   prevtime = Time[0];  
   for(i = 0; i <=limit; i++)
     {    
      setalert = 0;
      //counter=i;
      Range=0;
      AvgRange=0;
      for (counter=i ;counter<=i+9;counter++)
       {
         AvgRange=AvgRange+MathAbs(High[counter]-Low[counter]);
       }
       Range=AvgRange/10;
       if((HistogramBuffer[i+1]>0)&&(HistogramBuffer[i+2]<=0))
        {
         string ArrowUp = DoubleToStr(Time[i+1],0);
         ObjectCreate(ArrowUp, OBJ_ARROW, 0, Time[i+1], Low[i+1]-Range*0.5);
         ObjectSet(ArrowUp, OBJPROP_ARROWCODE, 241);
         ObjectSet(ArrowUp, OBJPROP_COLOR , DeepSkyBlue);
         if (setalert == 0 && Show_Alert == true) 
          {
            pattern = "Up";
            setalert = 1;
          }
           //SetArrow(Time[i+1],Low[i+1]-15*Point,241,Blue);
        }   
       if((HistogramBuffer[i+1]<0)&&(HistogramBuffer[i+2]>=0))
        {
         string ArrowDown = DoubleToStr(Time[i+1],0);
         ObjectCreate(ArrowDown, OBJ_ARROW, 0, Time[i+1], High[i+1]+Range*0.7);
         ObjectSet(ArrowDown, OBJPROP_ARROWCODE, 242);
         ObjectSet(ArrowDown, OBJPROP_COLOR , Red);
         if (setalert == 0 && Show_Alert == true) 
          {
            pattern = "Down";
            setalert = 1;
          }
          //SetArrow(Time[i+1],High[i+1]+15*Point,242,Gold);
        }
       if (setalert == 1 && i == 0) 
        {
         Alert(Symbol(), " ", period, " ", pattern);
         setalert = 0;
        }
     } 
//----
   return(0);
  }
//+------------------------------------------------------------------+