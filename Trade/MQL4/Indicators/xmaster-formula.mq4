/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  H t Tp :// w W W .M eTAq U ote s.NE T
   E-mail : S u PPoRT @ M et A qu O te S .n ET
*/
#property copyright "Copyright ? 2013,Xmaster Formula"
#property link      " http://www.xmasterformula.com "

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_color1 Lime
#property indicator_color2 Red
#property indicator_color3 Red
#property indicator_color4 Yellow
#property indicator_color5 Yellow

extern bool EmailAlert = TRUE;
extern bool SoundAlert = TRUE;
int Gi_84 = 40;
int Gi_88 = 200;
int G_ma_method_92 = MODE_SMMA;
int G_applied_price_96 = PRICE_LOW;
double G_ibuf_100[];
double G_ibuf_104[];
double G_ibuf_108[];
datetime G_time_112;
double G_ibuf_116[];
double G_ibuf_120[];

// 3E09AE791896EC3E7E65B3FE363F0FC3
void f0_0(string As_0, double Ad_8, double Ad_16, double Ad_24) {
   string Ls_32;
   string Ls_40;
   string Ls_48;
   if (Time[0] != G_time_112) {
      G_time_112 = Time[0];
      if (Ad_24 != 0.0) Ls_48 = "Price " + DoubleToStr(Ad_24, 4);
      else Ls_48 = "";
      if (Ad_8 != 0.0) Ls_40 = ", TakeProfit   " + DoubleToStr(Ad_8, 4);
      else Ls_40 = "";
      if (Ad_16 != 0.0) Ls_32 = ", StopLoss   " + DoubleToStr(Ad_16, 4);
      else Ls_32 = "";
      if (SoundAlert == TRUE) Alert(" XMASTER FORMULA " + As_0 + Ls_48 + Ls_40 + Ls_32 + " ", Symbol(), ", ", Period(), " min");
   }
}

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   int Li_0;
   if (Gi_84 == 8) Li_0 = 2;
   else Li_0 = 4;
   IndicatorBuffers(5);
   string Ls_4 = "(" + Gi_84 + ")";
   SetIndexBuffer(0, G_ibuf_100);
   SetIndexStyle(0, DRAW_LINE, STYLE_DASHDOT, Li_0);
   SetIndexLabel(0, "" + Ls_4);
   SetIndexBuffer(1, G_ibuf_104);
   SetIndexStyle(0, DRAW_ARROW, EMPTY, 2);
   SetIndexArrow(0, 159);
   SetIndexStyle(1, DRAW_ARROW, EMPTY, 2);
   SetIndexArrow(1, 108);
   SetIndexStyle(2, DRAW_NONE, EMPTY, 2);
   SetIndexLabel(1, "" + Ls_4);
   SetIndexBuffer(2, G_ibuf_108);
   ArraySetAsSeries(G_ibuf_108, TRUE);
   IndicatorShortName("XMASTER FORMULA");
   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS) + 1.0);
   SetIndexBuffer(3, G_ibuf_116);
   SetIndexStyle(3, DRAW_ARROW, EMPTY, 3);
   SetIndexArrow(3, 226);
   SetIndexBuffer(4, G_ibuf_120);
   SetIndexStyle(4, DRAW_ARROW, EMPTY, 3);
   SetIndexArrow(4, 225);
   return (0);
}

// 52D46093050F38C27267BCE42543EF60
int deinit() {
   return (0);
}

// D954202506588335BC40071F1425E064
double f0_1(int Ai_0, int A_period_4) {
   return (iMA(NULL, 0, A_period_4, 0, G_ma_method_92, G_applied_price_96, Ai_0));
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   double Lda_0[];
   double Lda_4[];
   double Ld_8;
   int ind_counted_16 = IndicatorCounted();
   if (ind_counted_16 < 0) return (-1);
   int Li_20 = 1;
   int period_24 = MathFloor(MathSqrt(Gi_84));
   int Li_28 = MathFloor(Gi_84 / 1.9);
   int Li_32 = Bars - ind_counted_16 + Gi_84 + 1;
   if (Li_32 > Bars) Li_32 = Bars;
   ArraySetAsSeries(Lda_0, TRUE);
   ArrayResize(Lda_0, Li_32);
   ArraySetAsSeries(Lda_4, TRUE);
   ArrayResize(Lda_4, Li_32);
   double Ld_36 = Close[1];
   for (Li_20 = 0; Li_20 < Li_32; Li_20++) Lda_0[Li_20] = 2.0 * f0_1(Li_20, Li_28) - f0_1(Li_20, Gi_84);
   for (Li_20 = 0; Li_20 < Li_32 - Gi_84; Li_20++) G_ibuf_108[Li_20] = iMAOnArray(Lda_0, 0, period_24, 0, G_ma_method_92, Li_20);
   for (Li_20 = Li_32 - Gi_84; Li_20 > 0; Li_20--) {
      Lda_4[Li_20] = Lda_4[Li_20 + 1];
      if (G_ibuf_108[Li_20] > G_ibuf_108[Li_20 + 1]) Lda_4[Li_20] = 1;
      if (G_ibuf_108[Li_20] < G_ibuf_108[Li_20 + 1]) Lda_4[Li_20] = -1;
      if (Lda_4[Li_20] > 0.0) {
         G_ibuf_100[Li_20] = G_ibuf_108[Li_20];
         if (Lda_4[Li_20 + 1] < 0.0) G_ibuf_100[Li_20 + 1] = G_ibuf_108[Li_20 + 1];
         if (Lda_4[Li_20 + 1] < 0.0) {
            if (Li_20 == 1) {
               Ld_8 = Ld_36 - Gi_88 * Point;
               f0_0("UP Buy ", 0, Ld_8, Ld_36);
            }
         }
         G_ibuf_104[Li_20] = EMPTY_VALUE;
      } else {
         if (Lda_4[Li_20] < 0.0) {
            G_ibuf_104[Li_20] = G_ibuf_108[Li_20];
            if (Lda_4[Li_20 + 1] > 0.0) G_ibuf_104[Li_20 + 1] = G_ibuf_108[Li_20 + 1];
            if (Lda_4[Li_20 + 1] > 0.0) {
               if (Li_20 == 1) {
                  Ld_8 = Ld_36 + Gi_88 * Point;
                  f0_0("DOWN Sell ", 0, Ld_8, Ld_36);
               }
            }
            G_ibuf_100[Li_20] = EMPTY_VALUE;
         }
      }
   }
   for (Li_20 = 0; Li_20 < Li_32; Li_20++) {
      if (G_ibuf_104[Li_20 + 1] == EMPTY_VALUE && G_ibuf_104[Li_20] != EMPTY_VALUE) G_ibuf_116[Li_20] = G_ibuf_104[Li_20];
      if (G_ibuf_100[Li_20 + 1] == EMPTY_VALUE && G_ibuf_100[Li_20] != EMPTY_VALUE) G_ibuf_120[Li_20] = G_ibuf_100[Li_20];
   }
   return (0);
}
