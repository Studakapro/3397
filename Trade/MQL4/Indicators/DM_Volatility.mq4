/*
   Generated by EX4-TO-MQ4 decompiler V4.0.224.1 []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright ? 2007, Dean Malone"
#property link      "www.compassfx.com"

#property indicator_separate_window
#property indicator_minimum 0.0
#property indicator_buffers 1
#property indicator_color1 DarkGray

extern string Custom_Indicator = "Volatility ";
extern string Copyright = "? 2007, Dean Malone ";
extern string Web_Address = "www.compassfx.com";
extern double MyLevel = 0.0;
extern string MyLevel_Help = "If MyLevel = 0.0 - defaults used (M1=0.0001,M5=0.0002,M15=0.0004,M30=0.0006,H1=0.0008,H4=0.0014,D1=0.005)";
double gd_116;
double g_ibuf_124[];
double g_period_128 = 7.0;

int init() {
   switch (Period()) {
   case PERIOD_MN1:
      gd_116 = 0.005;
      break;
   case PERIOD_W1:
      gd_116 = 0.005;
      break;
   case PERIOD_D1:
      gd_116 = 0.005;
      break;
   case PERIOD_H4:
      gd_116 = 0.0014;
      break;
   case PERIOD_H1:
      gd_116 = 0.0008;
      break;
   case PERIOD_M30:
      gd_116 = 0.0006;
      break;
   case PERIOD_M15:
      gd_116 = 0.0004;
      break;
   case PERIOD_M5:
      gd_116 = 0.0002;
      break;
   case PERIOD_M1:
      gd_116 = 0.0001;
   }
   if (Digits < 4) gd_116 = 100.0 * gd_116;
   if (MyLevel != 0.0) gd_116 = MyLevel;
   IndicatorShortName("Volatility | www.compassfx.com  ");
   SetIndexBuffer(0, g_ibuf_124);
   SetIndexStyle(0, DRAW_LINE);
   SetIndexLabel(0, "Volatility");
   SetLevelValue(0, gd_116);
   SetLevelStyle(0, 0, Red);
   return (0);
}

int start() {
   double l_close_16;
   double ld_24;
   double l_ima_32;
   if (Bars <= g_period_128) return (0);
   int l_ind_counted_12 = IndicatorCounted();
   int li_0 = Bars - g_period_128 - 1.0;
   if (l_ind_counted_12 > g_period_128) li_0 = Bars - l_ind_counted_12;
   while (li_0 >= 0) {
      ld_24 = 0.0;
      l_ima_32 = iMA(NULL, 0, g_period_128, 0, MODE_SMA, PRICE_CLOSE, li_0);
      for (int l_count_4 = 0; l_count_4 < g_period_128; l_count_4++) {
         l_close_16 = Close[li_0 + l_count_4];
         ld_24 += (l_close_16 - l_ima_32) * (l_close_16 - l_ima_32);
      }
      g_ibuf_124[li_0] = MathSqrt(ld_24 / g_period_128);
      li_0--;
   }
   return (0);
}
