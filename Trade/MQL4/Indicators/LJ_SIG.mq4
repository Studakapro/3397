//+------------------------------------------------------------------+
//|                                                       LJ_SIG.mq4 |
//|                       Copyright ?2007, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright ?2007, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Lime
#property indicator_color2 Red
#property indicator_width1 1
#property indicator_width2 1

extern int count = 1000;

double sig_up[];
double sig_down[];


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
  
      SetIndexBuffer(0,sig_up);
      SetIndexBuffer(1,sig_down);
      
      SetIndexStyle(0,DRAW_ARROW);
      SetIndexArrow(0, 225);
      SetIndexStyle(1,DRAW_ARROW);
      SetIndexArrow(1, 226);  
      
      SetIndexEmptyValue(0,0.0);
      SetIndexEmptyValue(1,0.0);
  
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
//   int    counted_bars=IndicatorCounted();
//----
   
   double ha_open = 0.0;
   double ha_close = 0.0;
   double ha_high = 0.0;
   double ha_low = 0.0;
   
   double tdi_green = 0.0;
   double tdi_red = 0.0;
   double tdi_yellow = 0.0;
   
   for (int i = 0; i< count; i++){
      
      tdi_green = iCustom(NULL, 0, "Traders_Dynamic_Index", 4, i);
      tdi_red = iCustom(NULL, 0, "Traders_Dynamic_Index", 5, i);
      tdi_yellow = iCustom(NULL, 0, "Traders_Dynamic_Index", 2, i);
   
      ha_open = iCustom(NULL, 0, "HeikenAshi_DM", 2, i);
      ha_close = iCustom(NULL, 0, "HeikenAshi_DM", 3, i);
   
      if (ha_open < ha_close){
         
         ha_high = iCustom(NULL, 0, "HeikenAshi_DM", 1, i);
         ha_low = iCustom(NULL, 0, "HeikenAshi_DM", 0, i);
         
         if ((ha_close >= iMA(NULL, 0, 5, 0, MODE_SMMA, PRICE_HIGH, i) - 3* Point )
            && ( tdi_green > 50 ) && ( tdi_green > tdi_red ) && ( tdi_green > tdi_yellow ) )
         {
            
            sig_up[i] = ha_low - 20* Point;
            
         }
         
      }
      else{
      
         ha_high = iCustom(NULL, 0, "HeikenAshi_DM", 0, i);
         ha_low = iCustom(NULL, 0, "HeikenAshi_DM", 1, i);
         
         if ((ha_close <= iMA(NULL, 0, 5, 0, MODE_SMMA, PRICE_LOW, i) + 3* Point)
            && ( tdi_green < 50 ) && ( tdi_green < tdi_red ) && ( tdi_green < tdi_yellow ) )
         {
            
            sig_down[i] = ha_high + 20* Point;
            
         }
         
      }
      
   }
   
//----
   return(0);
  }
//+------------------------------------------------------------------+