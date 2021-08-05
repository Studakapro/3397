//+------------------------------------------------------------------+
//|                                                HighLowAnswer.mq4 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window

extern int ClosePeriod=10;
extern double BuySealCoordinates=0.02;
extern double SellSealCoordinates=0.05;
extern bool StartSw=60;
extern datetime StartTime=D'2013.01.01 00:00';
extern bool EndSw=0;
extern datetime EndTime=D'2013.07.01 00:00';

int b,s,z,ct,st,bt,Sell,Buy,CSell,CBuy,SCombo,BCombo,MaxSCombo,MaxBCombo,Draw,CDraw;

double cl;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   b=Bars;
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   for(int z=0;z<s;z++)ObjectDelete("Seal"+z);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   while(b>0)
     {
      int counted_bars=IndicatorCounted();
      int BC=Bars-counted_bars;
      if(BC<2)return;
   
      if(StartSw==1 && StartTime>Time[b]){b--;continue;}
      if(EndSw==1 && EndTime<Time[b])break;
      
      if(TimeMinute(Time[b])==0 || TimeMinute(Time[b])==15 || TimeMinute(Time[b])==30 || TimeMinute(Time[b])==45 || TimeMinute(Time[b])==75 || TimeMinute(Time[b])==120 || TimeMinute(Time[b])==195 || TimeMinute(Time[b])==315 || TimeMinute(Time[b])==510 || TimeMinute(Time[b])==825 || TimeMinute(Time[b])==1335 || TimeMinute(Time[b])==2160)
        {
         ct=TimeMinute(Time[b])+ClosePeriod;
         if(ct>=60)ct=ct-60;
         for(z=1;z<=ClosePeriod;z++)
           {
            if(TimeMinute(Time[b-z])==ct)
              {
               cl=Open[b-z];
               break;
              }
           }
         if(Open[b]>cl && cl!=0)
           {
            Sell++;
            ObjectCreate("Seal"+s,OBJ_ARROW,0,Time[b],High[b]+SellSealCoordinates);//â~çÇ
            ObjectSet("Seal"+s,OBJPROP_ARROWCODE,226);
            ObjectSet("Seal"+s,OBJPROP_COLOR,Blue);
            s++;
           }
         if(Open[b]<cl && cl!=0)
           {
            Buy++;
            ObjectCreate("Seal"+s,OBJ_ARROW,0,Time[b],Low[b]-BuySealCoordinates);//â~à¿
            ObjectSet("Seal"+s,OBJPROP_ARROWCODE,225);
            ObjectSet("Seal"+s,OBJPROP_COLOR,Red);
            s++;
           }
         if(Open[b]==cl && cl!=0)
           {
            Draw++;
            ObjectCreate("Seal"+s,OBJ_ARROW,0,Time[b],High[b]+SellSealCoordinates);//ìØíl
            ObjectSet("Seal"+s,OBJPROP_ARROWCODE,179);
            ObjectSet("Seal"+s,OBJPROP_COLOR,Black);
            s++;
           }
         if(CSell<Sell)
           {
            SCombo++;
            BCombo=0;
            if(MaxSCombo<SCombo)
              {
               MaxSCombo=SCombo;
               st=b;
              }
           }
         if(CBuy<Buy)
           {
            BCombo++;
            SCombo=0;
            if(MaxBCombo<BCombo)
              {
               MaxBCombo=BCombo;
               bt=b;
              }
           }
         if(CDraw<Draw)
           {
            BCombo=0;
            SCombo=0;
           }
         CSell=Sell;
         CBuy=Buy;
         CDraw=Draw;
        }
      b--;
     }
   b++;
   
   Print("â~à¿:",Buy,"âÒ â~çÇ:",Sell,"âÒ ç≈çÇòAë±â~à¿:",MaxBCombo,"âÒ î≠ê∂ì˙",TimeYear(Time[bt]),".",TimeMonth(Time[bt]),"/",TimeDay(Time[bt]),"`",TimeHour(Time[bt])," ç≈çÇòAë±â~çÇ:",MaxSCombo,"âÒ î≠ê∂ì˙",TimeYear(Time[st]),".",TimeMonth(Time[st]),"/",TimeDay(Time[st]),"`",TimeHour(Time[st]));
   return(0);
  }
//+------------------------------------------------------------------+