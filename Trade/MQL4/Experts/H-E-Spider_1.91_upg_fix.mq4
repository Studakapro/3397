
#property copyright "copyright:Hamed Ehtemam  www.hespider.com"
#property link      "http://www.hespider.com/"

string Key = "Enter the license code here";
extern string OPMM = "------------------Lot settings------------------";
extern double LotsStep = 0.01;
extern string H1 = "Increase lot size every BalanceStep of balance";
extern double BalanceStep = 80.0;
extern string H2 = "Minumum lot size.If Use MM=false EA use this value for fixed lot size";
extern double MinLots = 0.01;
extern double MaxLots = 1000.0;
extern bool UseMM = TRUE;
extern bool Recovery = FALSE;
extern string OPSC = "------------------ Scaner settings-----------------";
extern int MaxTP = 60;
extern int MaxSL = 40;
extern int Filter = 20;
extern int Landa = 10;
extern int Teta = 6;
extern bool HuntPPulse = TRUE;
extern bool HuntSPulse = TRUE;
extern bool TradeEverySignal = FALSE;
extern string OPTR = "------------------ Trade settings-----------------";
extern string H4 = "Only set this to false if your broker doesnt support expiration!";
extern bool UseExpiration = TRUE;
extern bool FakeStop = TRUE;
extern bool HideSL = FALSE;
int g_slippage_216 = 10;
extern int magicnumber = 1010325;
extern string H5 = "Update on screen information";
extern bool UpdateHUD = TRUE;
int gi_236;
extern string EAComment = "H-ESpider";
double gd_248;
int gia_256[2];
int gi_260 = 0;
int g_acc_number_264 = 0;

int init() {
   if (IsOptimization() || IsTesting()) GlobalVariableSet(f0_6(), MinLots);
   gd_248 = Point;
   if (Digits == 5 || Digits == 3) gd_248 = 10.0 * gd_248;
   if (IsDemo()) gi_260 = TRUE;
   g_acc_number_264 = AccountNumber();
   f0_1();
   gia_256[1] = -1;
   return (1);
}

int deinit() {
   if (IsTesting()) GlobalVariableDel(f0_6());
   f0_14();
   return (0);
}

int start() {
   int li_0;
   int li_4;
   double lda_8[6];
   double lda_12[6];
   int lia_16[6];
   double l_icustom_20;
   double lda_28[3];
   f0_11();
   if (gia_256[1] == 0 && TimeCurrent() < gi_236) return (-1);
   if (gia_256[1] != 1 && gia_256[1] != -1) Print("Invalid Key!!! No new trade will be opened.");
   gi_236 = TimeCurrent() + 300;
   bool li_32 = TRUE;
   bool li_36 = TRUE;
   bool li_40 = TRUE;
   bool li_44 = TRUE;
   double l_icustom_48 = 0;
   int l_index_56 = 0;
   for (int li_60 = 0; li_60 < 500; li_60++) {
      l_icustom_48 = iCustom(NULL, 0, "H-EImpulse", 1, li_60);
      if (li_60 == 0) l_icustom_20 = l_icustom_48;
      if (l_icustom_48 != 0.0) {
         lda_8[l_index_56] = l_icustom_48;
         lia_16[l_index_56] = li_60;
         lda_12[l_index_56] = iCustom(NULL, 0, "H-EImpulse", 0, li_60);
         if (l_index_56 == 5) break;
         l_index_56++;
      }
   }
   for (int l_pos_64 = 0; l_pos_64 < OrdersTotal(); l_pos_64++) {
      if (OrderSelect(l_pos_64, SELECT_BY_POS, MODE_TRADES) && OrderSymbol() == Symbol() && OrderMagicNumber() == magicnumber) {
         if (OrderType() == OP_BUYSTOP || OrderType() == OP_BUY) {
            if (OrderComment() == f0_0("P")) {
               li_32 = FALSE;
               li_0++;
            }
            if (OrderComment() == f0_0("S")) {
               li_40 = FALSE;
               li_4++;
            }
         } else {
            if (OrderType() == OP_SELLSTOP || OrderType() == OP_SELL) {
               if (OrderComment() == f0_0("P")) {
                  li_36 = FALSE;
                  li_0++;
               }
               if (OrderComment() == f0_0("S")) {
                  li_44 = FALSE;
                  li_4++;
               }
            }
         }
      }
   }
   f0_15(li_0, li_4);
   double ld_unused_68 = lda_8[0];
   double ld_unused_76 = lda_8[1];
   double ld_unused_84 = lda_8[2];
   int li_unused_92 = lia_16[0];
   int li_unused_96 = lia_16[1];
   int li_unused_100 = lia_16[2];
   int li_104 = 1;
   if (!FakeStop) li_104 = -1;
   int li_108 = iTime(Symbol(), 0, 0) + 60 * (Teta * Period()) - 60;
   if (!UseExpiration) li_108 = 0;
   if (HuntPPulse) {
      if (CanTrade(0, gd_248, Filter, Landa, MaxTP, MaxSL, li_104, lda_8, lda_12, lia_16, lda_28, gia_256, g_acc_number_264, gi_260, Key) == 1)
         if (TradeEverySignal || li_32) f0_9(OP_BUYSTOP, lda_28[0], lda_28[1], lda_28[2], f0_0("P"), li_108);
      if (CanTrade(1, gd_248, Filter, Landa, MaxTP, MaxSL, li_104, lda_8, lda_12, lia_16, lda_28, gia_256, g_acc_number_264, gi_260, Key) == 1)
         if (TradeEverySignal || li_36) f0_9(OP_SELLSTOP, lda_28[0], lda_28[1], lda_28[2], f0_0("P"), li_108);
   }
   if (HuntSPulse) {
      if (l_icustom_20 != 0.0 && CanTrade(2, gd_248, Filter, Landa, MaxTP, MaxSL, li_104, lda_8, lda_12, lia_16, lda_28, gia_256, g_acc_number_264, gi_260, Key) == 1)
         if (TradeEverySignal || li_40) f0_9(OP_BUYSTOP, lda_28[0], lda_28[1], lda_28[2], f0_0("S"), li_108);
      if (l_icustom_20 != 0.0 && CanTrade(3, gd_248, Filter, Landa, MaxTP, MaxSL, li_104, lda_8, lda_12, lia_16, lda_28, gia_256, g_acc_number_264, gi_260, Key) == 1)
         if (TradeEverySignal || li_44) f0_9(OP_SELLSTOP, lda_28[0], lda_28[1], lda_28[2], f0_0("S"), li_108);
   }
   return (0);
}

void f0_11() {
   int l_ord_total_0 = OrdersTotal();
   for (int l_pos_4 = 0; l_pos_4 < l_ord_total_0; l_pos_4++) {
      OrderSelect(l_pos_4, SELECT_BY_POS, MODE_TRADES);
      if (f0_4() == 1) {
         if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, 10, Yellow);
         if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, 10, Yellow);
      }
   }
}

int f0_4() {
   if (OrderSymbol() != Symbol() || OrderMagicNumber() != magicnumber) return (0);
   if (OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP)
      if (TimeCurrent() - OrderOpenTime() >= 60 * (Teta * Period()) - 55) OrderDelete(OrderTicket());
   if (OrderType() == OP_BUY && Bid - OrderOpenPrice() >= MaxTP * gd_248 || Bid - OrderOpenPrice() <= (-MaxSL) * gd_248) return (1);
   if (OrderType() == OP_SELL && OrderOpenPrice() - Ask >= MaxTP * gd_248 || OrderOpenPrice() - Ask <= (-MaxSL) * gd_248) return (1);
   return (0);
}

string f0_6() {
   string l_str_concat_0;
   if (IsTesting()) l_str_concat_0 = StringConcatenate("SpiderMaxLot", Symbol(), DoubleToStr(magicnumber, 0), "_Test");
   else l_str_concat_0 = StringConcatenate("SpiderMaxLot", Symbol(), DoubleToStr(magicnumber, 0));
   return (l_str_concat_0);
}

string f0_0(string as_0) {
   return (StringConcatenate(EAComment, " ", as_0));
}

double f0_5() {
   double ld_ret_0 = MinLots;
   int li_8 = AccountBalance() / BalanceStep;
   if (UseMM && li_8 > 0) {
      ld_ret_0 = MathMax(LotsStep * li_8, MinLots);
      if (!GlobalVariableCheck(f0_6())) GlobalVariableSet(f0_6(), ld_ret_0);
      else
         if (Recovery) ld_ret_0 = MathMax(ld_ret_0, GlobalVariableGet(f0_6()));
      ld_ret_0 = f0_2(MathMin(ld_ret_0, MaxLots));
      GlobalVariableSet(f0_6(), ld_ret_0);
   }
   return (ld_ret_0);
}

double f0_2(double ad_0, string a_symbol_8 = "") {
   if (a_symbol_8 == "") a_symbol_8 = Symbol();
   double l_lotstep_16 = MarketInfo(a_symbol_8, MODE_LOTSTEP);
   double l_minlot_24 = MarketInfo(a_symbol_8, MODE_MINLOT);
   double ld_32 = MathRound(ad_0 / l_lotstep_16) * l_lotstep_16;
   if (ld_32 < l_minlot_24) ld_32 = l_minlot_24;
   return (MathMin(ld_32, MarketInfo(a_symbol_8, MODE_MAXLOT)));
}

void f0_7(string a_name_0, int ai_8, int ai_12, string a_text_16, color a_color_24, int a_fontsize_28 = 10, string a_fontname_32 = "Arial Black") {
   f0_8(a_name_0, ai_8, ai_12);
   ObjectSetText(a_name_0, a_text_16, a_fontsize_28, a_fontname_32, a_color_24);
}

void f0_8(string a_name_0, int a_x_8, int a_y_12) {
   ObjectCreate(a_name_0, OBJ_LABEL, 0, 0, 0);
   ObjectSet(a_name_0, OBJPROP_CORNER, 0);
   ObjectSet(a_name_0, OBJPROP_XDISTANCE, a_x_8);
   ObjectSet(a_name_0, OBJPROP_YDISTANCE, a_y_12);
}

void f0_12(int ai_0, int ai_4, string as_8, string as_16, string as_24, int ai_32 = 16777215, int ai_36 = 16777215) {
   f0_7(as_8 + "_S", ai_0, ai_4, as_16, ai_32);
   f0_7(as_8, ai_0 + 130, ai_4, as_24, ai_36);
}

void f0_1() {
   f0_7("TXT_COPYRIGHT", 0, 15, "H-ESpider Copyright ?hespider.com", White, 10, "Arial Black");
   if (Period() != PERIOD_H4) f0_7("TXT_TIMEFRAME", 0, 35, "Warning:Default time frame is H4!", Yellow, 10, "Arial Black");
   f0_7("TXT_LICENSE", 0, 50, "Validating key...", Yellow);
   f0_12(0, 70, "TXT_SPREAD", "Spread----------------", DoubleToStr(f0_10(), 1) + " Pips");
   f0_12(0, 90, "TXT_PULSE", "Pulses---------------", " ");
   f0_12(0, 150, "TXT_VERSION", "Version---------------", "1.91");
   f0_12(0, 170, "TXT_MAGIC", "MagicNumber----", magicnumber);
   if (UseMM) f0_12(0, 190, "TXT_MM", "MM-----------------------", "True");
   else f0_12(0, 190, "TXT_MM", "MM-----------------------", "False");
   if (UseMM) {
      if (Recovery) f0_12(0, 210, "TXT_RECOVERY", "Recovery------------", "On");
      else f0_12(0, 210, "TXT_RECOVERY", "Recovery------------", "Off");
   }
}

double f0_10() {
   double ld_ret_0 = (Ask - Bid) / gd_248;
   return (ld_ret_0);
}

void f0_15(int ai_0, int ai_4) {
   int li_8;
   string l_text_12;
   if (gia_256[1] == -1) {
      ObjectSetText("TXT_LICENSE", "Validating key...", 10, "Arial Black", Yellow);
      return;
   }
   if (gia_256[1] == 0) {
      ObjectSetText("TXT_LICENSE", "Activation failed! Use license manager to activate your account.", 10, "Arial Black", Red);
      return;
   }
   if (gia_256[1] == 1) ObjectSetText("TXT_LICENSE", "Active", 10, "Arial Black", Lime);
   if (UpdateHUD) {
      ObjectSetText("TXT_SPREAD", DoubleToStr(f0_10(), 1) + " Pips", 10, "Arial Black", White);
      if (ai_0 + ai_4 > 0) {
         ObjectSetText("TXT_PULSE_S", "Pulses-----------------", 10, "Arial Black", White);
         ObjectSetText("TXT_PULSE", DoubleToStr(ai_0 + ai_4, 0), 10, "Arial Black", White);
      } else {
         li_8 = MathMod(TimeCurrent(), 10);
         l_text_12 = "Pulses-";
         for (int l_count_20 = 0; l_count_20 <= li_8; l_count_20++) l_text_12 = l_text_12 + "-";
         l_text_12 = l_text_12 + "";
         ObjectSetText("TXT_PULSE_S", l_text_12, 10, "Arial Black", White);
         ObjectSetText("TXT_PULSE", "Scanning...", 10, "Arial Black", White);
      }
   }
}

void f0_13(string a_name_0) {
   ObjectDelete(a_name_0 + "_S");
   ObjectDelete(a_name_0);
}

void f0_14() {
   ObjectDelete("TXT_LICENSE");
   ObjectDelete("TXT_COPYRIGHT");
   ObjectDelete("TXT_TIMEFRAME");
   f0_13("TXT_SPREAD");
   f0_13("TXT_PULSE");
   f0_13("TXT_VERSION");
   f0_13("TXT_MM");
   f0_13("TXT_MAGIC");
   f0_13("TXT_RECOVERY");
}

void f0_9(int a_cmd_0, double a_price_4, double a_price_12, double a_price_20, string a_comment_28, int a_datetime_36) {
   if (HideSL && FakeStop) {
      if (a_cmd_0 == OP_BUYSTOP) a_price_12 -= MaxSL * gd_248;
      if (a_cmd_0 == OP_SELLSTOP) a_price_12 += MaxSL * gd_248;
   }
   if (a_cmd_0 == OP_BUYSTOP && a_price_4 < Bid) return;
   if (a_cmd_0 == OP_SELLSTOP && a_price_4 > Ask) return;
   for (int l_pos_40 = 0; l_pos_40 < OrdersTotal(); l_pos_40++) {
      if (OrderSelect(l_pos_40, SELECT_BY_POS, MODE_TRADES) && OrderSymbol() == Symbol() && OrderMagicNumber() == magicnumber)
         if (f0_3(a_price_4, OrderOpenPrice()) && f0_3(a_price_20, OrderTakeProfit()) && f0_3(a_price_12, OrderStopLoss())) return;
   }
   OrderSend(Symbol(), a_cmd_0, f0_5(), a_price_4, g_slippage_216, a_price_12, a_price_20, a_comment_28, magicnumber, a_datetime_36);
}

int f0_3(double ad_0, double ad_8) {
   if (NormalizeDouble(ad_0 - ad_8, 8) == 0.0) return (1);
   return (0);
}

int CanTrade(int ai_0, double ad_4, double ad_12, int ai_20, int ai_24, int ai_28, int ai_32, double ada_36[6], double ada_40[6], int aia_44[6], double &ada_48[3], int &aia_52[2], int ai_unused_56, int ai_unused_60, string as_unused_64) {
   double ld_80;
   double ld_88;
   double ld_96;
   double ld_104;
   double ld_112;
   double ld_120;
   double ld_128;
   double ld_136;
   double ld_144;
   double ld_152;
   double ld_160;
   double ld_168;
   double ld_176;
   double ld_212 = ada_36[0];
   double ld_188 = ada_36[1];
   double ld_196 = ada_36[2];
   double ld_72 = ada_40[3] / 2.0;
   int li_208 = aia_44[2];
   int li_204 = aia_44[0];
   aia_52[1] = 1;
   switch (ai_0) {
   case 0:
      if (ad_12 * ad_4 > ld_196 - ld_212 && li_208 - li_204 < ai_20 && ld_188 > ld_212 && ld_188 > ld_196 && ld_212 < ld_196) {
         if (ai_32 == 1) {
            ld_80 = MathMin(2.0 * ld_188 - ld_196, ad_4 * (ai_24 * 2) + ld_188);
            ada_48[2] = ld_80;
         } else {
            ld_88 = MathMin(2.0 * ld_188 - ld_196, ad_4 * ai_24 + ld_188);
            ada_48[2] = ld_88;
         }
         ld_96 = ai_28 * ad_4;
         ld_104 = ld_188;
         ld_112 = ld_104 - ld_96;
         ada_48[1] = ld_112;
         ada_48[0] = ld_104;
         return (1);
      }
      break;
   case 1:
      if (ad_12 * ad_4 < ld_212 - ld_196 && li_208 - li_204 < ai_20 && ld_188 < ld_212 && ld_188 < ld_196 && ld_212 > ld_196) {
         if (ai_32 == 1) {
            ld_120 = MathMax(2.0 * ld_188 - ld_196, ld_188 - ad_4 * (ai_24 * 2));
            ada_48[2] = ld_120;
            ld_104 = ld_188;
            ld_112 = ai_28 * ad_4 + ld_188;
         } else {
            ld_128 = MathMax(2.0 * ld_188 - ld_196, ld_188 - ad_4 * ai_24);
            ada_48[2] = ld_128;
            ld_104 = ld_188;
            ld_112 = ai_28 * ad_4 + ld_188;
         }
         ada_48[1] = ld_112;
         ada_48[0] = ld_104;
         return (1);
      }
      break;
   case 2:
      if (ld_212 < ld_188) {
         if (ld_196 < ld_188) {
            if (ld_196 > ld_212) {
               ld_136 = (ld_212 - ld_188) / (ld_196 - ld_188);
               if (ld_136 > 1.5) {
                  if (ld_136 < 2.0 && ad_12 * ad_4 < ld_196 - ld_212) {
                     if (ai_32 == 1) {
                        ld_144 = MathMin(ld_188, ad_4 * (ai_24 * 2) + ld_196);
                        ada_48[2] = ld_144;
                        ld_96 = ai_28 * ad_4;
                        ld_104 = ld_196;
                     } else {
                        ld_152 = MathMin(ld_188, ad_4 * ai_24 + ld_196);
                        ada_48[2] = ld_152;
                        ld_96 = ai_28 * ad_4;
                        ld_104 = ld_196;
                     }
                     ld_112 = ld_104 - ld_96;
                     ada_48[1] = ld_112;
                     ada_48[0] = ld_104;
                     return (1);
                  }
               }
            }
         }
      }
      break;
   case 3:
      if (ld_212 > ld_188) {
         if (ld_196 > ld_188) {
            if (ld_196 < ld_212) {
               ld_160 = (ld_212 - ld_188) / (ld_196 - ld_188);
               if (ld_160 > 1.5) {
                  if (ld_160 < 2.0 && ad_12 * ad_4 < ld_212 - ld_196) {
                     if (ai_32 == 1) {
                        ld_168 = MathMax(ld_188, ld_196 - ad_4 * (ai_24 * 2));
                        ada_48[2] = ld_168;
                        ld_104 = ld_196;
                        ld_112 = ai_28 * ad_4 + ld_196;
                     } else {
                        ld_176 = MathMax(ld_188, ld_196 - ad_4 * ai_24);
                        ada_48[2] = ld_176;
                        ld_104 = ld_196;
                        ld_112 = ai_28 * ad_4 + ld_196;
                     }
                     ada_48[1] = ld_112;
                     ada_48[0] = ld_104;
                     return (1);
                  }
               }
            }
         }
      }
      break;
   }
   return (-1);
}