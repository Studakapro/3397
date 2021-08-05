//+------------------------------------------------------------------+
//|                                               PersistentAnti.mq4 |
//|                                                    Andriy Moraru |
//|                                         http://www.earnforex.com |
//|            							                            2013 |
//+------------------------------------------------------------------+
#property copyright "www.EarnForex.com, 2013"
#property link      "http://www.earnforex.com"

/*
   Exploits persistent/anti-peristent trend trading.
   Twist? Acts contrary!.
   Looks up N past bars.
   If at least 66% (empirical) of N bars followed previous bar's direction, we are in persistent mode.
   If at least 66% of N bars went against previous bar's direction, we are in anti-persistent mode.
   If we are in persistent mode - open opposite to previous bar or keep a position which is opposite to previous bar.
   If we are in anti-persistent mode - open in direction of previous bar or keep a position which is in direction of previous bar.
   Yes, we trade assuming a change in persistence.
   Prone to weekend gaps.
*/

// Main input parameters
extern int N = 10; // How many bars to lookup to detect (anti-)persistence.
extern double Ratio = 0.66; // How big should be the share of (anti-)persistent bars.
extern bool Reverse = true; // If true, will trade inversely to calculated persistence data.

// Money management
extern bool MM  = false;  	// Use Money Management
extern double Lots = 0.1; 		// Basic lot size
extern int Slippage = 100; 	// Tolerated slippage in brokers' pips
extern double MaxPositionSize = 5.0; //Maximum size of the position allowed by broker

// Miscellaneous
extern string OrderCommentary = "PersisteneceAnti";
extern int Magic = 2013041812;

// Global variables
int LastBars = 0;
bool HaveLongPosition;
bool HaveShortPosition;

//+------------------------------------------------------------------+
//| Expert Every Tick Function                                       |
//+------------------------------------------------------------------+
int start()
{
   if ((!IsTradeAllowed()) || (IsTradeContextBusy()) || (!IsConnected()) || ((!MarketInfo(Symbol(), MODE_TRADEALLOWED)) && (!IsTesting()))) return(0);
   
	// Trade only if new bar has arrived
	if (LastBars != Bars) LastBars = Bars;
	else return(0);

   int Persistence = 0;
   int Antipersistence = 0;
   
   // Cycle inside the N-bar range
   for (int i = 1; i <= N; i++) // i is always pointing at a bar inside N-range.
   {
      //string s;
      
      // Previous bar was bullish
      if (Close[i + 1] > Open[i + 1])
      {
         // Current bar is bullish
         if (Close[i] > Open[i])
         {
            Persistence++; 
            //s = "Persistent";
         }
         // Current bar is bearish
         else if (Close[i] < Open[i])
         {
            Antipersistence++;
            //s = "Antipersistent";
         }
         //Print(TimeToStr(Time[i]), " Open: ", Open[i], " Close: ", Close[i], " ", s, " Previous - Bullish @ ", TimeToStr(Time[i + 1]));
      }
      // Previous bar was bearish
      else if (Close[i + 1] < Open[i + 1])
      {
         // Current bar is bearish
         if (Close[i] < Open[i])
         {
            Persistence++;
            //s = "Persistent";
         }
         // Current bar is bullish
         else if (Close[i] > Open[i]) 
         {
            Antipersistence++;
            //s = "Antipersistent";
         }
         //Print(TimeToStr(Time[i]), " Open: ", Open[i], " Close: ", Close[i], " ", s, " Previous - Bearish @ ", TimeToStr(Time[i + 1]));
      }
      // NOTE: If previous or current bar is flat, neither persistence or anti-persistence point is scored, 
      //       which means that we are more likely to stay out of the market.
   }

   //Print("P: ", Persistence, " A: ", Antipersistence, " Threshold: ", Ratio * N, " Previous bar: ", Time[1], " Open: ", Open[1], " Close: ", Close[1]);

  	// Check what position is currently open
 	GetPositionStates();

   if (((Persistence > Ratio * N) && (Reverse)) || ((Antipersistence > Ratio * N) && (!Reverse)))
   {
      // If previous bar was bullish, go short. Remember: we are acting on the contrary!
      if (Close[1] > Open[1])
      {
         if (HaveLongPosition) ClosePrevious();
         if (!HaveShortPosition) fSell();
      }
      // If previous bar was bearish, go long.
      else if (Close[1] < Open[1]) 
      {
         if (HaveShortPosition) ClosePrevious();
         if (!HaveLongPosition) fBuy();
      }
   }
   else if (((Persistence > Ratio * N) && (!Reverse)) || ((Antipersistence > Ratio * N) && (Reverse)))
   {
      // If previous bar was bullish, go long.
      if (Close[1] > Open[1]) 
      {
         if (HaveShortPosition) ClosePrevious();
         if (!HaveLongPosition) fBuy();
      }
      // If previous bar was bearish, go short.
      else if (Close[1] < Open[1])
      {
         if (HaveLongPosition) ClosePrevious();
         if (!HaveShortPosition) fSell();
      }
   }
   // If no Persistence or Antipersistence is detected, just close current position.
   else if ((HaveLongPosition) || (HaveShortPosition)) ClosePrevious();
	
	return(0);
}

//+------------------------------------------------------------------+
//| Check what position is currently open										|
//+------------------------------------------------------------------+
void GetPositionStates()
{
   int total = OrdersTotal();
   for (int cnt = 0; cnt < total; cnt++)
   {
      if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES) == false) continue;
      if (OrderMagicNumber() != Magic) continue;
      if (OrderSymbol() != Symbol()) continue;

      if (OrderType() == OP_BUY)
      {
			HaveLongPosition = true;
			HaveShortPosition = false;
			return;
		}
      else if (OrderType() == OP_SELL)
      {
			HaveLongPosition = false;
			HaveShortPosition = true;
			return;
		}
	}
   HaveLongPosition = false;
	HaveShortPosition = false;
}

//+------------------------------------------------------------------+
//| Buy                                                              |
//+------------------------------------------------------------------+
void fBuy()
{
	RefreshRates();
	int result = OrderSend(Symbol(), OP_BUY, LotsOptimized(), Ask, Slippage, 0, 0,OrderCommentary, Magic);
	if (result == -1)
	{
		int e = GetLastError();
		Print("OrderSend Error: ", e);
	}
}

//+------------------------------------------------------------------+
//| Sell                                                             |
//+------------------------------------------------------------------+
void fSell()
{
	RefreshRates();
	int result = OrderSend(Symbol(), OP_SELL, LotsOptimized(), Bid, Slippage, 0, 0, OrderCommentary, Magic);
	if (result == -1)
	{
		int e = GetLastError();
		Print("OrderSend Error: ", e);
	}
}

//+------------------------------------------------------------------+
//| Calculate position size depending on money management				|
//+------------------------------------------------------------------+
double LotsOptimized()
{
	if (!MM) return (Lots);
	
	double TLots = NormalizeDouble((MathFloor(AccountBalance() * 1.5 / 1000)) / 10, 1); 
	
	int NO = 0;
	if (TLots < 0.1) return(0);
	if (TLots > MaxPositionSize) TLots = MaxPositionSize;

   return(TLots);
} 

//+------------------------------------------------------------------+
//| Close previous position                                          |
//+------------------------------------------------------------------+
void ClosePrevious()
{
   int total = OrdersTotal();
   for (int i = 0; i < total; i++)
   {
      if (OrderSelect(i, SELECT_BY_POS) == false) continue;
      if ((OrderSymbol() == Symbol()) && (OrderMagicNumber() == Magic))
      {
         if (OrderType() == OP_BUY)
         {
            RefreshRates();
            OrderClose(OrderTicket(), OrderLots(), Bid, Slippage);
         }
         else if (OrderType() == OP_SELL)
         {
            RefreshRates();
            OrderClose(OrderTicket(), OrderLots(), Ask, Slippage);
         }
      }
   }
}
//+------------------------------------------------------------------+

