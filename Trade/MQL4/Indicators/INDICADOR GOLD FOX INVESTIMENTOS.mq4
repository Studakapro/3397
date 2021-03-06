
#property copyright "INDICADOR GOLD FOX INVESTIMENTOS 2019"
#property link      "https://www.youtube.com/channel/UCpMSib_BYFBxSRsSMuG9K4g?view_as=subscriber"

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 Black
#property indicator_color2 Black

extern int AlertPercentage = 63;
extern bool AdvancedMode = TRUE;
extern int ReturnITM = 87;
extern int Balance = 0;
extern bool SendAlerts = TRUE;
extern bool SendPhoneNotifications = FALSE;
extern bool SendEmails = FALSE;
double Gda_104[];
double Gda_108[];
double Gda_112[];
double Gda_116[];
double Gda_120[];
double Gda_124[];
int Gi_128;
int Gi_132;
int Gi_156;
int Gi_160;
int Gi_164;
int Gi_168;
int Gi_172;
int Gi_176;
int Gi_180;
int Gi_184;
double Gd_212;
double Gd_220;
double Gd_228;
double Gd_236;
double Gd_268;
double Gd_276;
double Gd_284;
double Gd_292;
datetime Gt_320;
double Gd_324;
bool Gi_332;
bool Gi_336;
bool Gi_340 = TRUE;
bool Gi_344;
string Gs_352;
string Gs_360;

// E37F0136AA3FFAF149B351F6A4C948E9
int init() {
   IndicatorBuffers(6);
   SetIndexStyle(0, DRAW_ARROW, STYLE_SOLID, 2);
   SetIndexBuffer(0, Gda_104);
   SetIndexStyle(1, DRAW_ARROW, STYLE_SOLID, 2);
   SetIndexBuffer(1, Gda_108);
   SetIndexStyle(2, DRAW_ARROW, STYLE_SOLID, 2);
   SetIndexBuffer(2, Gda_112);
   SetIndexStyle(3, DRAW_ARROW, STYLE_SOLID, 2);
   SetIndexBuffer(3, Gda_116);
   SetIndexStyle(4, DRAW_NONE);
   SetIndexBuffer(4, Gda_120);
   SetIndexStyle(5, DRAW_NONE);
   SetIndexBuffer(5, Gda_124);
   SetIndexArrow(0, 233);
   SetIndexArrow(1, 234);
   SetIndexArrow(2, 74);
   SetIndexArrow(3, 76);
   IndicatorShortName("GOLD INDICADOR ( WHATSAPP: +55 21992730831 FOX INVESTIMENTOS");
   
   return (0);
}
		  			 	 	   			 				 	  	 	  	 	  						 					 			 	  	   		   	 	    	 			 			 		      	   	    	   				 		 			 		 		 	 		   		  		   	 	 		 	
// 52D46093050F38C27267BCE42543EF60
int deinit() {
   return (0);
}
	  	 		 					 					  	 	 			   	   	 				    			  	 		  		 	 	      	   			   					 	    				 	  	  	  		 		 	 		     		        	  	 	      			 	
// EA2B2676C28C0DB26D39331A336C6B92
int start() {
   string Ls_0;
   string Ls_8;
   string Ls_16;
   string Ls_24;
   string Ls_32;
   string Ls_40;
   color Li_48;
   string Ls_52;
   int Li_60;
   if (Gt_320 != Time[0]) {
      Gda_104[0] = -1;
      Gda_108[0] = -1;
      Gda_112[0] = -1;
      Gda_116[0] = -1;
      Gda_120[0] = 0.5;
      Gda_124[0] = 0.5;
      Gd_324 = iStochastic(NULL, 0, 4, 1, 3, MODE_SMA, 0, MODE_MAIN, 0);
      Gda_120[0] = (-0.161 * Gd_324) + 58.208;
      Gda_124[0] = 100 - Gda_120[0];
      if (Low[0] < Low[1] && Low[0] < Low[2] && Low[0] < Low[3] && Low[1] < Low[2] && Close[1] < Close[2] && High[1] <= High[2]) Gda_120[0] = (-0.8181 * Gd_324) + 90.0;
      if (High[0] > High[1] && High[0] > High[2] && High[0] > High[3] && High[1] > High[2] && Close[1] > Close[2] && Low[1] >= Low[2]) Gda_124[0] = 100 - ((-0.8181 * Gd_324) + 90.0);
      if (Gda_120[0] > 100.0) Gda_120[0] = 90;
      if (Gda_124[0] > 100.0) Gda_124[0] = 90;
      if (Close[1] - 0.001 > Open[0] || Open[0] > Close[1] + 0.001 || Close[2] - 0.001 > Open[1] || Open[1] > Close[2] + 0.001 || Close[3] - 0.001 > Open[2] || Open[2] > Close[3] +
         0.001 || Close[4] - 0.001 > Open[3] || Open[3] > Close[4] + 0.001 || Close[5] - 0.001 > Open[4] || Open[4] > Close[5] + 0.001 || Close[6] - 0.001 > Open[5] || Open[5] > Close[6] +
         0.001 || Close[7] - 0.001 > Open[6] || Open[6] > Close[7] + 0.001 || Close[8] - 0.001 > Open[7] || Open[7] > Close[8] + 0.001) Gi_344 = TRUE;
      else Gi_344 = False;
      if ((Gda_104[1] != -1.0 && Close[1] > Open[1]) || (Gda_108[1] != -1.0 && Close[1] < Open[1])) {
         if ((Gda_120[1] > 55.0 && Gda_120[1] <= 60.0) || (Gda_124[1] > 55.0 && Gda_124[1] <= 60.0)) {
            Gi_156++;
            if (AdvancedMode) Gd_284 = Gd_292 / 100.0;
         }
         if ((Gda_120[1] > 60.0 && Gda_120[1] <= 65.0) || (Gda_124[1] > 60.0 && Gda_124[1] <= 65.0)) {
            Gi_160++;
            if (AdvancedMode) Gd_284 = Gd_292 / 50.0;
         }
         if ((Gda_120[1] > 65.0 && Gda_120[1] <= 100.0) || (Gda_124[1] > 65.0 && Gda_124[1] <= 100.0)) {
            Gi_164++;
            if (AdvancedMode) Gd_284 = 0.05 * Gd_292;
         }
         Gd_276 += Gd_284 * ReturnITM / 100.0;
         if (Gda_104[1] != -1.0 && Gda_104[1] != EMPTY_VALUE) {
            Gda_112[1] = High[1] + 0.000;
            Gs_352 = Gs_352 + TimeDay(Time[1]) + "/" + TimeMonth(Time[1]) + "/" + TimeYear(Time[1]) + ";" + DoubleToStr(Gd_284, 0) + "$;" + "CALL;" + DoubleToStr(Open[1], 5) + ";" + DoubleToStr(Close[1],
               5) + ";" + DoubleToStr(Gd_284 * ReturnITM / 100.0, 0) + "$\r\n";
            if (AdvancedMode) ObjectSetText("upB" + Gi_128, "+" + DoubleToStr(Gd_284 * ReturnITM / 100.0, 0) + "$", 10, "Arial", Blue);
         }
         if (Gda_108[1] != -1.0 && Gda_108[1] != EMPTY_VALUE) {
            Gda_112[1] = Low[1] - 0.000;
            Gs_352 = Gs_352 + TimeDay(Time[1]) + "/" + TimeMonth(Time[1]) + "/" + TimeYear(Time[1]) + ";" + DoubleToStr(Gd_284, 0) + "$;" + "PUT;" + DoubleToStr(Open[1], 5) + ";" + DoubleToStr(Close[1],
               5) + ";" + DoubleToStr(Gd_284 * ReturnITM / 100.0, 0) + "$\r\n";
            if (AdvancedMode) ObjectSetText("downB" + Gi_132, "+" + DoubleToStr(Gd_284 * ReturnITM / 100.0, 0) + "$", 10, "Arial", Blue);
         }
      }
      if ((Gda_104[1] != -1.0 && Close[1] < Open[1]) || (Gda_108[1] != -1.0 && Close[1] > Open[1])) {
         if ((Gda_120[1] > 55.0 && Gda_120[1] <= 60.0) || (Gda_124[1] > 55.0 && Gda_124[1] <= 60.0)) {
            Gi_172++;
            if (AdvancedMode) Gd_284 = Gd_292 / 100.0;
         }
         if ((Gda_120[1] > 60.0 && Gda_120[1] <= 65.0) || (Gda_124[1] > 60.0 && Gda_124[1] <= 65.0)) {
            Gi_176++;
            if (AdvancedMode) Gd_284 = Gd_292 / 50.0;
         }
         if ((Gda_120[1] > 65.0 && Gda_120[1] <= 100.0) || (Gda_124[1] > 65.0 && Gda_124[1] <= 100.0)) {
            Gi_180++;
            if (AdvancedMode) Gd_284 = 0.05 * Gd_292;
         }
         Gd_276 -= Gd_284;
         if (Gda_104[1] != -1.0 && Gda_104[1] != EMPTY_VALUE) {
            Gda_116[1] = High[1] + 0.001;
            Gs_352 = Gs_352 + TimeDay(Time[1]) + "/" + TimeMonth(Time[1]) + "/" + TimeYear(Time[1]) + ";" + DoubleToStr(Gd_284, 0) + "$;" + "CALL;" + DoubleToStr(Open[1], 5) + ";" + DoubleToStr(Close[1],
               5) + ";0$\r\n";
            ObjectSetText("upB" + Gi_128, "-" + DoubleToStr(Gd_284, 0) + "$", 10, "Arial", Red);
         }
         if (Gda_108[1] != -1.0 && Gda_108[1] != EMPTY_VALUE) {
            Gda_116[1] = Low[1] - 0.001;
            Gs_352 = Gs_352 + TimeDay(Time[1]) + "/" + TimeMonth(Time[1]) + "/" + TimeYear(Time[1]) + ";" + DoubleToStr(Gd_284, 0) + "$;" + "PUT;" + DoubleToStr(Open[1], 5) + ";" + DoubleToStr(Close[1],
               5) + ";0$\r\n";
            ObjectSetText("downB" + Gi_132, "-" + DoubleToStr(Gd_284, 0) + "$", 10, "Arial", Red);
         }
      }
      Gi_168 = Gi_156 + Gi_160 + Gi_164;
      Gi_184 = Gi_172 + Gi_176 + Gi_180;
      if (Gi_156 + Gi_172 != 0) Gd_212 = 100.0 * Gi_156 / (Gi_156 + 1.0 * Gi_172);
      if (Gi_160 + Gi_176 != 0) Gd_220 = 100.0 * Gi_160 / (Gi_160 + 1.0 * Gi_176);
      if (Gi_164 + Gi_180 != 0) Gd_228 = 100.0 * Gi_164 / (Gi_164 + 1.0 * Gi_180);
      if (Gi_168 + Gi_184 != 0) Gd_236 = 100.0 * Gi_168 / (Gi_168 + 1.0 * Gi_184);
      Gd_268 = 85 * Gi_156 + 170 * Gi_160 + 425 * Gi_164 - (100 * Gi_172 + 200 * Gi_176 + 500 * Gi_180);
      Gd_292 = Balance + Gd_276;
      if ((Gda_120[0] > 55.0 && Gda_120[0] <= 60.0) || (Gda_124[0] > 55.0 && Gda_124[0] <= 60.0))
         if (AdvancedMode) Gd_284 = Gd_292 / 100.0;
      if ((Gda_120[0] > 60.0 && Gda_120[0] <= 65.0) || (Gda_124[0] > 60.0 && Gda_124[0] <= 65.0))
         if (AdvancedMode) Gd_284 = Gd_292 / 50.0;
      if ((Gda_120[0] > 65.0 && Gda_120[0] <= 100.0) || (Gda_124[0] > 65.0 && Gda_124[0] <= 100.0))
         if (AdvancedMode) Gd_284 = 0.05 * Gd_292;
      if (AdvancedMode) {
         if (ObjectFind("simText3n13") != -1) ObjectDelete("simText3n13");
         if (ObjectFind("simText1n14") != -1) ObjectDelete("simText1n14");
         if (ObjectFind("simText2n12") != -1) ObjectDelete("simText2n12");
         if (ObjectFind("simText1n11") != -1) ObjectDelete("simText1n11");
         if (ObjectFind("ProbText7") != -1) ObjectDelete("ProbText7");
         if (ObjectFind("simText1n1") != 0) {
            ObjectCreate("simText1n1", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n1", "Probabilidade T1 T2", 7, "Verdana", Black);
            ObjectSet("simText1n1", OBJPROP_CORNER, 1);
            ObjectSet("simText1n1", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText1n1", OBJPROP_YDISTANCE, 100);
         }
         if (ObjectFind("simText1n2") != 0) {
            ObjectCreate("simText1n2", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n2", "55-60%", 7, "Verdana", Black);
            ObjectSet("simText1n2", OBJPROP_CORNER, 1);
            ObjectSet("simText1n2", OBJPROP_XDISTANCE, 170);
            ObjectSet("simText1n2", OBJPROP_YDISTANCE, 120);
         }
         if (ObjectFind("simText1n3") != 0) {
            ObjectCreate("simText1n3", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n3", "60-65%", 7, "Verdana", Black);
            ObjectSet("simText1n3", OBJPROP_CORNER, 1);
            ObjectSet("simText1n3", OBJPROP_XDISTANCE, 170);
            ObjectSet("simText1n3", OBJPROP_YDISTANCE, 140);
         }
         if (ObjectFind("simText1n4") != 0) {
            ObjectCreate("simText1n4", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n4", "65+%", 7, "Verdana", Black);
            ObjectSet("simText1n4", OBJPROP_CORNER, 1);
            ObjectSet("simText1n4", OBJPROP_XDISTANCE, 182);
            ObjectSet("simText1n4", OBJPROP_YDISTANCE, 160);
         }
         if (ObjectFind("simText1n5") != 0) {
            ObjectCreate("simText1n5", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n5", "" + Gi_156, 7, "Verdana", Blue);
            ObjectSet("simText1n5", OBJPROP_CORNER, 1);
            ObjectSet("simText1n5", OBJPROP_XDISTANCE, 125);
            ObjectSet("simText1n5", OBJPROP_YDISTANCE, 120);
         } else ObjectSetText("simText1n5", "" + Gi_156, 7, "Verdana", Blue);
         if (ObjectFind("simText2n6") != 0) {
            ObjectCreate("simText2n6", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText2n6", "" + Gi_160, 7, "Verdana", Blue);
            ObjectSet("simText2n6", OBJPROP_CORNER, 1);
            ObjectSet("simText2n6", OBJPROP_XDISTANCE, 125);
            ObjectSet("simText2n6", OBJPROP_YDISTANCE, 140);
         } else ObjectSetText("simText2n6", "" + Gi_160, 7, "Verdana", Blue);
         if (ObjectFind("simText3n7") != 0) {
            ObjectCreate("simText3n7", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText3n7", "" + Gi_164, 7, "Verdana", Blue);
            ObjectSet("simText3n7", OBJPROP_CORNER, 1);
            ObjectSet("simText3n7", OBJPROP_XDISTANCE, 125);
            ObjectSet("simText3n7", OBJPROP_YDISTANCE, 160);
         } else ObjectSetText("simText3n7", "" + Gi_164, 7, "Verdana", Blue);
         if (ObjectFind("simText1n8") != 0) {
            ObjectCreate("simText1n8", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n8", "" + Gi_172, 7, "Verdana", Red);
            ObjectSet("simText1n8", OBJPROP_CORNER, 1);
            ObjectSet("simText1n8", OBJPROP_XDISTANCE, 90);
            ObjectSet("simText1n8", OBJPROP_YDISTANCE, 120);
         } else ObjectSetText("simText1n8", "" + Gi_172, 7, "Verdana", Red);
         if (ObjectFind("simText2n9") != 0) {
            ObjectCreate("simText2n9", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText2n9", "" + Gi_176, 7, "Verdana", Red);
            ObjectSet("simText2n9", OBJPROP_CORNER, 1);
            ObjectSet("simText2n9", OBJPROP_XDISTANCE, 90);
            ObjectSet("simText2n9", OBJPROP_YDISTANCE, 140);
         } else ObjectSetText("simText2n9", "" + Gi_176, 7, "Verdana", Red);
         if (ObjectFind("simText3n10") != 0) {
            ObjectCreate("simText3n10", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText3n10", "" + Gi_180, 7, "Verdana", Red);
            ObjectSet("simText3n10", OBJPROP_CORNER, 1);
            ObjectSet("simText3n10", OBJPROP_XDISTANCE, 90);
            ObjectSet("simText3n10", OBJPROP_YDISTANCE, 160);
         } else ObjectSetText("simText3n10", "" + Gi_180, 7, "Verdana", Red);
         Ls_0 = DoubleToStr(Gd_212, 2) + "%";
         if (ObjectFind("simText1") != 0) {
            ObjectCreate("simText1", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1", Ls_0, 7, "Verdana", Black);
            ObjectSet("simText1", OBJPROP_CORNER, 1);
            ObjectSet("simText1", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText1", OBJPROP_YDISTANCE, 120);
         } else ObjectSetText("simText1", Ls_0, 7, "Verdana", Black);
         Ls_8 = DoubleToStr(Gd_220, 2) + "%";
         if (ObjectFind("simText2") != 0) {
            ObjectCreate("simText2", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText2", Ls_8, 7, "Verdana", Black);
            ObjectSet("simText2", OBJPROP_CORNER, 1);
            ObjectSet("simText2", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText2", OBJPROP_YDISTANCE, 140);
         } else ObjectSetText("simText2", Ls_8, 7, "Verdana", Black);
         Ls_16 = DoubleToStr(Gd_228, 2) + "%";
         if (ObjectFind("simText3") != 0) {
            ObjectCreate("simText3", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText3", Ls_16, 7, "Verdana", Black);
            ObjectSet("simText3", OBJPROP_CORNER, 1);
            ObjectSet("simText3", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText3", OBJPROP_YDISTANCE, 160);
         } else ObjectSetText("simText3", Ls_16, 7, "Verdana", Black);
         Ls_24 = "Profit :" + DoubleToStr(Gd_276, 0);
         if (ObjectFind("simText5") != 0) {
            ObjectCreate("simText5", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText5", Ls_24, 10, "Impact", Blue);
            ObjectSet("simText5", OBJPROP_CORNER, 1);
            ObjectSet("simText5", OBJPROP_XDISTANCE, 150);
            ObjectSet("simText5", OBJPROP_YDISTANCE, 200);
         } else ObjectSetText("simText5", Ls_24, 10, "Impact", Blue);
         Ls_32 = "Balance :" + DoubleToStr(Gd_292, 0);
         if (ObjectFind("simText6") != 0) {
            ObjectCreate("simText6", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText6", Ls_32, 10, "Impact", Black);
            ObjectSet("simText6", OBJPROP_CORNER, 1);
            ObjectSet("simText6", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText6", OBJPROP_YDISTANCE, 200);
         } else ObjectSetText("simText6", Ls_32, 10, "Impact", Black);
      } else {
         if (ObjectFind("simText1n11") != 0) {
            ObjectCreate("simText1n11", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n11", "Probalidade    T1          T2        ", 7, "Verdana", Black);
            ObjectSet("simText1n11", OBJPROP_CORNER, 1);
            ObjectSet("simText1n11", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText1n11", OBJPROP_YDISTANCE, 100);
         } else ObjectSetText("simText1n11", "Probalidade    T1            T2    ", 7, "Verdana", Black);
         if (ObjectFind("simText2n12") != 0) {
            ObjectCreate("simText2n12", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText2n12", DoubleToStr(Gd_236, 1) + "%", 7, "Verdana", Black);
            ObjectSet("simText2n12", OBJPROP_CORNER, 1);
            ObjectSet("simText2n12", OBJPROP_XDISTANCE, 10);
            ObjectSet("simText2n12", OBJPROP_YDISTANCE, 120);
         } else ObjectSetText("simText2n12", DoubleToStr(Gd_236, 1) + "%", 7, "Verdana", Black);
         if (ObjectFind("simText3n13") != 0) {
            ObjectCreate("simText3n13", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText3n13", "" + Gi_168, 7, "Verdana", Blue);
            ObjectSet("simText3n13", OBJPROP_CORNER, 1);
            ObjectSet("simText3n13", OBJPROP_XDISTANCE, 190);
            ObjectSet("simText3n13", OBJPROP_YDISTANCE, 120);
         } else ObjectSetText("simText3n13", "" + Gi_168, 7, "Verdana", Blue);
         if (ObjectFind("simText1n14") != 0) {
            ObjectCreate("simText1n14", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("simText1n14", "" + Gi_184, 7, "Verdana", Red);
            ObjectSet("simText1n14", OBJPROP_CORNER, 1);
            ObjectSet("simText1n14", OBJPROP_XDISTANCE, 120);
            ObjectSet("simText1n14", OBJPROP_YDISTANCE, 120);
         } else ObjectSetText("simText1n14", "" + Gi_184, 7, "Verdana", Red);
      }
      Li_48 = Orange;
      Ls_52 = "+++Aguarde o Próximo Sinal+++";
      Li_60 = 0;
      if (Gda_120[0] > AlertPercentage && Gda_120[0] >= Gda_124[0] && (!Gi_344)) {
         Li_48 = Blue;
         Li_48 = Blue;
         Ls_52 = "CALL (CIMA)       ";
         Ls_40 = DoubleToStr(Gda_120[0], 1) + "%";
         Gda_124[0] = 50;
         Gi_332 = TRUE;
         Gi_336 = FALSE;
      } else {
         if (Gda_124[0] > AlertPercentage && Gda_124[0] >= Gda_120[0] && (!Gi_344)) {
            Li_48 = Red;
            Li_48 = Red;
            Ls_52 = "PUT (BAIXO)     ";
            Ls_40 = DoubleToStr(Gda_124[0], 1) + "%";
            Gda_120[0] = 50;
            Gi_336 = TRUE;
            Gi_332 = FALSE;
         } else {
            Ls_40 = DoubleToStr(MathMax(Gda_124[0], Gda_120[0]), 1) + "%";
            Gi_336 = FALSE;
            Gi_332 = FALSE;
         }
      }
      if (ObjectFind("ProbText0") != 0) {
         ObjectCreate("ProbText0", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("ProbText0", ">>>INDICADOR GOLD FOX ATIVO<<<", 10, "Orange", Li_48);
         ObjectSet("ProbText0", OBJPROP_CORNER, 1);
         ObjectSet("ProbText0", OBJPROP_XDISTANCE, 30);
         ObjectSet("ProbText0", OBJPROP_YDISTANCE, 5);
      } else ObjectSetText("ProbText0", ">>>INDICADOR FOX GOLD ATIVO<<<", 10, "Orange", Li_48);
      if (ObjectFind("ProbText1") != 0) {
         ObjectCreate("ProbText1", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("ProbText1", "=======================", 10, "Verdana", Li_48);
         ObjectSet("ProbText1", OBJPROP_CORNER, 1);
         ObjectSet("ProbText1", OBJPROP_XDISTANCE, 10);
         ObjectSet("ProbText1", OBJPROP_YDISTANCE, 20);
      } else ObjectSetText("ProbText1", "=======================", 10, "Verdana", Li_48);
      if (ObjectFind("ProbText2") != 0) {
         ObjectCreate("ProbText2", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("ProbText2", Ls_40, 20, "Impact", Li_48);
         ObjectSet("ProbText2", OBJPROP_CORNER, 1);
         ObjectSet("ProbText2", OBJPROP_XDISTANCE, 65);
         ObjectSet("ProbText2", OBJPROP_YDISTANCE, 30);
      } else ObjectSetText("ProbText2", Ls_40, 20, "Impact", Li_48);
      if (ObjectFind("ProbText3") != 0) {
         ObjectCreate("ProbText3", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("ProbText3", Ls_52, 15, "Verdana", Li_48);
         ObjectSet("ProbText3", OBJPROP_CORNER, 1);
         ObjectSet("ProbText3", OBJPROP_XDISTANCE, 10);
         ObjectSet("ProbText3", OBJPROP_YDISTANCE, 60);
      } else ObjectSetText("ProbText3", Ls_52, 15, "Verdana", Li_48);
      if (ObjectFind("ProbText4") != 0) {
         ObjectCreate("ProbText4", OBJ_LABEL, 0, 0, 0);
         ObjectSetText("ProbText4", "=======================", 10, "Verdana", Li_48);
         ObjectSet("ProbText4", OBJPROP_CORNER, 1);
         ObjectSet("ProbText4", OBJPROP_XDISTANCE, 10);
         ObjectSet("ProbText4", OBJPROP_YDISTANCE, 80);
      } else ObjectSetText("ProbText4", "=======================", 10, "Verdana", Li_48);
      if (AdvancedMode) {
         if (ObjectFind("ProbText5") != 0) {
            ObjectCreate("ProbText5", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("ProbText5", "=======================", 10, "Verdana", Li_48);
            ObjectSet("ProbText5", OBJPROP_CORNER, 1);
            ObjectSet("ProbText5", OBJPROP_XDISTANCE, 10);
            ObjectSet("ProbText5", OBJPROP_YDISTANCE, 180);
         } else ObjectSetText("ProbText5", "=======================", 10, "Verdana", Li_48);
         if (ObjectFind("ProbText6") != 0) {
            ObjectCreate("ProbText6", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("ProbText6", "=======================", 10, "Verdana", Li_48);
            ObjectSet("ProbText6", OBJPROP_CORNER, 1);
            ObjectSet("ProbText6", OBJPROP_XDISTANCE, 10);
            ObjectSet("ProbText6", OBJPROP_YDISTANCE, 220);
         } else ObjectSetText("ProbText6", "=======================", 10, "Verdana", Li_48);
      } else {
         if (ObjectFind("ProbText7") != 0) {
            ObjectCreate("ProbText7", OBJ_LABEL, 0, 0, 0);
            ObjectSetText("ProbText7", "=======================", 10, "Verdana", Li_48);
            ObjectSet("ProbText7", OBJPROP_CORNER, 1);
            ObjectSet("ProbText7", OBJPROP_XDISTANCE, 10);
            ObjectSet("ProbText7", OBJPROP_YDISTANCE, 140);
         } else ObjectSetText("ProbText7", "=======================", 10, "Verdana", Li_48);
      }
      if (Gi_332) {
         if (SendAlerts) Alert("SINAL CALL (" + DoubleToStr(Gda_120[0], 2) + "% Probabilidade)");
         if (SendPhoneNotifications) SendNotification("SINAL CALL (" + DoubleToStr(Gda_120[0], 1) + "% Probabilidade)");
         if (SendEmails) SendMail("SINAL CALL (" + DoubleToStr(Gda_120[0], 1) + "% Probability)", "SINAL CALL (" + DoubleToStr(Gda_120[0], 1) + "% Probability)");
         Gda_104[0] = Close[0] - 0.002;
         Gi_128++;
         ObjectCreate("up" + Gi_128, OBJ_TEXT, 0, Time[1], Low[0] - 0.004);
         ObjectSetText("up" + Gi_128, DoubleToStr(Gda_120[0], 1) + "%", 10, "Arial", Orange);
         ObjectSet("up" + Gi_128, OBJPROP_ANGLE, 90);
         if (AdvancedMode) {
            ObjectCreate("upB" + Gi_128, OBJ_TEXT, 0, Time[0], High[0] + 0.004);
            ObjectSetText("upB" + Gi_128, DoubleToStr(Gd_284, 0) + "$", 10, "Arial", Orange);
            ObjectSet("upB" + Gi_128, OBJPROP_ANGLE, 90);
         }
      }
      if (Gi_336) {
         if (SendAlerts) Alert("SINAL PUT (" + DoubleToStr(Gda_124[0], 2) + "% Probabilidade)");
         if (SendPhoneNotifications) SendNotification("SINAL PUT (" + DoubleToStr(Gda_124[0], 1) + "% Probabilidade)");
         if (SendEmails) SendMail("SINAL PUT (" + DoubleToStr(Gda_124[0], 1) + "% Probabilidade)", "SINAL PUT (" + DoubleToStr(Gda_124[0], 1) + "% Probability)");
         Gda_108[0] = Close[0] + 0.002;
         Gi_132++;
         ObjectCreate("down" + Gi_132, OBJ_TEXT, 0, Time[1], High[0] + 0.004);
         ObjectSetText("down" + Gi_132, DoubleToStr(Gda_124[0], 1) + "%", 10, "Arial", Orange);
         ObjectSet("down" + Gi_132, OBJPROP_ANGLE, 90);
         if (AdvancedMode) {
            ObjectCreate("downB" + Gi_132, OBJ_TEXT, 0, Time[0], Low[0] - 0.004);
            ObjectSetText("downB" + Gi_132, DoubleToStr(Gd_284, 0) + "$", 10, "Arial", Orange);
            ObjectSet("downB" + Gi_132, OBJPROP_ANGLE, 90);
         }
      }
      Gt_320 = Time[0];
   }
   if (Gda_104[0] != -1.0 && Gda_104[0] != EMPTY_VALUE) {
      Gda_104[0] = Low[0] - 0.001;
      ObjectSet("up" + Gi_128, OBJPROP_PRICE1, Low[0] - 0.002);
      if (AdvancedMode) ObjectSet("upB" + Gi_128, OBJPROP_PRICE1, High[0] + 0.002);
   }
   if (Gda_108[0] != -1.0 && Gda_108[0] != EMPTY_VALUE) {
      Gda_108[0] = High[0] + 0.001;
      ObjectSet("down" + Gi_132, OBJPROP_PRICE1, High[0] + 0.002);
      if (AdvancedMode) ObjectSet("downB" + Gi_132, OBJPROP_PRICE1, Low[0] - 0.002);
   }
   return (0);
}