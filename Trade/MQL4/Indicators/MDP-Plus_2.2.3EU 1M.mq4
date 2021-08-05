#property copyright "Õ‚ª„¡™√À www.FXunion.com QQ»∫144033"
#property link      ""
#property show_inputs

//#include <stdlib.mqh>
#import "stdlib.ex4"
   string ErrorDescription(int a0);

#import

extern string Configuration = "==== Configuration ====";
extern int Magic = 0;
extern string OrderCmt = "";
extern string Suffix = "";
extern bool NDDmode = FALSE;
extern bool Show_Debug = FALSE;
extern bool Verbose = FALSE;
extern string TradingSettings = "==== Trade settings ====";
extern bool TradeALLCurrencyPairs = FALSE;
extern double MaxSpread = 26.0;
extern double TakeProfit = 10.0;
extern double StopLoss = 60.0;
extern double TrailingStart = 0.0;
extern double Commission = 7.0;
extern bool UseDynamicVolatilityLimit = TRUE;
extern double VolatilityMultiplier = 125.0;
extern double VolatilityLimit = 180.0;
extern bool UseVolatilityPercentage = TRUE;
extern double VolatilityPercentageLimit = 60.0;
extern bool UseMovingAverage = TRUE;
extern bool UseBollingerBands = TRUE;
extern double Deviation = 1.5;
extern int OrderExpireSeconds = 3600;
extern string Money_Management = "==== Money Management ====";
extern double MinLots = 0.01;
extern double MaxLots = 1000.0;
extern double Risk = 2.0;
extern string Screen_Shooter = "==== Screen Shooter ====";
extern bool TakeShots = FALSE;
extern int DelayTicks = 1;
extern int ShotsPerBar = 1;
string gsa_272[26] = {"EURUSD", "USDJPY", "GBPUSD", "USDCHF", "USDCAD", "AUDUSD", "NZDUSD", "EURJPY", "GBPJPY", "CHFJPY", "CADJPY", "AUDJPY", "NZDJPY", "EURCHF", "EURGBP", "EURCAD", "EURAUD",
      "EURNZD", "GBPCHF", "GBPAUD", "GBPCAD", "GBPNZD", "AUDCHF", "AUDCAD", "AUDNZD", "NZDCHF",
   "NZDCAD", "CADCHF"};
string gsa_276[];
bool gi_unused_284 = FALSE;
bool gi_288 = TRUE;
bool gi_292 = FALSE;
int g_period_296 = 3;
int gi_300 = 0;
int g_digits_304 = 0;
int g_slippage_308 = 3;
int gia_312[30];
int gi_316 = 0;
int g_time_320 = 0;
int g_count_324 = 0;
int gi_328 = 0;
int gi_332 = 0;
int gi_336 = 0;
double g_pips_340 = 0.0;
double gd_unused_348 = 0.0;
double g_lots_356 = 0.1;
double gd_unused_364 = 0.4;
double gd_372 = 1.0;
double g_pips_380 = 5.0;
double g_pips_388 = 10.0;
double g_pips_396 = 20.0;
double gda_404[30];
double gda_408[30];
double gda_412[30];
double gd_416;
double gd_424;
int gi_440;
int gi_444 = -1;
int gi_448 = 3000000;
int gi_452 = 0;

int init() {
   VolatilityPercentageLimit = VolatilityPercentageLimit / 100.0 + 1.0;
   VolatilityMultiplier /= 10.0;
   ArrayInitialize(gda_412, 0);
   VolatilityLimit *= Point;
   Commission = f0_12(Commission * Point);
   g_digits_304 = Digits;
   int li_0 = MathMax(MarketInfo(Symbol(), MODE_FREEZELEVEL), MarketInfo(Symbol(), MODE_STOPLEVEL));
   if (TakeProfit < li_0) TakeProfit = li_0;
   if (StopLoss < li_0) StopLoss = li_0;
   if (gi_300 < li_0) gi_300 = li_0;
   if (MathMod(Digits, 2) == 0.0) g_slippage_308 = 0;
   else gi_316 = -1;
   if (MaxLots > MarketInfo(Symbol(), MODE_MAXLOT)) MaxLots = MarketInfo(Symbol(), MODE_MAXLOT);
   if (MinLots < MarketInfo(Symbol(), MODE_MINLOT)) MinLots = MarketInfo(Symbol(), MODE_MINLOT);
   if (TradeALLCurrencyPairs == TRUE) f0_6();
   if (Magic < 0) f0_13();
   start();
   return (0);
}

int deinit() {
   return (0);
}

int start() {
   if (g_digits_304 == 0) return (init());
   f0_1(gda_404, gda_408, gia_312, gd_372);
   f0_8();
   return (0);
}

void f0_8() {
   string ls_0;
   string symbol_8;
   bool bool_16;
   bool li_20;
   int li_unused_24;
   bool li_28;
   int li_32;
   int li_unused_36;
   int ticket_40;
   int datetime_44;
   int li_48;
   int li_52;
   int li_56;
   int pos_60;
   int li_68;
   int index_72;
   int count_76;
   double price_84;
   double price_92;
   double ld_100;
   double ld_108;
   double ld_116;
   double ld_124;
   double order_stoploss_140;
   double order_takeprofit_148;
   double ld_156;
   double ihigh_164;
   double ilow_172;
   double ld_180;
   double ld_188;
   double ld_196;
   double ibands_204;
   double ibands_212;
   double ld_220;
   double ld_228;
   double ld_236;
   double ld_244;
   double ld_252;
   double ld_260;
   double ld_268;
   double ld_276;
   double ld_284;
   double ld_292;
   if (g_time_320 < Time[0]) {
      g_time_320 = Time[0];
      g_count_324 = 0;
   } else g_count_324++;
   if (TradeALLCurrencyPairs == FALSE) {
      gi_336 = 1;
      symbol_8 = Symbol();
   }
   for (int count_80 = 0; count_80 != gi_336; count_80++) {
      symbol_8 = gsa_276[index_72];
      ihigh_164 = iHigh(symbol_8, PERIOD_M1, 0);
      ilow_172 = iLow(symbol_8, PERIOD_M1, 0);
      ld_228 = ihigh_164 - ilow_172;
      ld_180 = iMA(symbol_8, PERIOD_M1, g_period_296, 0, MODE_LWMA, PRICE_LOW, 0);
      ld_188 = iMA(symbol_8, PERIOD_M1, g_period_296, 0, MODE_LWMA, PRICE_HIGH, 0);
      ld_196 = ld_188 - ld_180;
      li_28 = Bid >= ld_180 + ld_196 / 2.0;
      ibands_204 = iBands(symbol_8, PERIOD_M1, g_period_296, Deviation, 0, PRICE_OPEN, MODE_UPPER, 0);
      ibands_212 = iBands(symbol_8, PERIOD_M1, g_period_296, Deviation, 0, PRICE_OPEN, MODE_LOWER, 0);
      ld_220 = ibands_204 - ibands_212;
      li_32 = Bid >= ibands_212 + ld_220 / 2.0;
      li_unused_36 = 0;
      if (UseMovingAverage == FALSE && UseBollingerBands == TRUE && li_32 == 1) {
         li_unused_36 = 1;
         gd_416 = ibands_204;
         gd_424 = ibands_212;
      } else {
         if (UseMovingAverage == TRUE && UseBollingerBands == FALSE && li_28 == 1) {
            li_unused_36 = 1;
            gd_416 = ld_188;
            gd_424 = ld_180;
         } else {
            if (UseMovingAverage == TRUE && UseBollingerBands == TRUE && li_28 == 1 && li_32 == 1) {
               li_unused_36 = 1;
               gd_416 = MathMax(ibands_204, ld_188);
               gd_424 = MathMin(ibands_212, ld_180);
            }
         }
      }
      ld_236 = MathMax(MarketInfo(symbol_8, MODE_FREEZELEVEL), MarketInfo(symbol_8, MODE_STOPLEVEL)) * Point;
      ld_244 = Ask - Bid;
      if (ld_236 > 1.0 * Point) {
         li_20 = FALSE;
         ld_108 = MaxSpread * Point;
         ld_252 = g_pips_388 * Point;
         ld_116 = g_pips_380 * Point;
      } else {
         li_20 = TRUE;
         ld_108 = g_pips_396 * Point;
         ld_252 = g_pips_340 * Point;
         ld_116 = TrailingStart * Point;
      }
      ld_108 = MathMax(ld_108, ld_236);
      if (li_20) ld_252 = MathMax(ld_252, ld_236);
      ArrayCopy(gda_412, gda_412, 0, 1, 29);
      gda_412[29] = ld_244;
      if (gi_328 < 30) gi_328++;
      ld_260 = 0;
      pos_60 = 29;
      for (int count_64 = 0; count_64 < gi_328; count_64++) {
         ld_260 += gda_412[pos_60];
         pos_60--;
      }
      ld_268 = ld_260 / gi_328;
      ld_276 = f0_12(Ask + Commission);
      ld_284 = f0_12(Bid - Commission);
      ld_292 = ld_268 + Commission;
      if (UseDynamicVolatilityLimit == TRUE) VolatilityLimit = ld_292 * VolatilityMultiplier;
      li_68 = 0;
      if (ld_228 && VolatilityLimit && gd_424 && gd_416) {
         if (ld_228 > VolatilityLimit) {
            ld_100 = ld_228 / VolatilityLimit;
            if (UseVolatilityPercentage == FALSE || (UseVolatilityPercentage == TRUE && ld_100 > VolatilityPercentageLimit)) {
               if (Bid < gd_424) li_68 = -1;
               else
                  if (Bid > gd_416) li_68 = 1;
            }
         } else ld_100 = 0;
      }
      ld_124 = MathMax(ld_236, ld_124);
      if (Bid == 0.0 || MarketInfo(symbol_8, MODE_LOTSIZE) == 0.0) ld_124 = 0;
      datetime_44 = TimeCurrent() + OrderExpireSeconds;
      if (MarketInfo(symbol_8, MODE_LOTSTEP) == 0.0) li_48 = 5;
      else li_48 = f0_3(0.1, MarketInfo(symbol_8, MODE_LOTSTEP));
      if (Risk < 0.001 || Risk > 100.0) {
         Comment("ERROR -- Invalid Risk Value.");
         return;
      }
      if (AccountBalance() <= 0.0) {
         Comment("ERROR -- Account Balance is " + DoubleToStr(MathRound(AccountBalance()), 0));
         return;
      }
      g_lots_356 = f0_10(symbol_8);
      index_72 = 0;
      count_76 = 0;
      for (pos_60 = 0; pos_60 < OrdersTotal(); pos_60++) {
         OrderSelect(pos_60, SELECT_BY_POS, MODE_TRADES);
         if (OrderMagicNumber() == Magic && OrderCloseTime() == 0) {
            if (OrderSymbol() != symbol_8) {
               count_76++;
               continue;
            }
            switch (OrderType()) {
            case OP_BUY:
               if (gi_288) {
                  order_stoploss_140 = OrderStopLoss();
                  order_takeprofit_148 = OrderTakeProfit();
                  if ((order_takeprofit_148 < f0_12(ld_276 + ld_108) && ld_276 + ld_108 - order_takeprofit_148 > ld_116)) {
                     order_stoploss_140 = f0_12(Bid - ld_108);
                     order_takeprofit_148 = f0_12(ld_276 + ld_108);
                     gi_332 = GetTickCount();
                     bool_16 = OrderModify(OrderTicket(), 0, order_stoploss_140, order_takeprofit_148, datetime_44, Lime);
                     gi_332 = GetTickCount() - gi_332;
                     if (bool_16 > FALSE && TakeShots && (!IsTesting()) && (!gi_292)) f0_7();
                  }
               }
               index_72++;
               continue;
               break;
            case OP_SELL:
               if (gi_288) {
                  order_stoploss_140 = OrderStopLoss();
                  order_takeprofit_148 = OrderTakeProfit();
                  if ((order_takeprofit_148 > f0_12(ld_284 - ld_108) && order_takeprofit_148 - ld_284 + ld_108 > ld_116)) {
                     order_stoploss_140 = f0_12(Ask + ld_108);
                     order_takeprofit_148 = f0_12(ld_284 - ld_108);
                     gi_332 = GetTickCount();
                     bool_16 = OrderModify(OrderTicket(), 0, order_stoploss_140, order_takeprofit_148, datetime_44, Orange);
                     gi_332 = GetTickCount() - gi_332;
                     if (bool_16 > FALSE && TakeShots && (!IsTesting()) && (!gi_292)) f0_7();
                  }
               }
               index_72++;
               continue;
               break;
            case OP_BUYSTOP:
               if (!li_28) {
                  ld_156 = OrderTakeProfit() - OrderOpenPrice() - Commission;
                  if ((f0_12(Ask + ld_252) < OrderOpenPrice() && OrderOpenPrice() - Ask - ld_252 > ld_116)) {
                     gi_332 = GetTickCount();
                     bool_16 = OrderModify(OrderTicket(), f0_12(Ask + ld_252), f0_12(Bid + ld_252 - ld_156), f0_12(ld_276 + ld_252 + ld_156), 0, Lime);
                     gi_332 = GetTickCount() - gi_332;
                  }
                  index_72++;
                  continue;
               }
               OrderDelete(OrderTicket());
               continue;
               break;
            case OP_SELLSTOP: break;
            }
            if (li_28) {
               ld_156 = OrderOpenPrice() - OrderTakeProfit() - Commission;
               if ((f0_12(Bid - ld_252) > OrderOpenPrice() && Bid - ld_252 - OrderOpenPrice() > ld_116)) {
                  gi_332 = GetTickCount();
                  bool_16 = OrderModify(OrderTicket(), f0_12(Bid - ld_252), f0_12(Ask - ld_252 + ld_156), f0_12(ld_284 - ld_252 - ld_156), 0, Orange);
                  gi_332 = GetTickCount() - gi_332;
               }
               index_72++;
               continue;
            }
            OrderDelete(OrderTicket());
         }
      }
      li_unused_24 = 0;
      if (gi_316 >= 0 || gi_316 == -2) {
         li_52 = NormalizeDouble(Bid / Point, 0);
         li_56 = NormalizeDouble(Ask / Point, 0);
         if (li_52 % 10 != 0 || li_56 % 10 != 0) gi_316 = -1;
         else {
            if (gi_316 >= 0 && gi_316 < 10) gi_316++;
            else gi_316 = -2;
         }
      }
      if (index_72 == 0 && li_68 != 0 && f0_12(ld_292) <= f0_12(MaxSpread * Point) && gi_316 == -1) {
         if (li_68 < 0) {
            gi_332 = GetTickCount();
            if (li_20) {
               price_84 = Ask + gi_300 * Point;
               if (NDDmode) {
                  ticket_40 = OrderSend(symbol_8, OP_BUYSTOP, g_lots_356, price_84, g_slippage_308, 0, 0, OrderCmt, Magic, 0, Lime);
                  if (OrderSelect(ticket_40, SELECT_BY_TICKET)) OrderModify(OrderTicket(), OrderOpenPrice(), price_84 - StopLoss * Point, price_84 + TakeProfit * Point, datetime_44, Lime);
               } else {
                  ticket_40 = OrderSend(symbol_8, OP_BUYSTOP, g_lots_356, price_84, g_slippage_308, price_84 - StopLoss * Point, price_84 + TakeProfit * Point, OrderCmt, Magic, datetime_44,
                     Lime);
               }
               if (ticket_40 < 0) {
                  li_unused_24 = 1;
                  Print("ERROR BUYSTOP : " + f0_4(Ask + ld_252) + " SL:" + f0_4(Bid + ld_252 - ld_124) + " TP:" + f0_4(ld_276 + ld_252 + ld_124));
                  gi_332 = 0;
               } else {
                  gi_332 = GetTickCount() - gi_332;
                  PlaySound("news.wav");
                  Print("BUYSTOP : " + f0_4(Ask + ld_252) + " SL:" + f0_4(Bid + ld_252 - ld_124) + " TP:" + f0_4(ld_276 + ld_252 + ld_124));
               }
            } else {
               if (Bid - ilow_172 > 0.0) {
                  ticket_40 = OrderSend(symbol_8, OP_BUY, g_lots_356, Ask, g_slippage_308, 0, 0, OrderCmt, Magic, datetime_44, Lime);
                  if (ticket_40 < 0) {
                     li_unused_24 = 1;
                     Print("ERROR BUY Ask:" + f0_4(Ask) + " SL:" + f0_4(Bid - ld_124) + " TP:" + f0_4(ld_276 + ld_124));
                     gi_332 = 0;
                  } else {
                     bool_16 = OrderModify(ticket_40, 0, f0_12(Bid - ld_124), f0_12(ld_276 + ld_124), datetime_44, Lime);
                     gi_332 = GetTickCount() - gi_332;
                     PlaySound("news.wav");
                     Print("BUY Ask:" + f0_4(Ask) + " SL:" + f0_4(Bid - ld_124) + " TP:" + f0_4(ld_276 + ld_124));
                  }
               }
            }
         } else {
            if (li_68 > 0) {
               if (li_20) {
                  price_92 = Bid - gi_300 * Point;
                  gi_332 = GetTickCount();
                  if (NDDmode) {
                     ticket_40 = OrderSend(symbol_8, OP_SELLSTOP, g_lots_356, price_92, g_slippage_308, 0, 0, OrderCmt, Magic, 0, Orange);
                     if (OrderSelect(ticket_40, SELECT_BY_TICKET)) OrderModify(OrderTicket(), OrderOpenPrice(), price_92 + StopLoss * Point, price_92 - TakeProfit * Point, datetime_44, Orange);
                  } else {
                     ticket_40 = OrderSend(symbol_8, OP_SELLSTOP, g_lots_356, price_92, g_slippage_308, price_92 + StopLoss * Point, price_92 - TakeProfit * Point, OrderCmt, Magic, datetime_44,
                        Orange);
                  }
                  if (ticket_40 < 0) {
                     li_unused_24 = 1;
                     Print("ERROR SELLSTOP : " + f0_4(Bid - ld_252) + " SL:" + f0_4(Ask - ld_252 + ld_124) + " TP:" + f0_4(ld_284 - ld_252 - ld_124));
                     gi_332 = 0;
                  } else {
                     gi_332 = GetTickCount() - gi_332;
                     PlaySound("news.wav");
                     Print("SELLSTOP : " + f0_4(Bid - ld_252) + " SL:" + f0_4(Ask - ld_252 + ld_124) + " TP:" + f0_4(ld_284 - ld_252 - ld_124));
                  }
               } else {
                  if (ihigh_164 - Bid < 0.0) {
                     ticket_40 = OrderSend(symbol_8, OP_SELL, g_lots_356, Bid, g_slippage_308, 0, 0, OrderCmt, Magic, datetime_44, Orange);
                     if (ticket_40 < 0) {
                        li_unused_24 = 1;
                        Print("ERROR SELL Bid:" + f0_4(Bid) + " SL:" + f0_4(Ask + ld_124) + " TP:" + f0_4(ld_284 - ld_124));
                        gi_332 = 0;
                     } else {
                        bool_16 = OrderModify(ticket_40, 0, f0_12(Ask + ld_124), f0_12(ld_284 - ld_124), datetime_44, Orange);
                        gi_332 = GetTickCount() - gi_332;
                        PlaySound("news.wav");
                        Print("SELL Bid:" + f0_4(Bid) + " SL:" + f0_4(Ask + ld_124) + " TP:" + f0_4(ld_284 - ld_124));
                     }
                  }
               }
            }
         }
      }
      if (gi_316 >= 0) Comment("Robot is initializing...");
      else {
         if (gi_316 == -2) Comment("ERROR -- Instrument " + symbol_8 + " prices should have " + g_digits_304 + " fraction digits on broker account");
         else {
            ls_0 = TimeToStr(TimeCurrent()) + " Tick: " + f0_9(g_count_324);
            if (Show_Debug || Verbose) {
               ls_0 = ls_0 
               + "\n*** DEBUG MODE *** \nVolatility: " + f0_4(ld_228) + ", VolatilityLimit: " + f0_4(VolatilityLimit) + ", VolatilityPercentage: " + f0_4(ld_100);
               ls_0 = ls_0 
               + "\nPriceDirection: " + StringSubstr("BUY NULLSELL", li_68 * 4 + 4, 4) + ", ImaHigh: " + f0_4(ld_188) + ", ImaLow: " + f0_4(ld_180) + ", BBandUpper: " + f0_4(ibands_204);
               ls_0 = ls_0 + ", BBandLower: " + f0_4(ibands_212) + ", Expire: " + TimeToStr(datetime_44, TIME_MINUTES) + ", NnumOrders: " + index_72;
               ls_0 = ls_0 
               + "\nTrailingLimit: " + f0_4(ld_252) + ", TrailingDist: " + f0_4(ld_108) + "; TrailingStart: " + f0_4(ld_116) + ", UseStopOrders: " + li_20;
            }
            ls_0 = ls_0 
            + "\nBid: " + f0_4(Bid) + ", Ask: " + f0_4(Ask) + ", AvgSpread: " + f0_4(ld_268) + ", Commission: " + f0_4(Commission) + ", RealAvgSpread: " + f0_4(ld_292) + ", Lots: " + f0_11(g_lots_356,
               li_48) + ", Execution: " + gi_332 + " ms";
            if (f0_12(ld_292) > f0_12(MaxSpread * Point)) {
               ls_0 = ls_0 
                  + "\n" 
               + "The current spread (" + f0_4(ld_292) + ") is higher than what has been set as MaxSpread (" + f0_4(MaxSpread * Point) + ") so no trading is allowed right now on this currency pair!";
            }
            Comment(ls_0);
            if (index_72 != 0 || li_68 != 0 || Verbose) f0_2(ls_0);
         }
      }
   }
}

void f0_1(double &ada_0[30], double &ada_4[30], int &aia_8[30], double a_pips_12) {
   if (aia_8[0] == 0 || MathAbs(Bid - ada_0[0]) >= a_pips_12 * Point) {
      for (int li_20 = 29; li_20 > 0; li_20--) {
         ada_0[li_20] = ada_0[li_20 - 1];
         ada_4[li_20] = ada_4[li_20 - 1];
         aia_8[li_20] = aia_8[li_20 - 1];
      }
      ada_0[0] = Bid;
      ada_4[0] = Ask;
      aia_8[0] = GetTickCount();
   }
}

string f0_4(double ad_0) {
   return (DoubleToStr(ad_0, g_digits_304));
}

string f0_11(double ad_0, int ai_8) {
   return (DoubleToStr(ad_0, ai_8));
}

double f0_12(double ad_0) {
   return (NormalizeDouble(ad_0, g_digits_304));
}

string f0_9(int ai_0) {
   if (ai_0 < 10) return ("00" + ai_0);
   if (ai_0 < 100) return ("0" + ai_0);
   return ("" + ai_0);
}

double f0_3(double ad_0, double ad_8) {
   return (MathLog(ad_8) / MathLog(ad_0));
}

void f0_2(string as_0) {
   int li_8;
   int li_12 = -1;
   while (li_12 < StringLen(as_0)) {
      li_8 = li_12 + 1;
      li_12 = StringFind(as_0, 
      "\n", li_8);
      if (li_12 == -1) {
         Print(StringSubstr(as_0, li_8));
         return;
      }
      Print(StringSubstr(as_0, li_8, li_12 - li_8));
   }
}

void f0_6() {
   string ls_unused_0;
   string ls_8;
   double ask_28;
   gi_336 = 0;
   for (int index_16 = 0; index_16 != gi_336; index_16++) {
      ls_8 = gsa_272[index_16];
      ask_28 = MarketInfo(ls_8 + Suffix, MODE_ASK);
      if (ask_28 != 0.0) {
         gi_336++;
         ArrayResize(gsa_276, gi_336);
         gsa_276[gi_336 - 1] = ls_8;
      } else Print("The broker does not support ", ls_8);
   }
}

int f0_13() {
   string ls_0 = Symbol();
   int str_len_8 = StringLen(ls_0);
   int li_12 = 0;
   for (int li_16 = 0; li_16 < str_len_8 - 1; li_16++) li_12 += StringGetChar(ls_0, li_16);
   Magic = AccountNumber() + li_12;
   return (0);
}

void f0_7() {
   int li_0;
   if (ShotsPerBar > 0) li_0 = MathRound(60 * Period() / ShotsPerBar);
   else li_0 = 60 * Period();
   int li_4 = MathFloor((TimeCurrent() - Time[0]) / li_0);
   if (Time[0] != gi_440) {
      gi_440 = Time[0];
      gi_444 = DelayTicks;
   } else
      if (li_4 > gi_448) f0_0("i");
   gi_448 = li_4;
   if (gi_444 == 0) f0_0("");
   if (gi_444 >= 0) gi_444--;
}

string f0_5(int ai_0, int ai_4) {
   for (string dbl2str_8 = DoubleToStr(ai_0, 0); StringLen(dbl2str_8) < ai_4; dbl2str_8 = "0" + dbl2str_8) {
   }
   return (dbl2str_8);
}

void f0_0(string as_0 = "") {
   gi_452++;
   string ls_8 = "SnapShot" + Symbol() + Period() + "\\" + Year() + "-" + f0_5(Month(), 2) + "-" + f0_5(Day(), 2) + " " + f0_5(Hour(), 2) + "_" + f0_5(Minute(), 2) + "_" + f0_5(Seconds(),
      2) + " " + gi_452 + as_0 + ".gif";
   if (!WindowScreenShot(ls_8, 640, 480)) Print("ScreenShot error: ", ErrorDescription(GetLastError()));
}

double f0_10(string a_symbol_0) {
   double lotstep_8 = MarketInfo(a_symbol_0, MODE_LOTSTEP);
   double ld_ret_16 = AccountFreeMargin() * Risk / StopLoss / 100.0;
   ld_ret_16 = MathFloor(ld_ret_16 / lotstep_8) * lotstep_8;
   if (g_lots_356 > MaxLots) g_lots_356 = MaxLots;
   if (g_lots_356 < MinLots) g_lots_356 = MinLots;
   return (ld_ret_16);
}