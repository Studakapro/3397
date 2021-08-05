#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Red
#property indicator_color2 ForestGreen
#property indicator_color3 Red

extern int Price = 0;
extern int Length = 16;
extern int Length_M1 = 7;
extern int Length_M5 = 9;
extern int Length_M15 = 12;
extern int Length_M30 = 15;
extern int Length_H1 = 15;
extern int Length_H4 = 15;
extern int Length_D1 = 15;
extern int Length_W1 = 15;
extern int Length_MN1 = 15;
extern int Displace = 0;
extern int Filter = 0;
extern int Color = 1;
extern int ColorBarBack = 1;
extern double Deviation = 0.0;
extern bool Colour_Changing_Alert = FALSE;
extern bool Colour_Changed_Alert = TRUE;
double g_ibuf_116[];
double g_ibuf_120[];
double g_ibuf_124[];
double g_ibuf_128[];
double gda_132[];
int g_index_136;
int gi_140;
int gi_144;
int gi_148 = 4;
double gd_152;
double gd_160;
double gd_168;
double gd_176;
double gd_184;
double gd_192;
double gd_200 = 3.1415926535;
string gs_none_208 = "NONE";
string gs_none_216 = "NONE";
string gs_none_224 = "NONE";
string gs_none_232 = "NONE";

int init() {    
   IndicatorBuffers(4);
   SetIndexStyle(0, DRAW_LINE, EMPTY, 4, Red);
   SetIndexBuffer(0, g_ibuf_116);
   SetIndexStyle(1, DRAW_LINE, EMPTY, 4, ForestGreen);
   SetIndexBuffer(1, g_ibuf_120);
   SetIndexStyle(2, DRAW_LINE, EMPTY, 4, Red);
   SetIndexBuffer(2, g_ibuf_124);
   SetIndexBuffer(3, g_ibuf_128);
   IndicatorDigits(MarketInfo(Symbol(), MODE_DIGITS));
   switch (Period()) {
   case PERIOD_M1:
   Length = Length_M1;
   break;
   case PERIOD_M5:
   Length = Length_M5;
   break;
   case PERIOD_M15:
   Length = Length_M15;
   break;
   case PERIOD_M30:
   Length = Length_M30;
   break;
   case PERIOD_H1:
   Length = Length_H1;
   break;
   case PERIOD_H4:
   Length = Length_H4;
   break;
   case PERIOD_D1:
   Length = Length_D1;
   break;
   case PERIOD_W1:
   Length = Length_W1;
   break;
   case PERIOD_MN1:
   Length = Length_MN1;
   break;
   }
   
   string ls_0 = "Trend Line MA(" + Length + ")";
   IndicatorShortName(ls_0);
   SetIndexLabel(0, "TredMA");
   SetIndexLabel(1, "Up");
   SetIndexLabel(2, "Dn");
   SetIndexShift(0, Displace);
   SetIndexShift(1, Displace);
   SetIndexShift(2, Displace);
   SetIndexEmptyValue(0, EMPTY_VALUE);
   SetIndexEmptyValue(1, EMPTY_VALUE);
   SetIndexEmptyValue(2, EMPTY_VALUE);
   SetIndexDrawBegin(0, Length * gi_148 + Length);
   SetIndexDrawBegin(1, Length * gi_148 + Length);
   SetIndexDrawBegin(2, Length * gi_148 + Length);
   gd_152 = 3.0 * gd_200;
   gi_140 = Length - 1;
   gi_144 = Length * gi_148 + gi_140;
   ArrayResize(gda_132, gi_144);
   gd_184 = 0;
   for (g_index_136 = 0; g_index_136 < gi_144 - 1; g_index_136++) {
      if (g_index_136 <= gi_140 - 1) gd_168 = 1.0 * g_index_136 / (gi_140 - 1);
      else gd_168 = (g_index_136 - gi_140 + 1) * (2.0 * gi_148 - 1.0) / (gi_148 * Length - 1.0) + 1.0;
      gd_160 = MathCos(gd_200 * gd_168);
      gd_192 = 1.0 / (gd_152 * gd_168 + 1.0);
      if (gd_168 <= 0.5) gd_192 = 1;
      gda_132[g_index_136] = gd_192 * gd_160;
      gd_184 += gda_132[g_index_136];
   }
   return (0);
}

int start() {
   int li_12;
   double ld_16;
   int l_ind_counted_8 = IndicatorCounted();
   if (l_ind_counted_8 > 0) li_12 = Bars - l_ind_counted_8;
   if (l_ind_counted_8 < 0) return (0);
   if (l_ind_counted_8 == 0) li_12 = Bars - gi_144 - 1;
   if (l_ind_counted_8 < 1) {
      for (int l_index_0 = 1; l_index_0 < Length * gi_148 + Length; l_index_0++) {
         g_ibuf_116[Bars - l_index_0] = 0;
         g_ibuf_120[Bars - l_index_0] = 0;
         g_ibuf_124[Bars - l_index_0] = 0;
      }
   }
   for (int li_4 = li_12; li_4 >= 0; li_4--) {
      gd_176 = 0;
      for (l_index_0 = 0; l_index_0 <= gi_144 - 1; l_index_0++) {
         if (Price == 0) ld_16 = Close[li_4 + l_index_0];
         else {
            if (Price == 1) ld_16 = Open[li_4 + l_index_0];
            else {
               if (Price == 2) ld_16 = High[li_4 + l_index_0];
               else {
                  if (Price == 3) ld_16 = Low[li_4 + l_index_0];
                  else {
                     if (Price == 4) ld_16 = (High[li_4 + l_index_0] + (Low[li_4 + l_index_0])) / 2.0;
                     else {
                        if (Price == 5) ld_16 = (High[li_4 + l_index_0] + (Low[li_4 + l_index_0]) + (Close[li_4 + l_index_0])) / 3.0;
                        else
                           if (Price == 6) ld_16 = (High[li_4 + l_index_0] + (Low[li_4 + l_index_0]) + 2.0 * (Close[li_4 + l_index_0])) / 4.0;
                     }
                  }
               }
            }
         }
         gd_176 += gda_132[l_index_0] * ld_16;
      }
      if (gd_184 > 0.0) g_ibuf_116[li_4] = (Deviation / 100.0 + 1.0) * gd_176 / gd_184;
      if (Filter > 0)
         if (MathAbs(g_ibuf_116[li_4] - (g_ibuf_116[li_4 + 1])) < Filter * Point) g_ibuf_116[li_4] = g_ibuf_116[li_4 + 1];
      if (Color > 0) {
         g_ibuf_128[li_4] = g_ibuf_128[li_4 + 1];
         if (g_ibuf_116[li_4] - (g_ibuf_116[li_4 + 1]) > Filter * Point) g_ibuf_128[li_4] = 1;
         if (g_ibuf_116[li_4 + 1] - g_ibuf_116[li_4] > Filter * Point) g_ibuf_128[li_4] = -1;
         if (g_ibuf_128[li_4] > 0.0) {
            g_ibuf_120[li_4] = g_ibuf_116[li_4];
            if (g_ibuf_128[li_4 + ColorBarBack] < 0.0) g_ibuf_120[li_4 + ColorBarBack] = g_ibuf_116[li_4 + ColorBarBack];
            g_ibuf_124[li_4] = EMPTY_VALUE;
            if (Colour_Changing_Alert == TRUE && li_4 == 0 && NormalizeDouble(g_ibuf_128[li_4], Digits) != NormalizeDouble(g_ibuf_128[li_4 + 1], Digits)) gs_none_216 = Symbol() + " possible trend change UP occured on " + StringSubstr(TimeToStr(TimeCurrent(), TIME_DATE|TIME_SECONDS), 0, 10) + " during the " + StringSubstr(TimeToStr(Time[li_4], TIME_DATE|TIME_MINUTES), 11, 5) + " candle";
            if (Colour_Changing_Alert == TRUE && li_4 == 0 && gs_none_216 != gs_none_208 && NormalizeDouble(g_ibuf_128[li_4], Digits) != NormalizeDouble(g_ibuf_128[li_4 + 1], Digits) &&
               TimeYear(Time[li_4]) >= Year() && TimeMonth(Time[li_4]) >= Month() && TimeDay(Time[li_4]) >= Day() && TimeHour(Time[li_4]) >= Hour() && TimeMinute(Time[li_4]) >= Minute() - Period()) {
               Alert(gs_none_216 + " (at server time " + StringSubstr(TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES), 11, 5) + ")");
               gs_none_208 = gs_none_216;
            }
         }
         if (g_ibuf_128[li_4] < 0.0) {
            g_ibuf_124[li_4] = g_ibuf_116[li_4];
            if (g_ibuf_128[li_4 + ColorBarBack] > 0.0) g_ibuf_124[li_4 + ColorBarBack] = g_ibuf_116[li_4 + ColorBarBack];
            g_ibuf_120[li_4] = EMPTY_VALUE;
            if (Colour_Changing_Alert == TRUE && li_4 == 0 && NormalizeDouble(g_ibuf_128[li_4], Digits) != NormalizeDouble(g_ibuf_128[li_4 + 1], Digits)) gs_none_216 = Symbol() + " possible trend change DOWN occured on " + StringSubstr(TimeToStr(TimeCurrent(), TIME_DATE|TIME_SECONDS), 0, 10) + " during the " + StringSubstr(TimeToStr(Time[li_4], TIME_DATE|TIME_MINUTES), 11, 5) + " candle";
            if (Colour_Changing_Alert == TRUE && li_4 == 0 && gs_none_216 != gs_none_208 && NormalizeDouble(g_ibuf_128[li_4], Digits) != NormalizeDouble(g_ibuf_128[li_4 + 1], Digits) &&
               TimeYear(Time[li_4]) >= Year() && TimeMonth(Time[li_4]) >= Month() && TimeDay(Time[li_4]) >= Day() && TimeHour(Time[li_4]) >= Hour() && TimeMinute(Time[li_4]) >= Minute() - Period()) {
               Alert(gs_none_216 + " (at server time " + StringSubstr(TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES), 11, 5) + ")");
               gs_none_208 = gs_none_216;
            }
         }
         if (Colour_Changed_Alert == TRUE && li_4 == 0 && NormalizeDouble(g_ibuf_128[li_4 + 1], Digits) != NormalizeDouble(g_ibuf_128[li_4 + 2], Digits) && NormalizeDouble(g_ibuf_124[li_4 +
            1], Digits) != NormalizeDouble(g_ibuf_120[li_4 + 1], Digits)) gs_none_232 = Symbol() + " trend change confirmation occured on " + StringSubstr(TimeToStr(TimeCurrent(), TIME_DATE|TIME_SECONDS), 0, 10) + " upon the close of the " + StringSubstr(TimeToStr(Time[li_4 + 1], TIME_DATE|TIME_MINUTES), 11, 5) + " candle, but repainting is not yet ruled out";
         if (Colour_Changed_Alert == TRUE && li_4 == 0 && gs_none_232 != gs_none_224 && NormalizeDouble(g_ibuf_128[li_4 + 1], Digits) != NormalizeDouble(g_ibuf_128[li_4 + 2], Digits) &&
            TimeYear(Time[li_4]) >= Year() && TimeMonth(Time[li_4]) >= Month() && TimeDay(Time[li_4]) >= Day() && TimeHour(Time[li_4]) >= Hour() && TimeMinute(Time[li_4]) >= Minute() - Period()) {
            Alert(gs_none_232 + " (at server time " + StringSubstr(TimeToStr(TimeCurrent(), TIME_DATE|TIME_MINUTES), 11, 5) + ")");
            gs_none_224 = gs_none_232;
         }
      }
   }
   return (0);
}