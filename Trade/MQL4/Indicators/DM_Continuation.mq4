/*
   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright � 2007, CompassFX,LLC."
#property link      "www.compassfx.com"

#property indicator_separate_window
#property indicator_minimum -0.1
#property indicator_maximum 1.3
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 Green

extern string Custom_Indicator = "Continuation";
extern string Copyright = "� 2007, CompassFX,LLC.";
extern string Web_Address = "www.compassfx.com";
extern string MA_Method_Help = "SMA=0, EMA=1";
extern int MA_Method = 0;
extern double MA_Period = 2.0;
double g_ibuf_120[];
double g_ibuf_124[];
double g_ibuf_128[];
double g_ibuf_132[];
int gi_136 = 0;

int init() {
   IndicatorShortName("Continuation | www.compassfx.com  ");
   IndicatorBuffers(4);
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexStyle(1, DRAW_HISTOGRAM);
   SetIndexBuffer(0, g_ibuf_120);
   SetIndexBuffer(1, g_ibuf_124);
   SetIndexBuffer(2, g_ibuf_128);
   SetIndexBuffer(3, g_ibuf_132);
   SetIndexLabel(0, "Cont_Down");
   SetIndexLabel(1, "Cont_Up");
   SetIndexDrawBegin(0, 10);
   SetIndexDrawBegin(1, 10);
   return (0);
}

int start() {
   double ld_0;
   double ld_8;
   double ld_16;
   double ld_24;
   double ld_32;
   double ld_40;
   double ld_48;
   double ld_56;
   if (Bars <= 10) return (0);
   gi_136 = IndicatorCounted();
   if (gi_136 < 0) return (-1);
   if (gi_136 > 0) gi_136--;
   for (int li_64 = Bars - gi_136 - 1; li_64 >= 0; li_64--) {
      ld_0 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_CLOSE, li_64), Digits);
      ld_8 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_LOW, li_64), Digits);
      ld_16 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_OPEN, li_64), Digits);
      ld_24 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_HIGH, li_64), Digits);
      ld_32 = NormalizeDouble((g_ibuf_128[li_64 + 1] + (g_ibuf_132[li_64 + 1])) / 2.0, Digits);
      ld_56 = NormalizeDouble((ld_0 + ld_24 + ld_16 + ld_8) / 4.0, Digits);
      ld_40 = MathMax(ld_24, MathMax(ld_32, ld_56));
      ld_48 = MathMin(ld_16, MathMin(ld_32, ld_56));
      if (ld_32 < ld_56) {
         g_ibuf_120[li_64] = 0;
         g_ibuf_124[li_64] = 1;
      } else {
         g_ibuf_120[li_64] = 1;
         g_ibuf_124[li_64] = 0;
      }
      g_ibuf_128[li_64] = ld_32;
      g_ibuf_132[li_64] = ld_56;
   }
   return (0);
}