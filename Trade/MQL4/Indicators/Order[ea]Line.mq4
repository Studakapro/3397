//+------------------------------------------------------------------+
//|                                                Order[θα]Line.mq4 |
//|                            Copyright © 2011, hmaryawan@gmail.com |
//|                                           http://athisa.blog.com |
//+------------------------------------------------------------------+

#property copyright "Copyright © 2011, hmaryawan@gmail.com"
#property link      "http://athisa.blog.com"

extern double Lots = 0.1;
extern int StopLoss = 0;
extern int TakeProfit = 0;
extern bool UseMoneyManagement = true;
extern int TradeSizePercent = 2;
extern string ___Gartley___= "Parameter for Gartley Pattern";
extern bool AutoGartley = true;
extern bool PendingOrder = true;
extern int MaxOrder=1;
extern double TakeProfitAtRetracement = 0.618;

int FREE_MARGIN = 1;
int EQUITY = 2;
int BALANCE = 3;

string s_new_prefix = "#";
string s_order_prefix = "$";
string s_tp_prefix = "@";
string s_sl_prefix = "!";
bool hide_sl = true;
string s_symbol, s_cmt;
int i_cmd, i_slipage, i_magic;
double d_lot, d_price, d_sl, d_tp;
datetime dt_exp;
color cl_order=CornflowerBlue, cl_tp=DarkSeaGreen, cl_sl=DarkSalmon;
int l_style=4;

int i_spread = 0;
int i_stop_level=0;

string s_tf[]    = {"M1", "M5", "M15", "M30", "H1", "H4", "D1", "W1", "MN"};
int    i_tf[]    = {1, 5, 15, 30, 60, 240, 1440, 10080, 43200};
string a_cmd[] = {"buy","sell","buylimit","selllimit","buystop","sellstop"};

// gartley
string s_last_sign, s_sign;

int init()  {
   s_symbol = Symbol();
   i_spread = MarketInfo(s_symbol, MODE_SPREAD);
   i_stop_level = MarketInfo(s_symbol, MODE_STOPLEVEL);
   i_slipage = 2;
   i_magic = GetMagic();
   //i_cur_tf = ArrayBsearch(i_tf, Period());
   
   RestoreLine();
   
   
   
   return(0);
}

int deleteObject(string name) {
   for(int k=ObjectsTotal()-1; k>=0; k--)     {
      string o_name=ObjectName(k);
      if (StringFind(o_name, name) != -1) {
         //Print(o_name +" "+StringFind(o_name, name));
         ObjectDelete(o_name);
      }
   }
   
   return(0);
}

int deinit()  {
   deleteObject(s_new_prefix);
   deleteObject(s_order_prefix);
   deleteObject(s_tp_prefix);
   deleteObject(s_sl_prefix);
   
   return(0);
}

int start()  {
   
   RemoveLineOrder();
   
   for(int k=ObjectsTotal()-1; k>=0; k--)     {
      string o_name=ObjectName(k);
      string s_prefix = StringSubstr(o_name,0,1);
      if (ObjectType(o_name)==OBJ_HLINE) {
         if (s_prefix==s_new_prefix) {
            Print("New order line found!");
            GetLineProp(o_name); 
            OpenOrder(o_name);
            continue;
         } else if (s_prefix==s_order_prefix) {
            ModifyOrderPrice(o_name); continue;
         } else if (s_prefix==s_tp_prefix) {
            ModifyOrderTP(o_name); continue;
         } else if (s_prefix==s_sl_prefix) {
            ModifyOrderSL(o_name); continue;
         }
      }
   }
   
   SyncingLine();
   
   if (AutoGartley) FindGartley();
   
   //ClearHistoryOrder();
   //RestoreLine();
   
   return(0);
}

int RemoveLineOrder() {
   for(int k=ObjectsTotal()-1; k>=0; k--)     {
      string o_name=ObjectName(k);
      string s_prefix = StringSubstr(o_name,0,1);
      if (ObjectType(o_name)==OBJ_HLINE) {
         if (s_prefix==s_order_prefix || s_prefix==s_tp_prefix || s_prefix==s_sl_prefix) {
            int i_ticket = StrToInteger(StringSubstr(o_name,1));
            if (!FindOrder(i_ticket)) ObjectDelete(o_name);
         }
      }
   }
}

bool FindOrder(int i_ticket) {
   for (int i=0; i<OrdersTotal(); i++) {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderTicket()==i_ticket) return(true);
   }
}

int RestoreLine() {
   for (int i=0 ; i<OrdersTotal(); i++) {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber()==i_magic) {
         int i_ticket = OrderTicket();
         //if (ObjectFind(s_order_prefix+i_ticket)==-1) 
            ModifyLine(s_order_prefix+i_ticket, OrderComment(), OrderOpenPrice(), cl_order, l_style);
         if (ObjectFind(s_sl_prefix+i_ticket)==-1 && OrderStopLoss()!=0) 
            ModifyLine(s_sl_prefix+i_ticket, "sl : "+ GetPips(OrderType(),OrderOpenPrice(),OrderStopLoss()), OrderStopLoss(), cl_sl, l_style);
         if (ObjectFind(s_tp_prefix+i_ticket)==-1 && OrderTakeProfit()!=0) 
            ModifyLine(s_tp_prefix+i_ticket, "tp : "+ GetPips(OrderType(),OrderTakeProfit(),OrderOpenPrice()), OrderTakeProfit(), cl_tp, l_style);
      }
   }
   return(0);
}

int SyncingLine() {
   for (int i=0 ; i<OrdersTotal(); i++) {
      OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderMagicNumber()==i_magic) {
         int i_ticket = OrderTicket();
         if (ObjectFind(s_order_prefix+i_ticket)==-1) { // berarti order dihapus
            if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
               OrderClose(i_ticket, OrderLots(), OrderClosePrice(),i_slipage);
            } else {
               OrderDelete(i_ticket); // pending order
            }
         }
         if (ObjectFind(s_sl_prefix+i_ticket)==-1) { // berarti stoploss diset 0
            OrderModify(i_ticket, OrderOpenPrice(), 0, OrderTakeProfit(), 0);
         }
         if (ObjectFind(s_tp_prefix+i_ticket)==-1) { // berarti takeprofit diset 0
            OrderModify(i_ticket, OrderOpenPrice(), OrderStopLoss(), 0, 0);
         }
      }
   }
   return(0);
}

int ModifyOrderPrice(string o_name) {
   int i_ticket = StrToInteger(StringSubstr(o_name,1));
   double d_price = NormalizeDouble(ObjectGet(o_name, OBJPROP_PRICE1), Digits);
   if (OrderSelect(i_ticket, SELECT_BY_TICKET) && OrderMagicNumber()==i_magic && (OrderType()!=OP_BUY || OrderType()!=OP_SELL) && OrderOpenPrice()!=d_price) {
      OrderModify(i_ticket, d_price, OrderStopLoss(), OrderTakeProfit(), 0);
      ModifyLine(o_name, "", d_price, cl_order, l_style);
   }
}

int ModifyOrderTP(string o_name) {
   int i_ticket = StrToInteger(StringSubstr(o_name,1));
   double d_tp = NormalizeDouble(ObjectGet(o_name, OBJPROP_PRICE1), Digits);
   if (OrderSelect(i_ticket, SELECT_BY_TICKET) && OrderTakeProfit()!=d_tp) {
      double d_price = OrderOpenPrice();
      OrderModify(i_ticket, OrderOpenPrice(), OrderStopLoss(), d_tp, 0);
      ModifyLine(o_name, "tp : "+ GetPips(i_cmd,d_tp,d_price), d_tp, cl_tp, l_style);
   }
}

int ModifyOrderSL(string o_name) {
   int i_ticket = StrToInteger(StringSubstr(o_name,1));
   double d_sl = NormalizeDouble(ObjectGet(o_name, OBJPROP_PRICE1), Digits);
   if (OrderSelect(i_ticket, SELECT_BY_TICKET) && OrderStopLoss()!=d_sl) {
      double d_price = OrderOpenPrice();
      OrderModify(i_ticket, OrderOpenPrice(), d_sl, OrderTakeProfit(), 0);
      ModifyLine(o_name, "sl : "+ GetPips(i_cmd,d_price,d_sl), d_sl, cl_sl, l_style);
   }
}

void GetLineProp(string o_name) {
   i_cmd = GetCMD(o_name);
   if (i_cmd==OP_BUY) {
      d_price = Ask;
   } else if (i_cmd==OP_SELL) {
      d_price = Bid;
   } else {
      d_price = NormalizeDouble(ObjectGet(o_name, OBJPROP_PRICE1), Digits);
   }
   d_lot = GetLot(o_name, i_cmd, d_price);
   d_sl = GetSL(o_name, i_cmd, d_price);
   d_tp = GetTP(o_name, i_cmd, d_price);
   s_cmt = ObjectDescription(o_name);
   
   Print("cmd:"+a_cmd[i_cmd]+", price:"+fixDigit(d_price)+", lot:"+fixDigit(d_lot,2)+", sl:"+fixDigit(d_sl)+", tp:"+fixDigit(d_tp));
}

int OpenOrder(string o_name) {
   int i_ticket;
   
   while (i_ticket == 0) {
      
      i_ticket = OrderSend(s_symbol, i_cmd, d_lot, d_price, i_slipage, d_sl, d_tp, s_cmt, i_magic, dt_exp);
      RefreshRates();
      Sleep(200);
   }
   
   if (i_ticket != -1) {
      ObjectDelete(o_name);
      ModifyLine(s_order_prefix+i_ticket, s_cmt, d_price, cl_order, l_style);
      if (d_sl!=0) ModifyLine(s_sl_prefix+i_ticket, "sl : "+ GetPips(i_cmd,d_price,d_sl), d_sl, cl_sl, l_style);
      if (d_tp!=0) ModifyLine(s_tp_prefix+i_ticket, "tp : "+ GetPips(i_cmd,d_tp,d_price), d_tp, cl_tp, l_style);
      Print ("Order successfully sent #ticket: "+ i_ticket +" , comment: "+ s_cmt);
   }
}


void ModifyLine(string name, string desc, double price, color col,int style) {
   if (ObjectFind(name)==-1) ObjectCreate(name,OBJ_HLINE,0,NULL,price); 
   
   ObjectSet(name,OBJPROP_PRICE1,price);
   ObjectSet(name,OBJPROP_COLOR,col);
   ObjectSet(name,OBJPROP_RAY, false);
   ObjectSet(name,OBJPROP_WIDTH,0);
   ObjectSet(name,OBJPROP_STYLE,style);
   ObjectSetText(name,desc);

}


int GetCMD(string desc) {
   int pos1 = StringFind(desc, s_new_prefix);
   int pos2 = StringFind(desc, " ", pos1);
   if (pos2==-1) pos2=StringLen(desc);
   string cmd = StringTrimRight(StringSubstr(desc,pos1+1,pos2-pos1));
   
   //Print (cmd);
   
   for (int i=0; i < ArraySize(a_cmd); i++) {
      if (cmd==a_cmd[i]) return(i);
   }
   
}

double OptimizeLots(double lot, int MM_Mode=1) {   
   
   if (UseMoneyManagement) {
      if (MM_Mode==1) lot=NormalizeDouble((AccountFreeMargin()*TradeSizePercent/10000)/10,Digits); //Free Margin
      if (MM_Mode==2) lot=NormalizeDouble((AccountEquity()*TradeSizePercent/10000)/10,Digits);     //Equity
      if (MM_Mode==3) lot=NormalizeDouble((AccountBalance()*TradeSizePercent/10000)/10,Digits);    //Balance
   } else {
      lot = Lots;
   }   
   return(lot);
}

double GetLot(string desc, int i_cmd, double d_price) {
   int pos1 = StringFind(desc, "lo="); 
      if (pos1==-1) 
         return(OptimizeLots(Lots, FREE_MARGIN));
         
   int pos2 = StringFind(desc, " ", pos1);
   if (pos2==-1) pos2=StringLen(desc);
   string lo = StringSubstr(desc,pos1+3,pos2-pos1);
   //Print("pos1="+pos1+", pos2="+pos2+", sl="+sl);
   
   return(StrToDouble(lo)); 

}

double GetSL(string desc, int i_cmd, double d_price) {
   //string sl;
   int pos1 = StringFind(desc, "sl="); 
      if (pos1==-1) {
         if (StopLoss>0) {
            if (i_cmd==OP_BUY || i_cmd==OP_BUYLIMIT || i_cmd==OP_BUYSTOP) {
               return(d_price-Pip2Price(StopLoss));
            } else {
               return(d_price+Pip2Price(StopLoss));
            }
         } else if (StopLoss==0) return(StopLoss);
      }

   int pos2 = StringFind(desc, " ", pos1);
   if (pos2==-1) pos2=StringLen(desc);
   string sl = StringSubstr(desc,pos1+3,pos2-pos1);   
   
   //Print("pos1="+pos1+", pos2="+pos2+", sl="+sl);
   if (StringFind(sl, ".")!= -1) { // jika ada titiknya
      return(StrToDouble(sl));
   } else {
      if (i_cmd==OP_BUY || i_cmd==OP_BUYLIMIT || i_cmd==OP_BUYSTOP) {
         return(d_price-Pip2Price(StrToInteger(sl)));
      } else {
         return(d_price+Pip2Price(StrToInteger(sl)));
      }
   }
   return(0);
}

double GetTP(string desc, int i_cmd, double d_price) {
   //string tp;
   int pos1 = StringFind(desc, "tp="); 
      if (pos1==-1) {
         if (TakeProfit>0) {
            if (i_cmd==OP_BUY || i_cmd==OP_BUYLIMIT || i_cmd==OP_BUYSTOP) {
               return(d_price+Pip2Price(TakeProfit));
            } else {
               return(d_price-Pip2Price(TakeProfit));
            }
         } else if (TakeProfit==0) return(TakeProfit);
      }
   
   int pos2 = StringFind(desc, " ", pos1);
   if (pos2==-1) pos2=StringLen(desc);
   string tp = StringSubstr(desc,pos1+3,pos2-pos1);
   
   //Print("pos1="+pos1+", pos2="+pos2+", tp="+tp);
   if (StringFind(tp, ".")!= -1) {
      return(StrToDouble(tp));
   } else {
      if (i_cmd==OP_BUY || i_cmd==OP_BUYLIMIT || i_cmd==OP_BUYSTOP) {
         return(d_price+Pip2Price(StrToInteger(tp)));
      } else {
         return(d_price-Pip2Price(StrToInteger(tp)));
      }
   }
   return(0);
}

string GetPips(int i_type, double d_price1, double d_price2) {
   return (fixDigit(Price2Pip(MathAbs(d_price1 - d_price2)),0) +" pips");
}

string fixDigit(double value, int digits=MODE_DIGITS) {
   if (digits!=MODE_DIGITS) {
      return(DoubleToStr(value,digits));
   }else{
      return(DoubleToStr(value,MarketInfo(Symbol(),digits)));
   }
}

double Pip2Price(int val) {   return(val * Point);}

double Price2Pip(double val) {return(val/Point);}

void FindGartley() {
   int sbearbull;
   double _tp;
   string spattern, _cmt;
   string sPeriod = s_tf[ArrayBsearch(i_tf,Period())];
   
   for(int k=ObjectsTotal()-1; k>=0; k--) {
      string sname=ObjectName(k);
      if (ObjectType(sname)==OBJ_TRIANGLE && StringFind(sname, "Triangle2")!=-1 && (StringFind(sname, "Bearish")!=-1 || StringFind(sname, "Bullish")!=-1)) {
         sbearbull = StringFind(sname, "Bearish");
         if (sbearbull==-1) spattern = StringSubstr(sname, StringFind(sname, "Bullish"));
         else               spattern = StringSubstr(sname, StringFind(sname, "Bearish"));
         
         s_sign = spattern +" @ "+ Symbol() +"-"+ sPeriod;
         _cmt   = spattern +" @ "+ Symbol() +"-"+ sPeriod;
         if (s_sign != s_last_sign) {
            s_last_sign=s_sign;
            //deleteObject("$"); // when signal changed, close previous order
            if (FindOrderByComment(_cmt)<MaxOrder) {
               if (sbearbull==-1) {
                  _tp= GartleyProfit(ObjectGet(sname, OBJPROP_PRICE2), ObjectGet(sname, OBJPROP_PRICE3), TakeProfitAtRetracement);
                  if (PendingOrder) ModifyLine("#buystop tp="+fixDigit(_tp), _cmt, Ask+Pip2Price(i_stop_level), Blue, STYLE_SOLID);
                  else              ModifyLine("#buy tp="+fixDigit(_tp), _cmt, Ask+Pip2Price(i_spread), Blue, STYLE_SOLID);
               } else {
                  _tp= GartleyProfit(ObjectGet(sname, OBJPROP_PRICE2), ObjectGet(sname, OBJPROP_PRICE3), TakeProfitAtRetracement);
                  if (PendingOrder) ModifyLine("#sellstop tp="+fixDigit(_tp), _cmt, Bid-Pip2Price(i_stop_level), Red, STYLE_SOLID);
                  else              ModifyLine("#sell tp="+fixDigit(_tp), _cmt, Bid-Pip2Price(i_spread), Red, STYLE_SOLID);
               }
            }
         }
      }
   }
}

double GartleyProfit(double _priceC, double _priceD, double _retrace) {
   double range = MathAbs(_priceC - _priceD);
   double profit = MathMin(_priceC,_priceD)+(range*_retrace);
   
   return(profit);
}

int FindOrderByComment(string cmt) {
   int count=0;
   for (int i=0 ; i<OrdersTotal(); i++) {
      OrderSelect(i, SELECT_BY_POS);
      if (OrderMagicNumber()==i_magic && OrderComment()==cmt) count++;
   }
   return(count);
}

int GetMagic() {
   if (s_symbol == "CADJPY") return(1821);
   if (s_symbol == "CADCHF") return(1822);
   
   if (s_symbol == "GOLD")   return(1831);
   if (s_symbol == "SILVER") return(1832);
   
   if (s_symbol == "NZDJPY") return(1841);
   if (s_symbol == "NZDUSD") return(1842);
   
   if (s_symbol == "CHFJPY") return(1851);
   
   if (s_symbol == "EURAUD") return(1861);
   if (s_symbol == "EURCAD") return(1862);
   if (s_symbol == "EURUSD") return(1863);
   if (s_symbol == "EURGBP") return(1864);
   if (s_symbol == "EURCHF") return(1865);
   if (s_symbol == "EURNZD") return(1866);
   if (s_symbol == "EURJPY") return(1867);
   
   if (s_symbol == "GBPUSD") return(1871);
   if (s_symbol == "GBPCHF") return(1872);
   if (s_symbol == "GBPJPY") return(1873);
   
   if (s_symbol == "USDCHF") return(1881);
   if (s_symbol == "USDJPY") return(1882);
   if (s_symbol == "USDCAD") return(1883);

   if (s_symbol == "AUDUSD") return(1891);
   if (s_symbol == "AUDNZD") return(1892);
   if (s_symbol == "AUDCAD") return(1893);
   if (s_symbol == "AUDCHF") return(1894);
   if (s_symbol == "AUDJPY") return(1895);
}

