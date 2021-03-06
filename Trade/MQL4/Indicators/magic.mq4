//+------------------------------------------------------------------+
//|                                                          adx.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

extern double Lots               = 0.1;
int magicnumber = 1000;

 
//+------------------------------------------------------------------+  
  void OnTick(){
   if(Volume[0]>1) return;
   CheckForOpen();
  }


//+------------------------------------------------------------------+
//| Check for open order conditions                                  |
//+------------------------------------------------------------------+
void CheckForOpen()
  {
   int op = -1;
   if (GlobalVariableGet(Symbol()+"_signalSent")==OP_SELL) op= OP_SELL;
   else
   if (GlobalVariableGet(Symbol()+"_signalSent")==OP_BUY) op= OP_BUY;
   if (op==-1) return;
   
//---- sell conditions
   int res;
   RefreshRates();
   if (op==OP_SELL){
     res=OrderSend(Symbol(),OP_SELL,Lots,Bid,3,
      // Ask+StopLoss*Point,Ask-TakeProfit*Point,
       0,0,"",magicnumber,0,Red);
     if (res > 0 ) {
       GlobalVariableSet(Symbol()+"_signalSent", -1);
       // print here message on successful order firing
     }
     else{
        //  print here error message to analyse reason
     }
   }
 
//---- buy conditions
   if( op==OP_BUY)  
     {
      res=OrderSend(Symbol(),OP_BUY,Lots,Ask,3,
       // Ask-StopLoss*Point,Ask+TakeProfit*Point,
        0,0,"",magicnumber,0,Blue);
       if (res > 0 ) {
       GlobalVariableSet(Symbol()+"_signalSent", -1);
       // print here message on successful order firing
     }
     else{
        // print here error message to analyse reason
     }
//----
     }
  }
//+------------------------------------------------------------------+
//| Start function                                                   |
//+------------------------------------------------------------------+
void start()
  {
    GlobalVariableDel(Symbol()+"_signalSent");
    return;
  }
void deinit(){
    GlobalVariableDel(Symbol()+"_signalSent"); 
    return; 
}