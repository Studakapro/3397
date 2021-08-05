#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 White
#property indicator_color2 White
#property indicator_color3 White

double G_ibuf_76[];
double G_ibuf_80[];
double G_ibuf_84[];
extern int MA_PERIOD = 20;
extern int MA_MODE = 0;
extern int PRICE_MODE = 5;
extern int ATR_PERIOD = 10;
extern double K = 2.0;
extern bool ATR_MODE = FALSE;

int init() {
   SetIndexStyle(0, DRAW_LINE);
   SetIndexShift(0, 0);
   SetIndexDrawBegin(0, 0);
   SetIndexBuffer(0, G_ibuf_76);
   SetIndexStyle(1, DRAW_LINE, STYLE_DOT);
   SetIndexShift(1, 0);
   SetIndexDrawBegin(1, 0);
   SetIndexBuffer(1, G_ibuf_80);
   SetIndexStyle(2, DRAW_LINE);
   SetIndexShift(2, 0);
   SetIndexDrawBegin(2, 0);
   SetIndexBuffer(2, G_ibuf_84);
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   double iatr_8;
   int Li_4 = IndicatorCounted();
   if (Li_4 < 0) return (-1);
   if (Li_4 > 0) Li_4--;
   int Li_0 = Bars - Li_4;
   for (int Li_16 = 0; Li_16 < Li_0; Li_16++) {
      G_ibuf_80[Li_16] = iMA(NULL, 0, MA_PERIOD, 0, MA_MODE, PRICE_MODE, Li_16);
      if (ATR_MODE) iatr_8 = iATR(NULL, 0, ATR_PERIOD, Li_16);
      else iatr_8 = f0_0(ATR_PERIOD, Li_16);
      G_ibuf_76[Li_16] = G_ibuf_80[Li_16] + K * iatr_8;
      G_ibuf_84[Li_16] = G_ibuf_80[Li_16] - K * iatr_8;
   }
   return (0);
}

double f0_0(int Ai_0, int Ai_4) {
   double Ld_ret_8 = 0;
   for (int Li_16 = Ai_4; Li_16 < Ai_4 + Ai_0; Li_16++) Ld_ret_8 += High[Li_16] - Low[Li_16];
   Ld_ret_8 /= Ai_0;
   return (Ld_ret_8);
}
