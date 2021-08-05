
#property copyright ""
#property link      ""

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 Black
#property indicator_color2 FireBrick
#property indicator_color3 DarkGreen
#property indicator_color4 Black
#property indicator_color5 Black

extern int bars_back = 120;
extern int m = 4;
extern int i = 0;
extern double kstd = 2.0;
extern int sName = 720;
double g_ibuf_100[];
double g_ibuf_104[];
double g_ibuf_108[];
double g_ibuf_112[];
double g_ibuf_116[];
double gda_120[10][10];
double gda_124[10];
double gda_128[10];
double gda_132[20];
double gd_136;
int g_shift_144;
int g_period_148;
int gi_152;
double gd_160;
double gd_168;
double gd_176;
int gi_184;
int gi_188;
int gi_192;
int gi_196;
int gi_200;
double gd_204;
double gd_212;

int init() {
   IndicatorShortName("TrendChannel");
   SetIndexStyle(0, DRAW_LINE);
   SetIndexBuffer(0, g_ibuf_100);
   SetIndexBuffer(1, g_ibuf_104);
   SetIndexBuffer(2, g_ibuf_108);
   SetIndexBuffer(3, g_ibuf_112);
   SetIndexBuffer(4, g_ibuf_116);
   g_period_148 = MathRound(bars_back);
   gi_200 = m + 1;
   ObjectCreate("pr" + sName, OBJ_ARROW, 0, Time[g_period_148], g_ibuf_100[g_period_148]);
   ObjectSet("pr" + sName, OBJPROP_ARROWCODE, 159);
   return (0);
}

int deinit() {
   ObjectDelete("pr" + sName);
   return (0);
}

int start() {
   g_shift_144 = iBarShift(Symbol(), Period(), ObjectGet("pr" + sName, OBJPROP_TIME1));
   g_period_148 = bars_back;
   gda_132[1] = g_period_148 + 1;
   SetIndexDrawBegin(0, Bars - g_period_148 - 1);
   SetIndexDrawBegin(1, Bars - g_period_148 - 1);
   SetIndexDrawBegin(2, Bars - g_period_148 - 1);
   SetIndexDrawBegin(3, Bars - g_period_148 - 1);
   SetIndexDrawBegin(4, Bars - g_period_148 - 1);
   for (int li_0 = 1; li_0 <= gi_200 * 2 - 2; li_0++) {
      gd_136 = 0;
      for (gi_152 = i; gi_152 <= i + g_period_148; gi_152++) gd_136 += MathPow(gi_152, li_0);
      gda_132[li_0 + 1] = gd_136;
   }
   for (li_0 = 1; li_0 <= gi_200; li_0++) {
      gd_136 = 0.0;
      for (gi_152 = i; gi_152 <= i + g_period_148; gi_152++) {
         if (li_0 == 1) gd_136 += Close[gi_152];
         else gd_136 += Close[gi_152] * MathPow(gi_152, li_0 - 1);
      }
      gda_124[li_0] = gd_136;
   }
   for (gi_188 = 1; gi_188 <= gi_200; gi_188++) {
      for (gi_184 = 1; gi_184 <= gi_200; gi_184++) {
         gi_192 = gi_184 + gi_188 - 1;
         gda_120[gi_184][gi_188] = gda_132[gi_192];
      }
   }
   for (gi_192 = 1; gi_192 <= gi_200 - 1; gi_192++) {
      gi_196 = 0;
      gd_168 = 0;
      for (gi_184 = gi_192; gi_184 <= gi_200; gi_184++) {
         if (MathAbs(gda_120[gi_184][gi_192]) > gd_168) {
            gd_168 = MathAbs(gda_120[gi_184][gi_192]);
            gi_196 = gi_184;
         }
      }
      if (gi_196 == 0) return (0);
      if (gi_196 != gi_192) {
         for (gi_188 = 1; gi_188 <= gi_200; gi_188++) {
            gd_176 = gda_120[gi_192][gi_188];
            gda_120[gi_192][gi_188] = gda_120[gi_196][gi_188];
            gda_120[gi_196][gi_188] = gd_176;
         }
         gd_176 = gda_124[gi_192];
         gda_124[gi_192] = gda_124[gi_196];
         gda_124[gi_196] = gd_176;
      }
      for (gi_184 = gi_192 + 1; gi_184 <= gi_200; gi_184++) {
         gd_160 = gda_120[gi_184][gi_192] / gda_120[gi_192][gi_192];
         for (gi_188 = 1; gi_188 <= gi_200; gi_188++) {
            if (gi_188 == gi_192) gda_120[gi_184][gi_188] = 0;
            else gda_120[gi_184][gi_188] = gda_120[gi_184][gi_188] - gd_160 * gda_120[gi_192][gi_188];
         }
         gda_124[gi_184] = gda_124[gi_184] - gd_160 * gda_124[gi_192];
      }
   }
   gda_128[gi_200] = gda_124[gi_200] / gda_120[gi_200][gi_200];
   for (gi_184 = gi_200 - 1; gi_184 >= 1; gi_184--) {
      gd_176 = 0;
      for (gi_188 = 1; gi_188 <= gi_200 - gi_184; gi_188++) {
         gd_176 += (gda_120[gi_184][gi_184 + gi_188]) * (gda_128[gi_184 + gi_188]);
         gda_128[gi_184] = 1 / gda_120[gi_184][gi_184] * (gda_124[gi_184] - gd_176);
      }
   }
   for (gi_152 = i; gi_152 <= i + g_period_148; gi_152++) {
      gd_136 = 0;
      for (gi_192 = 1; gi_192 <= m; gi_192++) gd_136 += (gda_128[gi_192 + 1]) * MathPow(gi_152, gi_192);
      g_ibuf_100[gi_152] = gda_128[1] + gd_136;
   }
   gd_204 = 0.0;
   for (gi_152 = i; gi_152 <= i + g_period_148; gi_152++) gd_204 += MathPow(Close[gi_152] - g_ibuf_100[gi_152], 2);
   gd_204 = MathSqrt(gd_204 / (g_period_148 + 1)) * kstd;
   gd_212 = iStdDev(NULL, 0, g_period_148, 0, MODE_SMA, PRICE_CLOSE, i) * kstd;
   for (gi_152 = i; gi_152 <= i + g_period_148; gi_152++) {
      g_ibuf_104[gi_152] = g_ibuf_100[gi_152] + gd_204;
      g_ibuf_108[gi_152] = g_ibuf_100[gi_152] - gd_204;
      g_ibuf_112[gi_152] = g_ibuf_100[gi_152] + gd_212;
      g_ibuf_116[gi_152] = g_ibuf_100[gi_152] - gd_212;
   }
   ObjectMove("pr" + sName, 0, Time[g_period_148], g_ibuf_100[g_period_148]);
   return (0);
}