/*
   G e n e r a t e d  by ex4-to-mq4 decompiler FREEWARE 4.0.509.5
   Website:  HTtP: / /ww w. mET A Q uoTe S . nEt
   E-mail :  S U p p o rT@M e t aQu o TE S . N eT
*/
#property copyright "? // mod. fxdaytrader, http://ForexBaron.net"
#property link      "http://ForexBaron.net"

#property indicator_separate_window
#property indicator_buffers 5
#property indicator_color1 DimGray
#property indicator_color2 Black
#property indicator_color3 Black
#property indicator_color4 Black
#property indicator_color5 Black
#property indicator_level1 -100.0
#property indicator_level2 100.0
#property indicator_level4 100.0
#property indicator_level5 -100.0

extern int InpCCIPeriod = 14;
extern double level = 100.0;
extern color ColorUp = ForestGreen;
extern color ColorDn = Red;
extern color ColorNeutralUp = Blue;
extern color ColorNeutralDn = Gold;
extern int HistWidth = 4;
extern string sep0 = "";
extern string ahi0 = " ******* Alert settings:";
extern int SignalCandle = 1;
extern bool PopupAlerts = FALSE;
extern bool EmailAlerts = FALSE;
extern bool PushNotificationAlerts = FALSE;
extern bool SoundAlerts = FALSE;
extern string SoundFileLong = "alert.wav";
extern string SoundFileShort = "alert2.wav";
int Gi_160 = 3;
double G_ibuf_164[];
double G_ibuf_168[];
double G_ibuf_172[];
double G_ibuf_176[];
double G_ibuf_180[];

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   IndicatorBuffers(5);
   SetIndexBuffer(0, G_ibuf_168);
   SetIndexBuffer(1, G_ibuf_172);
   SetIndexBuffer(2, G_ibuf_176);
   SetIndexBuffer(3, G_ibuf_180);
   SetIndexBuffer(4, G_ibuf_164);
   SetIndexLabel(0, "UP");
   SetIndexLabel(1, "DOWN");
   SetIndexLabel(2, "Neutral UP");
   SetIndexLabel(3, "Neutral DOWN");
   if (InpCCIPeriod <= 1) {
      Print("Wrong input parameter CCI Period=", InpCCIPeriod);
      return (-1);
   }
   SetIndexDrawBegin(0, InpCCIPeriod);
   string Ls_0 = "CCI_мст_v4 (" + InpCCIPeriod + ")";
   IndicatorShortName(Ls_0);
   SetIndexLabel(0, Ls_0);
   SetIndexStyle(0, DRAW_HISTOGRAM, STYLE_SOLID, HistWidth, ColorUp);
   SetIndexStyle(1, DRAW_HISTOGRAM, STYLE_SOLID, HistWidth, ColorDn);
   SetIndexStyle(2, DRAW_HISTOGRAM, STYLE_SOLID, HistWidth, ColorNeutralUp);
   SetIndexStyle(3, DRAW_HISTOGRAM, STYLE_SOLID, HistWidth, ColorNeutralDn);
   SetIndexStyle(4, DRAW_NONE);
   return (0);
}

// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   double Ld_20;
   double Ld_unused_28;
   int Li_8 = IndicatorCounted();
   int Li_unused_12 = 0;
   int Li_unused_16 = 0;
   if (Li_8 < 0) return (-1);
   if (Li_8 > 0) Li_8--;
   int Li_4 = Bars - Li_8;
   for (int Li_0 = 0; Li_0 < Li_4; Li_0++) {
      G_ibuf_164[Li_0] = iCCI(NULL, 0, InpCCIPeriod, PRICE_TYPICAL, Li_0);
      G_ibuf_176[Li_0] = 0;
      G_ibuf_168[Li_0] = 0;
      G_ibuf_172[Li_0] = 0;
   }
   for (Li_0 = Li_4; Li_0 >= 0; Li_0--) {
      if (Li_0 <= Bars - 3) {
         Ld_20 = G_ibuf_164[Li_0];
         Ld_unused_28 = G_ibuf_164[Li_0 + 1];
         if (Ld_20 > 0.0) {
            if (Ld_20 >= level) {
               G_ibuf_176[Li_0] = level;
               G_ibuf_180[Li_0] = 0;
               G_ibuf_168[Li_0] = Ld_20;
               G_ibuf_172[Li_0] = 0;
            }
            if (Ld_20 <= level) {
               G_ibuf_176[Li_0] = Ld_20;
               G_ibuf_180[Li_0] = 0;
               G_ibuf_168[Li_0] = 0;
               G_ibuf_172[Li_0] = 0;
            }
         }
         if (Ld_20 <= 0.0) {
            if (Ld_20 < -level) {
               G_ibuf_176[Li_0] = 0;
               G_ibuf_180[Li_0] = -level;
               G_ibuf_168[Li_0] = 0;
               G_ibuf_172[Li_0] = Ld_20;
            }
            if (Ld_20 >= -level) {
               G_ibuf_176[Li_0] = 0;
               G_ibuf_180[Li_0] = Ld_20;
               G_ibuf_168[Li_0] = 0;
               G_ibuf_172[Li_0] = 0;
            }
         }
      }
   }
   f0_2(G_ibuf_168[SignalCandle], G_ibuf_172[SignalCandle], G_ibuf_168[SignalCandle + 1], G_ibuf_172[SignalCandle + 1]);
   return (0);
}

// 655E559672C9DABAAEB893F0FB956F28
void f0_1(string As_0, string As_8) {
   As_0 = "CCI_v4 Alert on " + Symbol() + ", period " + f0_0(Period()) + ": " + As_0;
   string Ls_16 = "MT4 alert on acc. " + AccountNumber() + ", " + WindowExpertName() + " - Alert on " + Symbol() + ", period " + f0_0(Period());
   if (PopupAlerts) Alert(As_0);
   if (EmailAlerts) SendMail(Ls_16, As_0);
   if (PushNotificationAlerts) SendNotification(As_0);
   if (SoundAlerts) PlaySound(As_8);
}

// 52816FC294B743371D2310C8F7932270
string f0_0(int A_timeframe_0) {
   if (A_timeframe_0 == 0) A_timeframe_0 = Period();
   switch (A_timeframe_0) {
   case PERIOD_M1:
      return ("M1");
   case PERIOD_M5:
      return ("M5");
   case PERIOD_M15:
      return ("M15");
   case PERIOD_M30:
      return ("M30");
   case PERIOD_H1:
      return ("H1");
   case PERIOD_H4:
      return ("H4");
   case PERIOD_D1:
      return ("D1");
   case PERIOD_W1:
      return ("W1");
   case PERIOD_MN1:
      return ("MN1");
   }
   return (DoubleToStr(A_timeframe_0, 0));
}

// D6656A8D64D65CF0598F40C90D5A4663
void f0_2(double Ad_0, double Ad_8, double Ad_16, double Ad_24) {
   if (Gi_160 != 1 && Ad_0 != 0.0 && Ad_8 == 0.0 && Ad_16 == 0.0 && Ad_24 != 0.0) {
      Gi_160 = 1;
      f0_1("BUY SIGNAL", SoundFileLong);
   }
   if (Gi_160 != 2 && Ad_0 == 0.0 && Ad_8 != 0.0 && Ad_16 != 0.0 && Ad_24 == 0.0) {
      Gi_160 = 2;
      f0_1("SELL SIGNAL", SoundFileShort);
   }
}
