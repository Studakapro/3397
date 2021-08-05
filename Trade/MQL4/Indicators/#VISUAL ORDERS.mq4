//+------------------------------------------------------------------+
//|                                                VISUAL ORDERS.mq4 |
//|                                                      ANDY TACKER |
//|                                                             2013 |
//+------------------------------------------------------------------+
#property copyright "ANDY TACKER"
#property link      "2013"
//
//  VisualOrders.mq4 
//  Dmitry Yakovlev 
//  dmitry_yakovlev@rambler.ru
//  На пиво WebMoney R865705290089
//------------------------------------------------------------------
#property copyright "Dmitry Yakovlev, Russia,Omsk, WM R865705290089"
#property link      "dmitry_yakovlev@rambler.ru"

#property indicator_chart_window

#import  "shell32.dll"           //Connect a dll (provided with Windows)             
  int ShellExecuteA(int hwnd,string Operation,string File,string Parameters,string Directory,int ShowCmd); 
#import "user32.dll"
  int MessageBoxA(int hWnd ,string lpText,string lpCaption,int uType);
#import

extern string  _ModeProf="Прибыль 1-плавающ.,2-сверху";
extern int     ModeProf=2;
extern string  _orders="Показывать сделки на графике:";
extern string  _Type = "0 все,-1 Sell,1 Buy";
extern int     Type = 0;
extern bool    CurOrders=true;
extern int     lblSize=1;
extern bool    HistOrders=true;
extern bool    ShowProfits=false;
extern int     ShiftProfits=0;
extern bool    lShowTargets=false;

double prev_profit=0, cur_prof5=0, prev_prof5=0;
int wh=0;
int init()
{
   int i,total;
   if(lblSize<1) lblSize=1;
   if(lblSize>4) lblSize=4;
   
    ObjectCreate("curtime", OBJ_LABEL,0,0,0);
    ObjectSet("curtime", OBJPROP_CORNER,0);
    ObjectSet("curtime", OBJPROP_XDISTANCE,250);
    ObjectSet("curtime", OBJPROP_YDISTANCE,0);

    if(ModeProf==1)
    {
      ObjectCreate("profit2", OBJ_TEXT,0,0,0);
      ObjectCreate("Account", OBJ_TEXT,0,0,0);
    }
    else if(ModeProf==2)
    {
      ObjectCreate("Account", OBJ_LABEL,0,0,0);
      ObjectSet("Account", OBJPROP_CORNER,0);
      ObjectSet("Account", OBJPROP_XDISTANCE,250);
      ObjectSet("Account", OBJPROP_YDISTANCE,20);

      ObjectCreate("profit2", OBJ_LABEL,0,0,0);
      ObjectSet("profit2", OBJPROP_CORNER,0);
      ObjectSet("profit2", OBJPROP_XDISTANCE,320);
      ObjectSet("profit2", OBJPROP_YDISTANCE,20);
    }

   ObjectDelete("VOSignal");
   /*ObjectCreate("VOSignal", OBJ_LABEL,0,0,0);
   ObjectSet("VOSignal", OBJPROP_CORNER,1);
   ObjectSet("VOSignal", OBJPROP_XDISTANCE,10);
   ObjectSet("VOSignal", OBJPROP_YDISTANCE,10);*/
}
int deinit()
{ObjectsDeleteAll();
   //deleteAll();
   /*for(int i=0;i<30;i++)
   {
      ObjectDelete(Symbol()+DoubleToStr(Period(),0)+"vopen"+i+" МАГИК = "+OrderMagicNumber());
      ObjectDelete(Symbol()+DoubleToStr(Period(),0)+"vtake"+i+" МАГИК = "+OrderMagicNumber());
      ObjectDelete(Symbol()+DoubleToStr(Period(),0)+"vstop"+i+" МАГИК = "+OrderMagicNumber());
   }*/
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
double Trunc(double v=0)
{
   return(StrToDouble(DoubleToStr(v,0)));
}

double TakeProfit=0, StopLoss=0;


int start()
{
   datetime t1,t2,t3,t4;
   double TickValue=MarketInfo(Symbol(), MODE_TICKVALUE);
   int spread=MarketInfo(Symbol(), MODE_SPREAD);
   
   ObjectSetText("curtime", TimeToStr(TimeCurrent(),TIME_SECONDS)+" Плечо:"+DoubleToStr(AccountLeverage(),0)+" Спрэд:"+DoubleToStr(spread,0), 12, "Arial", Lime);
	int i;
   double sell_profit=0, buy_profit=0, tot_profit=0, 
          sell_points=0, buy_points=0, tot_points=0, prev_points=0, 
          plus_profit=0, minus_profit=0;
   for(i=0;i<OrdersTotal();i++)
   if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
      if(OrderSymbol()==Symbol() && OrderType()==OP_SELL) { sell_profit+=OrderProfit(); sell_points+=Ask-OrderOpenPrice();}
      if(OrderSymbol()==Symbol() && OrderType()==OP_BUY) { buy_profit+=OrderProfit(); buy_points+=Bid-OrderOpenPrice();}
      
      if(OrderSymbol()==Symbol() ) 
         if(OrderProfit()>0) 
            plus_profit+=OrderProfit();
         else
            minus_profit+=OrderProfit();
   }
   tot_profit=sell_profit+buy_profit;
   tot_points=buy_points-sell_points;
   cur_prof5=Trunc(tot_points/5)*5;
   prev_prof5=Trunc(prev_points/5)*5;

   ObjectSetText("Account", DoubleToStr(AccountEquity(),2), 12, "Arial", Lime);

   //if(tot_profit>0) ObjectSetText("profit2", DoubleToStr(plus_profit,2)+"+"+DoubleToStr(minus_profit,2)+"=+"+DoubleToStr(tot_profit,2)+" (+"+DoubleToStr(tot_points/Point,0)+")", 12, "Arial", Lime);
   //else if(tot_profit<0) ObjectSetText("profit2", DoubleToStr(plus_profit,2)+""+DoubleToStr(minus_profit,2)+"="+DoubleToStr(tot_profit,2)+" ("+DoubleToStr(tot_points/Point,0)+")", 12, "Arial", OrangeRed);
   //else if(tot_profit==0) ObjectSetText("profit2","0", 12, "Arial", Yellow);
   if(tot_profit>0) ObjectSetText("profit2", DoubleToStr(plus_profit,2)+"+"+DoubleToStr(minus_profit,2)+"=+"+DoubleToStr(tot_profit,2), 12, "Arial", Lime);
   else if(tot_profit<0) ObjectSetText("profit2", DoubleToStr(plus_profit,2)+""+DoubleToStr(minus_profit,2)+"="+DoubleToStr(tot_profit,2), 12, "Arial", OrangeRed);
   else if(tot_profit==0) ObjectSetText("profit2","0", 12, "Arial", Yellow);
   
   if(ModeProf==1)
   {
      ObjectSet("profit2", OBJPROP_TIME1, Time[0]+Period()*60*2);
      ObjectSet("Account", OBJPROP_TIME1, Time[0]+Period()*60*2);
      double hh=High[iHighest(NULL,0,MODE_HIGH,5,0)], ll=Low[iLowest(NULL,0,MODE_LOW,3,0)];
      ObjectSet("profit2", OBJPROP_PRICE1, hh+Point*9);
      ObjectSet("Account", OBJPROP_PRICE1, hh+Point*6);
   }

   //string VOSignal="flat";
   /*ObjectSetText("VOSignal", "flat", 12, "Arial", Blue);
   if(Close[0]>High[1] && Low[0]>Low[1] && Low[1]>Low[2])
   {
      ObjectSetText("VOSignal", "buy", 12, "Arial", Lime);
   }
   if(Close[0]<Low[1] && High[0]<High[1] && High[1]<High[2])
   {
      ObjectSetText("VOSignal", "sell", 12, "Arial", Red);
   }*/
   
   prev_profit=tot_profit;
   prev_points=tot_points;
   
   // <---orders
      if(HistOrders==true) ShowOrders(MODE_HISTORY);
      if(CurOrders==true) ShowOrders(MODE_TRADES);
   // --- orders >
   
   // <---targets
   if(lShowTargets) fShowTargets();
   // ---targets>
   WindowRedraw();
}

/*void deleteAll()
{
   string tmp,prefix;
   int i,total;

   ObjectDelete("VOSignal");
   
   prefix="time_order_trades_";total=OrdersTotal();
   for(i=0;i<total+5;i++)
   {
      tmp=prefix+DoubleToStr(i,0);
      ObjectDelete(tmp);
      ObjectDelete(tmp+"O");
      ObjectDelete(tmp+"C");
      ObjectDelete(tmp+"OA");
      ObjectDelete(tmp+"CA");
      ObjectDelete(tmp+"Cprof1");
      ObjectDelete(tmp+"Cprof2");
   }
   prefix="time_order_hist_";total=OrdersHistoryTotal();
   for(i=0;i<total+15;i++)
   {
      tmp=prefix+DoubleToStr(i,0);
      ObjectDelete(tmp);
      ObjectDelete(tmp+"O");
      ObjectDelete(tmp+"C");
      ObjectDelete(tmp+"OA");
      ObjectDelete(tmp+"CA");
      ObjectDelete(tmp+"Cprof1");
      ObjectDelete(tmp+"Cprof2");
   }

   ObjectDelete("curtime");   
   ObjectDelete("profit");
   ObjectDelete("profit2");
   ObjectDelete("Account");

   ObjectDelete("time_TP");
   ObjectDelete("time_SL");
   ObjectDelete("time_mar");
   ObjectDelete("time_per");
   ObjectDelete("time_lot");
   ObjectDelete("time_lot100");
   ObjectDelete("time_vv1");
   ObjectDelete("time_vv2");
   ObjectDelete("time_sr1");
   ObjectDelete("time_sr2");
}*/

void ShowOrders(int mode=MODE_TRADES)
{
   int i=0; string tmp=""; color clr2=0,clr1=Blue; string prefix="time_order_trades_"; int total=0;
   double CT, CP;
   
   if(mode==MODE_TRADES) {prefix="time_order_trades_";total=OrdersTotal();}
   if(mode==MODE_HISTORY) {prefix="time_order_hist_";total=OrdersHistoryTotal();}
   
   //<--- торгуемые ордера
   // удаляем старые линии
   for(i=0;i<total+15;i++)
   {
      tmp=prefix+DoubleToStr(i,0);
      ObjectDelete(tmp);
      ObjectDelete(tmp+"O");
      ObjectDelete(tmp+"C");
      ObjectDelete(tmp+"OA");
      ObjectDelete(tmp+"CA");
      ObjectDelete(tmp+"Cprof1");
      ObjectDelete(tmp+"Cprof2");
   }
   // добавляем новые
   for(i=0;i<total;i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,mode)==true && OrderSymbol()==Symbol())
      {
         int ot=OrderType();
         if(OrderSymbol()==Symbol() && ((Type==0&&(ot==OP_BUY||ot==OP_SELL)) || (Type==1&&ot==OP_BUY) || (Type==-1&&ot==OP_SELL) ) )
         {
            tmp=prefix+DoubleToStr(i,0);
            clr2=White; if(OrderProfit()>=0) clr2=Lime; else clr2=Red;
            if(OrderType()==OP_BUY) {CP=Bid;clr1=Lime;}
            if(OrderType()==OP_SELL) {CP=Ask;clr1=Red;}
            if(mode==MODE_TRADES)  {CT=Time[0];}
            if(mode==MODE_HISTORY) {CT=OrderCloseTime();CP=OrderClosePrice();}
            
            ObjectCreate(tmp, OBJ_TREND, 0, OrderOpenTime(), OrderOpenPrice(), CT, CP);
            ObjectSet(tmp, OBJPROP_COLOR, clr2);
            ObjectSet(tmp, OBJPROP_RAY, 0);
            ObjectSet(tmp, OBJPROP_WIDTH,1);
            ObjectSet(tmp, OBJPROP_STYLE, STYLE_DASHDOTDOT);
            
            ObjectCreate(tmp+"OA", OBJ_ARROW, 0, OrderOpenTime()/*-Period()*60*/, OrderOpenPrice());
            ObjectSet(tmp+"OA", OBJPROP_COLOR, clr1);
            ObjectSet(tmp+"OA", OBJPROP_ARROWCODE, 1);
            
            /*if(mode==MODE_TRADES) 
            {
               ObjectCreate(tmp+"O", OBJ_ARROW, 0, OrderOpenTime()-Period()*60, OrderOpenPrice());
               ObjectSet(tmp+"O", OBJPROP_COLOR, clr1);
               ObjectSet(tmp+"O", OBJPROP_WIDTH, lblSize);
               ObjectSet(tmp+"O", OBJPROP_ARROWCODE, 5);
            }*/

            if(mode==MODE_HISTORY && ShowProfits) 
            {
               int j=0, sh=iBarShift(Symbol(),0,CT,true);
               double pr=0;
               
               if(ShiftProfits>=0) for(j=4;j>=0;j--) pr=MathMax(pr,iHigh(Symbol(),0,sh+j));
               if(ShiftProfits<0) for(j=4;j>=0;j--) pr=MathMax(pr,iLow(Symbol(),0,sh+j));
               
               if(ShiftProfits!=0)
                  ObjectCreate(tmp+"Cprof2", OBJ_TEXT, 0, CT, pr+ShiftProfits*Point);

               if(ShiftProfits==0)
                  ObjectCreate(tmp+"Cprof2", OBJ_TEXT, 0, CT, pr+(WindowPriceMax()-WindowPriceMin())/10);

               string sss=""; color clrProf=Lime;
               if(OrderProfit()>0) { sss="+"; clrProf=Lime;}
               if(OrderProfit()<0) { sss="-"; clrProf=Red;}
               
               ObjectSetText(tmp+"Cprof2", sss+DoubleToStr(MathAbs(OrderClosePrice()-OrderOpenPrice())/Point,0)+" МАГИК = "+OrderMagicNumber()+"("+DoubleToStr(MathAbs(OrderProfit()),0)+"$)",10,"Arial",clrProf);
               ObjectSet(tmp+"Cprof2", OBJPROP_ANGLE,90);
            }
            ObjectCreate(tmp+"CA", OBJ_ARROW, 0, CT/*+Period()*60*/, CP);
            ObjectSet(tmp+"CA", OBJPROP_COLOR, clr2);
            ObjectSet(tmp+"CA", OBJPROP_ARROWCODE, 3);
            /*if(mode==MODE_TRADES) 
            {
               
               ObjectCreate(tmp+"C", OBJ_ARROW, 0, CT+Period()*60, CP);
               ObjectSet(tmp+"C", OBJPROP_COLOR, clr2);
               ObjectSet(tmp+"C", OBJPROP_WIDTH, lblSize);
               ObjectSet(tmp+"C", OBJPROP_ARROWCODE, 6);
            }*/
         }
      }
   }
   //---торгуемые ордера>
}


void fShowTargets()
{
   int      i=0, prof_pts=0, ticket=0; 
   double   dist_stop_pts, dist_stop;
   double   dist_take_pts, dist_take;
   double   pr=(Ask+Bid)/2, prof=0;
   datetime CT=Time[0]+Period()*60*(WindowBarsPerChart()/20+2); // time shift
   double   CP=5*Point; // price shift
   int      FS=10; // font size
   color    prof_clr=Blue;
   string   txt="";
   //-------------------------------------------------------------
   for(i=0;i<10;i++)
   {
      ObjectDelete(Symbol()+DoubleToStr(Period(),0)+"vopen"+i+" МАГИК = "+OrderMagicNumber());
      ObjectDelete(Symbol()+DoubleToStr(Period(),0)+"vtake"+i+" МАГИК = "+OrderMagicNumber());
      ObjectDelete(Symbol()+DoubleToStr(Period(),0)+"vstop"+i+" МАГИК = "+OrderMagicNumber());
   }
   for(i=0;i<OrdersTotal();i++)
   if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
      // <---считаем
      RefreshRates();
      prof=OrderProfit();
      if(OrderType()==OP_BUY || OrderType()==3 || OrderType()==4) 
      {
         pr=Bid;
         prof_pts=pr/Point-OrderOpenPrice()/Point;
      }
      if(OrderType()==OP_SELL || OrderType()==2 || OrderType()==5)
      {
         pr=Ask;
         prof_pts=OrderOpenPrice()/Point-pr/Point;
      }
      prof_clr=White;
      if(prof_pts<0) prof_clr=Red;
      if(prof_pts>0) prof_clr=Lime;
      txt="";
      if(OrderType()==0 || OrderType()==1) txt=" ("+DoubleToStr(MathAbs(prof),2)+"$)";
      ObjectCreate(Symbol()+DoubleToStr(Period(),0)+"vopen"+i+" МАГИК = "+OrderMagicNumber(),OBJ_TEXT,0,CT,OrderOpenPrice()+CP);
      ObjectSetText(Symbol()+DoubleToStr(Period(),0)+"vopen"+i+" МАГИК = "+OrderMagicNumber(),DoubleToStr(MathAbs(prof_pts),0)+txt+" МАГИК = "+OrderMagicNumber(),FS,"Arial",prof_clr);

      dist_take_pts=0;dist_take=0;
      if(OrderTakeProfit()!=0) 
      {
         dist_take_pts=MathAbs(pr/Point-OrderTakeProfit()/Point);
         txt=DoubleToStr(dist_take_pts,0);
         dist_take_pts=MathAbs(OrderOpenPrice()/Point-OrderTakeProfit()/Point);
         txt=txt+"("+DoubleToStr(dist_take_pts,0)+"/"+DoubleToStr(dist_take_pts*OrderLots()*10,0)+"$)";
         
         ObjectCreate(Symbol()+DoubleToStr(Period(),0)+"vtake"+i+" МАГИК = "+OrderMagicNumber(),OBJ_TEXT,0,CT,OrderTakeProfit()+CP);
         ObjectSetText(Symbol()+DoubleToStr(Period(),0)+"vtake"+i+" МАГИК = "+OrderMagicNumber(),txt+" МАГИК = "+OrderMagicNumber(),FS,"Arial",Lime);
      }
      
      dist_stop_pts=0;dist_stop=0;
      if(OrderStopLoss()!=0)
      {
         dist_stop_pts=MathAbs(pr/Point-OrderStopLoss()/Point);
         txt=DoubleToStr(dist_stop_pts,0);
         dist_stop_pts=MathAbs(OrderOpenPrice()/Point-OrderStopLoss()/Point);
         txt=txt+"("+DoubleToStr(dist_stop_pts,0)+"/"+DoubleToStr(dist_stop_pts*OrderLots()*10,0)+"$)";

         ObjectCreate(Symbol()+DoubleToStr(Period(),0)+"vstop"+i+" МАГИК = "+OrderMagicNumber(),OBJ_TEXT,0,CT,OrderStopLoss()+CP);
         ObjectSetText(Symbol()+DoubleToStr(Period(),0)+"vstop"+i+" МАГИК = "+OrderMagicNumber(),txt+" МАГИК = "+OrderMagicNumber(),FS,"Arial",Red);
      }
      // рисуем--->
   }
}

//void CheckDonate()
//{
//   int fd=0; string pay="0"; datetime dt=0;
//   string fn="VisualOrders.txt";
//   fd=FileOpen(fn,FILE_READ|FILE_CSV,";");
//   if(fd>=1)
//   {
//      pay=FileReadString(fd); if(pay!="0" && pay!="1") pay="0";
//      dt=StrToTime(FileReadString(fd));
//   }
//   else
//   {
//      dt=TimeCurrent();
//      fd=FileOpen(fn,FILE_WRITE|FILE_CSV,";");
//      FileWrite(fd,"0",TimeToStr(dt,TIME_DATE));
//   }
//   FileClose(fd);
//  

//   if(pay=="0" && (TimeCurrent()-dt)>10*24*60*60) // 5 дней
//   {
//      if(MessageBoxA(0,"Если Вам понравился индикатор VisualOrders,\n хотите помочь автору материально?","Вопрос",4)==6)
  //    {
    //     ShellExecuteA(0,"Open","iexplore.exe","wmk:payto?Purse=R865705290089&Amount=100&Desc=Indicator&BringToFront=Y&ExecEvenKeeperIsOffline=Y","",7);
      //   pay="1";
//      }
  //    dt=TimeCurrent();
    //  
      //fd=FileOpen(fn,FILE_WRITE|FILE_CSV,";");
//      FileWrite(fd,pay,TimeToStr(dt,TIME_DATE));
  //    FileClose(fd);
//   }
//   FileClose(fd);
//}


//+------------------------------------------------------------------+