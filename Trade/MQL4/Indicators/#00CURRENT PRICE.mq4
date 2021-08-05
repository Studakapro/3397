//+------------------------------------------------------------------+
//|                                                CURRENT PRICE.mq4 |
//|                                                           cja    |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Original code supplied by Kalenzo"
#property link      "bartlomiej.gorski@gmail.com"
#property link      "Modified code by cja"
#property link      "Modified code by xard777"

//Helps to see the current price in a separate window when price is 
//covered by labels from pivot or murrey math lines 

#property indicator_separate_window
#property indicator_buffers 1
double s1[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
IndicatorShortName("INFO PANEL ");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   
//----
   // this will write ema value, but it can be any value that u want 
   // for eg. iCustom value or value that u got from object like muray math line
   double myFirstValue = iMA(Symbol(),0,1,0,MODE_EMA,PRICE_CLOSE,0);

	double i;
   int m,s,k;
   m=Time[0]+Period()*60-CurTime();
   i=m/60.0;
   s=m%60;
   m=(m-m%60)/60;
   //Comment(m + " minutes " + s + " seconds left to bar end");
   i=NormalizeDouble(i,1);
   for (k=1;k<=Bars-1;k++) s1[k]=0.0000001;
   for (k=1;k<=2;k++) s1[k]=i;
	//(m,Digits-4)
        ObjectCreate("MyLabel", OBJ_LABEL, WindowFind("INFO PANEL..."), 0, 0);
        ObjectSetText("MyLabel",DoubleToStr(myFirstValue,Digits),15, "Arial Black", Red);
        ObjectSet("MyLabel", OBJPROP_CORNER, 0);
        ObjectSet("MyLabel", OBJPROP_XDISTANCE, 150);
        ObjectSet("MyLabel", OBJPROP_YDISTANCE, 0);
        
        ObjectCreate("MyLabel2", OBJ_LABEL, WindowFind("INFO PANEL..."), 0, 0);
        ObjectSetText("MyLabel2",DoubleToStr(m,-4),15, "Arial Black", MediumSeaGreen);
        ObjectSet("MyLabel2", OBJPROP_CORNER, 0);
        ObjectSet("MyLabel2", OBJPROP_XDISTANCE, 290);
        ObjectSet("MyLabel2", OBJPROP_YDISTANCE, 0);
   
        ObjectCreate("MyLabel3", OBJ_LABEL, WindowFind("INFO PANEL..."), 0, 0);
        ObjectSetText("MyLabel3",DoubleToStr(s,-4), 15, "Arial Black", MediumSeaGreen);
        ObjectSet("MyLabel3", OBJPROP_CORNER, 0);
        ObjectSet("MyLabel3", OBJPROP_XDISTANCE, 390);
        ObjectSet("MyLabel3", OBJPROP_YDISTANCE, 0);  
   
        ObjectCreate("MyLabel4", OBJ_LABEL, WindowFind("INFO PANEL..."), 0, 0);
        ObjectSetText("MyLabel4","Mins ", 11, "Arial Black", DodgerBlue);
        ObjectSet("MyLabel4", OBJPROP_CORNER, 0);
        ObjectSet("MyLabel4", OBJPROP_XDISTANCE, 250);
        ObjectSet("MyLabel4", OBJPROP_YDISTANCE, 0);
   
        ObjectCreate("MyLabel5", OBJ_LABEL, WindowFind("INFO PANEL..."), 0, 0);
        ObjectSetText("MyLabel5","Secs", 11, "Arial Black", DodgerBlue);
        ObjectSet("MyLabel5", OBJPROP_CORNER, 0);
        ObjectSet("MyLabel5", OBJPROP_XDISTANCE, 350);
        ObjectSet("MyLabel5", OBJPROP_YDISTANCE, 0);
        
        ObjectCreate("MyLabel6", OBJ_LABEL, WindowFind("INFO PANEL..."), 0, 0);
        ObjectSetText("MyLabel6","Price", 11, "Arial Black", DodgerBlue);
        ObjectSet("MyLabel6", OBJPROP_CORNER, 0);
        ObjectSet("MyLabel6", OBJPROP_XDISTANCE, 107);
        ObjectSet("MyLabel6", OBJPROP_YDISTANCE, 0);
//----
   return(0);
  }
//+------------------------------------------------------------------+