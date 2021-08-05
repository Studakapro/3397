//+------------------------------------------------------------------+
//|                                                       ADX_MA.mq4 |
//|                      Copyright © 2011, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Blue
#property indicator_color2 Red

//---- input parameters
extern int Ma_Period=250;
extern double Cross_Over_Threshold=0.00003;
extern int CountBars=5000;

//---- buffers
double val1[];
double val2[];
double Ma0,Ma1,Ma2;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- indicator line
   IndicatorBuffers(2);
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,108);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexArrow(1,108);
   SetIndexBuffer(0,val1);
   SetIndexBuffer(1,val2);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| AltrTrend_Signal_v2_2                                            |
//+------------------------------------------------------------------+
int start()
  {   
   if (CountBars>=Bars) CountBars=Bars;
   SetIndexDrawBegin(0,Bars-CountBars);
   SetIndexDrawBegin(1,Bars-CountBars);
   int i,shift,counted_bars=IndicatorCounted();


   //---- check for possible errors
   if(counted_bars<0) return(-1);

   //---- initial zero
   if(counted_bars<1)
     {
      for(i=1;i<=CountBars;i++) val1[CountBars-i]=0.0;
      for(i=1;i<=CountBars;i++) val2[CountBars-i]=0.0;
     } 

for (shift = CountBars; shift>=0; shift--) 
{ 
 
  Ma0=iMA(Symbol(),Period(),Ma_Period, 0, MODE_SMA, PRICE_MEDIAN,shift  );
  Ma1=iMA(Symbol(),Period(),Ma_Period, 0, MODE_SMA, PRICE_MEDIAN,shift+1);
  Ma2=iMA(Symbol(),Period(),Ma_Period, 0, MODE_SMA, PRICE_MEDIAN,shift+2);

	
	
 if  (( MathAbs(Ma0-Ma1)>Cross_Over_Threshold) && Ma0>Ma1 && Ma1>Ma2)	
	
{
	val1[shift]=Ma0;
}	
	

 if  (( MathAbs(Ma0-Ma1)>Cross_Over_Threshold) && Ma0<Ma1 && Ma1<Ma2)	
 
{
	val2[shift]=Ma0;
}

}
   return(0);
  }
//+------------------------------------------------------------------+