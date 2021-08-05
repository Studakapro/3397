extern double StopLoss = 20.0;
extern double ped_ScalpingLimit = 39.0;
double Gd_100 = 0.001;
int Gi_108 = 43;
int G_magic_112 = 72413;
double G_pips_116 = 131.0;
double Gd_124 = 7.0;
double G_pips_132 = 26.0;
extern string pes_OrderComment = "HF Scalp";
extern string Indicator = "---------------- KeltnerChannel params-------------";
extern int MA_PERIOD = 3;
extern int MA_MODE = 3;
extern int PRICE_MODE = 3;
extern int ATR_PERIOD = 10;
extern double K = 1.0;
extern bool ATR_MODE = FALSE;
bool Gi_184 = FALSE;
bool Gi_188 = FALSE;
bool Gi_192 = TRUE;
bool Gi_196 = FALSE;
bool Gi_200 = TRUE;
extern double gd_Volume = 0.1;
extern bool gb_MoneyManagement = FALSE;
extern double ped_MinLot = 0.01;
extern double ped_MaxLot = 10.0;
extern double ped_Risk = 10.0;
double Gd_240 = 0.1;
double Gd_248 = 0.4;
double Gd_256 = 0.3333333333;
double Gd_264 = 0.0;
bool Gi_272 = TRUE;
double Gd_276 = 5.0;
double Gd_284 = 10.0;
double Gd_292 = 40.0;
bool Gi_300 = FALSE;
double Gd_304 = 5.0;
double Gd_312 = 10.0;
double Gd_320 = 40.0;
bool Gi_328 = TRUE;
double Gd_332 = 0.0;
double Gd_340 = 0.0;
double Gd_348 = 20.0;
bool Gi_356 = FALSE;
int Gi_360 = 0;
double Gd_364 = 0.0;
int G_slippage_372 = 3;
double Gda_376[30];
double Gda_380[30];
int Gia_384[30];
double Gd_388 = 1.0;
double Gd_396;
bool Gi_404;
double Gd_408;
bool Gi_416 = FALSE;
double Gd_420 = 1.0;
double Gd_428 = 0.0;
int Gi_436 = 0;
datetime G_time_440 = 0;
int G_count_444 = 0;
double Gda_448[30];
int G_count_452;
bool Gi_456 = FALSE;
string Gs_dummy_460;
int Gia_468[] = {0};
int Gia_472[] = {0};
string Gs_476 = "";

void init() {
   if (IsTesting()) G_magic_112 = 0;
   Gs_476 = "HF-Scalp" + Symbol() + "_" + G_magic_112 + "_";
   if (StopLoss > Gd_124) Gd_124 = StopLoss;
   G_time_440 = 0;
   ArrayInitialize(Gda_448, 0);
   G_count_452 = 0;
   ArrayInitialize(Gda_376, 0);
   ArrayInitialize(Gda_380, 0);
   ArrayInitialize(Gia_384, 0);
   Gi_360 = 5;
   Gd_364 = 0.00001;
   if (Digits < 5) G_slippage_372 = 0;
   else Gi_436 = -1;
   Gia_472[0] = 1;
   start();
}

void deinit() {
   if (IsTesting()) {
      f0_7(Gs_476 + "SL");
      f0_7(Gs_476 + "TP");
   }
}

void start() {
   if (Gi_360 == 0) {
      init();
      return;
   }
   if (Gia_472[0] == 1) {
      f0_4(Gda_376, Gda_380, Gia_384, Gd_388);
      f0_11(Period());
   }
}

void f0_11(int A_timeframe_0) {
   int ticket_4;
   double price_12;
   double price_20;
   bool bool_28;
   int datetime_32;
   int Li_36;
   double Ld_40;
   double price_48;
   double price_56;
   string Ls_64;
   bool Li_72;
   bool Li_128;
   double Ld_132;
   double Ld_148;
   double Ld_unused_188;
   double Ld_196;
   double Ld_216;
   double Ld_224;
   double Ld_268;
   int Li_280;
   int Li_284;
   if (G_time_440 != Time[0]) {
      G_time_440 = Time[0];
      G_count_444 = 0;
   } else G_count_444++;
   double ihigh_76 = iHigh(Symbol(), A_timeframe_0, 0);
   double ilow_84 = iLow(Symbol(), A_timeframe_0, 0);
   double icustom_92 = iCustom(NULL, 0, "KeltnerChannel_v1", MA_PERIOD, MA_MODE, PRICE_MODE, ATR_PERIOD, K, ATR_MODE, 2, 0);
   double icustom_100 = iCustom(NULL, 0, "KeltnerChannel_v1", MA_PERIOD, MA_MODE, PRICE_MODE, ATR_PERIOD, K, ATR_MODE, 0, 0);
   double Ld_108 = icustom_92 - icustom_100;
   bool Li_116 = Bid >= icustom_100 + Ld_108 / 2.0;
   if (!Gi_416) f0_1();
   double Ld_120 = MarketInfo(Symbol(), MODE_STOPLEVEL) * Point;
   double Ld_140 = 0.5;
   if (Ld_120 - 5.0 * Gd_364 > Ld_140) {
      Li_128 = Gi_300;
      Ld_132 = Gd_292 * Gd_364;
      Ld_140 = Gd_284 * Gd_364;
      Ld_148 = Gd_276 * Gd_364;
   } else {
      if (!Gi_192) {
         Li_128 = Gi_328;
         Ld_132 = Gd_320 * Gd_364;
         Ld_140 = Gd_312 * Gd_364;
         Ld_148 = Gd_304 * Gd_364;
      } else {
         Li_128 = Gi_356;
         Ld_132 = Gd_348 * Gd_364;
         Ld_140 = Gd_340 * Gd_364;
         Ld_148 = Gd_332 * Gd_364;
      }
   }
   Ld_132 = MathMax(Ld_132, Ld_120);
   if (Li_128) Ld_140 = MathMax(Ld_140, Ld_120);
   double Ld_156 = Ask - Bid;
   ArrayCopy(Gda_448, Gda_448, 0, 1, 29);
   Gda_448[29] = Ld_156;
   if (G_count_452 < 30) G_count_452++;
   double Ld_164 = 0;
   int pos_176 = 29;
   for (int count_172 = 0; count_172 < G_count_452; count_172++) {
      Ld_164 += Gda_448[pos_176];
      pos_176--;
   }
   double Ld_180 = Ld_164 / G_count_452;
   if ((!Gi_416) && Ld_180 < 15.0 * Gd_364) Gd_428 = 15.0 * Gd_364 - Ld_180;
   if (Gd_428 < 0.0) Gd_428 = 0;
   if (Gd_100 == 0.003) {
      Ld_unused_188 = 0.68;
      Ld_196 = 0.0023;
   }
   if (Gd_100 == 0.0025) {
      Ld_unused_188 = 0.24;
      Ld_196 = 0.0018;
   }
   if (Gd_100 <= 0.001) {
      Ld_unused_188 = 0.28;
      Ld_196 = 0.0018;
   }
   double Ld_204 = ihigh_76 - ilow_84;
   int Li_212 = 0;
   if (Ld_204 > Gd_100) {
      if (Bid < icustom_92) Li_212 = 1;
      else
         if (Bid > icustom_100) Li_212 = -1;
   }
   if (TimeCurrent() - G_time_440 > Gi_108) Li_212 = 0;
   if (Gd_264 == 0.0) Ld_216 = Gd_256 * Ld_196;
   else Ld_216 = Gd_264 * Gd_364;
   Ld_216 = MathMax(Ld_120, Ld_216);
   if (Bid == 0.0 || MarketInfo(Symbol(), MODE_LOTSIZE) == 0.0) Ld_216 = 0;
   if (Gi_456) datetime_32 = TimeCurrent() + 60.0 * MathMax(10 * A_timeframe_0, 60);
   else datetime_32 = 0;
   if (MarketInfo(Symbol(), MODE_LOTSTEP) == 0.0) Li_36 = 5;
   else Li_36 = f0_2(0.1, MarketInfo(Symbol(), MODE_LOTSTEP));
   if (gb_MoneyManagement) {
      if (ped_Risk < 0.001 || ped_Risk > 1000.0) {
         Comment("ERROR -- Invalid ped_Risk Value.");
         return;
      }
      if (AccountBalance() <= 0.0) {
         Comment("ERROR -- Account Balance is " + DoubleToStr(MathRound(AccountBalance()), 0));
         return;
      }
      Ld_224 = Ld_216 + Ld_180 + Gd_428;
      if (Ld_216 != 0.0) {
         Gd_240 = MathMax(AccountBalance(), Gd_240);
         Ld_40 = MathMin(AccountFreeMargin() * AccountLeverage() / 2.0, Gd_240 * ped_Risk / 100.0 * Bid / Ld_224);
         gd_Volume = Ld_40 / MarketInfo(Symbol(), MODE_LOTSIZE);
         gd_Volume = NormalizeDouble(gd_Volume, Li_36);
         gd_Volume = MathMax(ped_MinLot, gd_Volume);
         gd_Volume = MathMax(MarketInfo(Symbol(), MODE_MINLOT), gd_Volume);
         gd_Volume = MathMin(ped_MaxLot, gd_Volume);
         gd_Volume = MathMin(MarketInfo(Symbol(), MODE_MAXLOT), gd_Volume);
      }
   }
   int count_232 = 0;
   int count_236 = 0;
   double Ld_240 = f0_10(Ask + Gd_428);
   double Ld_248 = f0_10(Bid - Gd_428);
   double Ld_256 = Ld_180 + Gd_428;
   for (pos_176 = 0; pos_176 < OrdersTotal(); pos_176++) {
      if (OrderMagicNumber() == G_magic_112) {
         if (OrderCloseTime() == 0) {
            if (OrderSymbol() != Symbol()) {
               count_236++;
               continue;
            }
            count_232++;
            switch (OrderType()) {
            case OP_BUY:
               if (f0_5(Gs_476 + "TP") <= 0.0) break;
               if (!(Bid >= f0_5(Gs_476 + "TP") || Bid <= f0_5(Gs_476 + "SL"))) break;
               Print("Close Buy Trade " + OrderTicket() + " by virtual TP/SL");
               OrderClose(OrderTicket(), OrderLots(), Bid, 100, CLR_NONE);
               break;
            case OP_SELL:
               if (f0_5(Gs_476 + "TP") <= 0.0) break;
               if (!(Ask <= f0_5(Gs_476 + "TP") || Ask >= f0_5(Gs_476 + "SL"))) break;
               Print("Close Sell Trade " + OrderTicket() + " by virtual TP/SL");
               OrderClose(OrderTicket(), OrderLots(), Ask, 100, CLR_NONE);
               break;
            case OP_BUYSTOP:
               if (!Li_116) {
                  Ld_268 = OrderTakeProfit() - OrderOpenPrice() - Gd_428;
                  if (!((f0_10(Ask + Ld_140) < OrderOpenPrice() && OrderOpenPrice() - Ask - Ld_140 > Ld_148))) break;
                  bool_28 = OrderModify(OrderTicket(), f0_10(Ask + Ld_140), f0_10(Bid + Ld_140 - Ld_268), f0_10(Ld_240 + Ld_140 + Ld_268), 0, CLR_NONE);
                  if (bool_28) break;
                  Print("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                  Alert("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
               } else {
                  OrderDelete(OrderTicket());
                  count_232--;
               }
               break;
            case OP_SELLSTOP:
               if (Li_116) {
                  Ld_268 = OrderOpenPrice() - OrderTakeProfit() - Gd_428;
                  if (!((f0_10(Bid - Ld_140) > OrderOpenPrice() && Bid - Ld_140 - OrderOpenPrice() > Ld_148))) break;
                  bool_28 = OrderModify(OrderTicket(), f0_10(Bid - Ld_140), f0_10(Ask - Ld_140 + Ld_268), f0_10(Ld_248 - Ld_140 - Ld_268), 0, CLR_NONE);
                  if (bool_28) break;
                  Print("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                  Alert("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
               } else {
                  OrderDelete(OrderTicket());
                  count_232--;
               }
            }
         }
      }
   }
   bool Li_276 = FALSE;
   if (Gi_436 >= 0 || Gi_436 == -2) {
      Li_280 = NormalizeDouble(Bid / Gd_364, 0);
      Li_284 = NormalizeDouble(Ask / Gd_364, 0);
      if (Li_280 % 10 != 0 || Li_284 % 10 != 0) Gi_436 = -1;
      else {
         if (Gi_436 >= 0 && Gi_436 < 10) Gi_436++;
         else Gi_436 = -2;
      }
   }
   if (f0_5(Gs_476 + "SL") > 0.0) {
      if (count_232 == 0) {
         f0_7(Gs_476 + "SL");
         f0_7(Gs_476 + "TP");
      }
   }
   bool Li_288 = IsTradeCodition(Ld_216, count_232, Li_212, f0_10(Ld_256), f0_10(ped_ScalpingLimit * Gd_364), Gi_436);
   if (Li_288) {
      if (Li_212 > 0) {
         if (Li_128) {
            price_12 = Ask + G_pips_132 * Point;
            ticket_4 = OrderSend(Symbol(), OP_BUYSTOP, gd_Volume, price_12, G_slippage_372, price_12 - Gd_124 * Point, price_12 + G_pips_116 * Point, pes_OrderComment, G_magic_112,
               datetime_32, CLR_NONE);
            if (ticket_4 < 0) {
               Li_276 = TRUE;
               Print("ERROR BUYSTOP : " + f0_0(Ask + Ld_140) + " SL:" + f0_0(Bid + Ld_140 - Ld_216) + " TP:" + f0_0(Ld_240 + Ld_140 + Ld_216));
            } else {
               PlaySound("news.wav");
               Print("BUYSTOP : " + f0_0(Ask + Ld_140) + " SL:" + f0_0(Bid + Ld_140 - Ld_216) + " TP:" + f0_0(Ld_240 + Ld_140 + Ld_216));
            }
         } else {
            if (Bid - ilow_84 && Gd_396 > 0.0) {
               ticket_4 = OrderSend(Symbol(), OP_BUY, gd_Volume, Ask, G_slippage_372, 0, 0, pes_OrderComment, G_magic_112, datetime_32, CLR_NONE);
               if (ticket_4 < 0) {
                  Li_276 = TRUE;
                  Print("ERROR BUY Ask:" + f0_0(Ask) + " SL:" + f0_0(Bid - Ld_216) + " TP:" + f0_0(Ld_240 + Ld_216));
               } else {
                  PlaySound("news.wav");
                  Print("BUY Ask:" + f0_0(Ask) + " SL:" + f0_0(Bid - Ld_216) + " TP:" + f0_0(Ld_240 + Ld_216));
               }
            }
         }
      } else {
         if (Li_128) {
            price_20 = Bid - G_pips_132 * Point;
            ticket_4 = OrderSend(Symbol(), OP_SELLSTOP, gd_Volume, price_20, G_slippage_372, price_20 + Gd_124 * Point, price_20 - G_pips_116 * Point, pes_OrderComment, G_magic_112,
               datetime_32, CLR_NONE);
            if (ticket_4 < 0) {
               Li_276 = TRUE;
               Print("ERROR SELLSTOP : " + f0_0(Bid - Ld_140) + " SL:" + f0_0(Ask - Ld_140 + Ld_216) + " TP:" + f0_0(Ld_248 - Ld_140 - Ld_216));
            } else {
               PlaySound("news.wav");
               Print("SELLSTOP : " + f0_0(Bid - Ld_140) + " SL:" + f0_0(Ask - Ld_140 + Ld_216) + " TP:" + f0_0(Ld_248 - Ld_140 - Ld_216));
            }
         } else {
            if (ihigh_76 - Bid && Gd_396 < 0.0) {
               ticket_4 = OrderSend(Symbol(), OP_SELL, gd_Volume, Bid, G_slippage_372, 0, 0, pes_OrderComment, G_magic_112, datetime_32, CLR_NONE);
               if (ticket_4 < 0) {
                  Li_276 = TRUE;
                  Print("ERROR SELL Bid:" + f0_0(Bid) + " SL:" + f0_0(Ask + Ld_216) + " TP:" + f0_0(Ld_248 - Ld_216));
               } else {
                  PlaySound("news.wav");
                  Print("SELL Bid:" + f0_0(Bid) + " SL:" + f0_0(Ask + Ld_216) + " TP:" + f0_0(Ld_248 - Ld_216));
               }
            }
         }
      }
   }
   RefreshRates();
   Ld_240 = f0_10(Ask + Gd_428);
   Ld_248 = f0_10(Bid - Gd_428);
   for (pos_176 = 0; pos_176 < OrdersTotal(); pos_176++) {
      if (OrderSelect(pos_176, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderTicket() != 0) {
            if (OrderMagicNumber() == G_magic_112) {
               if (OrderCloseTime() == 0) {
                  if (OrderSymbol() == Symbol()) {
                     switch (OrderType()) {
                     case OP_BUY:
                        if (Gi_272) {
                           price_48 = f0_10(Bid - G_pips_132 * Point);
                           price_56 = f0_10(Ld_240 + G_pips_132 * Point);
                           if (f0_5(Gs_476 + "TP") > 0.0) {
                              if (price_56 - f0_5(Gs_476 + "TP") > Ld_148) {
                                 f0_6(Gs_476 + "SL", price_48);
                                 f0_6(Gs_476 + "TP", price_56);
                              }
                           }
                           if (OrderTakeProfit() != 0.0) {
                              if (price_56 - OrderTakeProfit() > Ld_148) {
                                 if (OrderModify(OrderTicket(), 0, price_48, price_56, datetime_32, CLR_NONE)) break;
                                 Print("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                              }
                           }
                        }
                        price_48 = f0_10(Bid - Gd_124 * Point);
                        price_56 = f0_10(Ld_240 + G_pips_116 * Point);
                        if (f0_5(Gs_476 + "TP") == 0.0) {
                           f0_6(Gs_476 + "SL", price_48);
                           f0_6(Gs_476 + "TP", price_56);
                        }
                        if (!(OrderStopLoss() == 0.0 || OrderTakeProfit() == 0.0)) break;
                        if (!(!OrderModify(OrderTicket(), 0, price_48, price_56, datetime_32, CLR_NONE))) break;
                        Print("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                        Alert("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                        break;
                     case OP_SELL:
                        if (Gi_272) {
                           price_48 = f0_10(Ask + G_pips_132 * Point);
                           price_56 = f0_10(Ld_248 - G_pips_132 * Point);
                           if (f0_5(Gs_476 + "TP") > 0.0) {
                              if (f0_5(Gs_476 + "TP") - price_56 > Ld_148) {
                                 f0_6(Gs_476 + "SL", price_48);
                                 f0_6(Gs_476 + "TP", price_56);
                              }
                           }
                           if (OrderTakeProfit() != 0.0) {
                              if (OrderTakeProfit() - price_56 > Ld_148) {
                                 if (OrderModify(OrderTicket(), 0, price_48, price_56, datetime_32, CLR_NONE)) break;
                                 Print("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                              }
                           }
                        }
                        price_48 = f0_10(Ask + Gd_124 * Point);
                        price_56 = f0_10(Ld_248 - G_pips_116 * Point);
                        if (f0_5(Gs_476 + "TP") == 0.0) {
                           f0_6(Gs_476 + "SL", price_48);
                           f0_6(Gs_476 + "TP", price_56);
                        }
                        if (!(OrderStopLoss() == 0.0 || OrderTakeProfit() == 0.0)) break;
                        if (!(!OrderModify(OrderTicket(), 0, price_48, price_56, datetime_32, CLR_NONE))) break;
                        Print("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                        Alert("Error modificating order with ticket " + OrderTicket() + ". Error code:" + GetLastError());
                     }
                  }
               }
            }
         }
      }
   }
   if (Gi_436 >= 0) Comment("Robot is initializing...");
   else {
      if (Gi_436 == -2) Comment("ERROR -- Instrument " + Symbol() + " prices should have " + Gi_360 + " fraction digits on broker account");
      else {
         Ls_64 = TimeToStr(TimeCurrent()) + " tick: " + f0_8(G_count_444);
         if (Gi_184 || Gi_188) {
            Ls_64 = Ls_64 
               + "\n" 
            + f0_0(Ld_196) + " " + f0_0(Ld_216) + " digits:" + Gi_360 + " " + Gi_436 + " stopLevel:" + f0_0(Ld_120);
            Ls_64 = Ls_64 
               + "\n" 
            + Li_212 + " " + f0_0(icustom_100) + " " + f0_0(icustom_92) + " " + f0_0(Gd_248) + " exp:" + TimeToStr(datetime_32, TIME_MINUTES) + " numOrders:" + count_232 + " shouldRepeat:" + Li_276;
            Ls_64 = Ls_64 
            + "\ntrailingLimit:" + f0_0(Ld_140) + " trailingDist:" + f0_0(Ld_132) + " trailingResolution:" + f0_0(Ld_148) + " useStopOrders:" + Li_128;
         }
         Ls_64 = Ls_64 
         + "\nBid: " + f0_0(Bid) + " Ask: " + f0_0(Ask) + " avgSpread: " + f0_0(Ld_180) + "  Commission rate: " + f0_0(Gd_428) + "  Real avg. spread: " + f0_0(Ld_256) + "  Lots: " + f0_9(gd_Volume,
            Li_36);
         if (Gi_192) Ls_64 = Ls_64 + "   HIGH SPEED";
         if (Gi_196) Ls_64 = Ls_64 + "   SAFE";
         if (Gi_200) Ls_64 = Ls_64 + "   MAX";
         if (f0_10(Ld_256) > f0_10(ped_ScalpingLimit * Gd_364)) {
            Ls_64 = Ls_64 
               + "\n" 
            + "Robot is OFF :: Real avg. spread is too high for this scalping strategy ( " + f0_0(Ld_256) + " > " + f0_0(ped_ScalpingLimit * Gd_364) + " )";
         }
         Comment(Ls_64);
         if (count_232 != 0 || Li_212 != 0 || Gi_188) f0_3(Ls_64);
      }
   }
   if (Li_276) {
      Li_72 = FALSE;
      if (Li_72) f0_11(A_timeframe_0);
   }
}

void f0_4(double &Ada_0[30], double &Ada_4[30], int &Aia_8[30], double Ad_12) {
   double Ld_24;
   if (Aia_8[0] == 0 || MathAbs(Bid - Ada_0[0]) >= Ad_12 * Gd_364) {
      for (int Li_20 = 29; Li_20 > 0; Li_20--) {
         Ada_0[Li_20] = Ada_0[Li_20 - 1];
         Ada_4[Li_20] = Ada_4[Li_20 - 1];
         Aia_8[Li_20] = Aia_8[Li_20 - 1];
      }
      Ada_0[0] = Bid;
      Ada_4[0] = Ask;
      Aia_8[0] = GetTickCount();
   }
   Gd_396 = 0;
   Gi_404 = FALSE;
   double Ld_32 = 0;
   double Ld_40 = 0;
   int Li_48 = 0;
   int Li_52 = 0;
   for (Li_20 = 1; Li_20 < 30; Li_20++) {
      if (Aia_8[Li_20] == 0) break;
      Ld_24 = Ada_0[0] - Ada_0[Li_20];
      if (Ld_32 > Ld_24) {
         Ld_32 = Ld_24;
         Li_48 = Aia_8[0] - Aia_8[Li_20];
      }
      if (Ld_24 > Ld_40) {
         Ld_40 = Ld_24;
         Li_52 = Aia_8[0] - Aia_8[Li_20];
      }
      if (Ld_32 < 0.0 && Ld_40 > 0.0 && (Ld_32 < 3.0 * ((-Ad_12) * Gd_364) || Ld_40 > 3.0 * (Ad_12 * Gd_364))) {
         if ((-Ld_32) / Ld_40 < 0.5) {
            Gd_396 = Ld_40;
            Gi_404 = Li_52;
            break;
         }
         if ((-Ld_40) / Ld_32 < 0.5) {
            Gd_396 = Ld_32;
            Gi_404 = Li_48;
         }
      } else {
         if (Ld_40 > 5.0 * (Ad_12 * Gd_364)) {
            Gd_396 = Ld_40;
            Gi_404 = Li_52;
         } else {
            if (Ld_32 < 5.0 * ((-Ad_12) * Gd_364)) {
               Gd_396 = Ld_32;
               Gi_404 = Li_48;
               break;
            }
         }
      }
   }
   if (Gi_404 == FALSE) {
      Gd_408 = 0;
      return;
   }
   Gd_408 = 1000.0 * Gd_396 / Gi_404;
}

string f0_0(double Ad_0) {
   return (DoubleToStr(Ad_0, Gi_360));
}

string f0_9(double Ad_0, int Ai_8) {
   return (DoubleToStr(Ad_0, Ai_8));
}

double f0_10(double Ad_0) {
   return (NormalizeDouble(Ad_0, Gi_360));
}

string f0_8(int Ai_0) {
   if (Ai_0 < 10) return ("00" + Ai_0);
   if (Ai_0 < 100) return ("0" + Ai_0);
   return ("" + Ai_0);
}

double f0_2(double Ad_0, double Ad_8) {
   return (MathLog(Ad_8) / MathLog(Ad_0));
}

void f0_3(string As_0) {
   int Li_8;
   int Li_12 = -1;
   while (Li_12 < StringLen(As_0)) {
      Li_8 = Li_12 + 1;
      Li_12 = StringFind(As_0, 
      "\n", Li_8);
      if (Li_12 == -1) {
         Print(StringSubstr(As_0, Li_8));
         return;
      }
      Print(StringSubstr(As_0, Li_8, Li_12 - Li_8));
   }
}

void f0_1() {
   double Ld_0;
   for (int pos_8 = OrdersTotal() - 1; pos_8 >= 0; pos_8--) {
      OrderSelect(pos_8, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol() && OrderCloseTime() != 0 && OrderClosePrice() != OrderOpenPrice() && OrderProfit() != 0.0 && OrderComment() != "partial close" && StringFind(OrderComment(),
         "[sl]from #") == -1 && StringFind(OrderComment(), "[tp]from #") == -1) {
         Gi_416 = TRUE;
         Ld_0 = MathAbs(OrderProfit() / (OrderClosePrice() - OrderOpenPrice()));
         Gd_420 = Ld_0 / OrderLots() / MarketInfo(Symbol(), MODE_LOTSIZE);
         Gd_428 = (-OrderCommission()) / Ld_0;
         Print("Commission_rate : " + f0_0(Gd_428));
         break;
      }
   }
   for (pos_8 = OrdersHistoryTotal() - 1; pos_8 >= 0; pos_8--) {
      OrderSelect(pos_8, SELECT_BY_POS, MODE_HISTORY);
      if (OrderSymbol() == Symbol() && OrderCloseTime() != 0 && OrderClosePrice() != OrderOpenPrice() && OrderProfit() != 0.0 && OrderComment() != "partial close" && StringFind(OrderComment(),
         "[sl]from #") == -1 && StringFind(OrderComment(), "[tp]from #") == -1) {
         Gi_416 = TRUE;
         Ld_0 = MathAbs(OrderProfit() / (OrderClosePrice() - OrderOpenPrice()));
         Gd_420 = Ld_0 / OrderLots() / MarketInfo(Symbol(), MODE_LOTSIZE);
         Gd_428 = (-OrderCommission()) / Ld_0;
         Print("Commission_Rate : " + f0_0(Gd_428));
         return;
      }
   }
}

void f0_6(string A_var_name_0, double Ad_8) {
   GlobalVariableSet(A_var_name_0, Ad_8);
}

double f0_5(string A_var_name_0) {
   return (GlobalVariableGet(A_var_name_0));
}

void f0_7(string A_var_name_0) {
   GlobalVariableDel(A_var_name_0);
}

bool IsTradeCodition(double a1, int a2, int a3, double a4, double a5, double a6)
{
  return ((a1 != 0.0) && !a2 && a3 && (a4 <= a5) && (a6 == -1.0));
}

