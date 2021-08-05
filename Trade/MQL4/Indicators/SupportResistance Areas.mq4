//+------------------------------------------------------------------+
//|                                                 Copyright © 2011 |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2011"
#property link      ""

#property indicator_chart_window
extern int NumberOfSupDem=2;
extern color TopColor=Maroon;
extern color BotColor=DarkBlue;


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
 int total=NumberOfSupDem;
 for(int i=1;i<=total;i++)
 {
 ObjectDelete("SupDemUP"+i);
 ObjectDelete("SupDemDN"+i);
 }  
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted();
 
//----
if(NewBar()==true)
{
for(int i=1;i<=NumberOfSupDem;i++)
{
PlaceSupDemUP(i);
PlaceSupDemDN(i);
}
}
//----
   return(0);
  }

double FindNearFractal(string sy="0", int tf=0, int mode=MODE_LOWER, int count=1) {
  if (sy=="" || sy=="0") sy=Symbol();
  double f=0;
  int d=MarketInfo(sy, MODE_DIGITS), s;
  if (d==0) if (StringFind(sy, "JPY")<0) d=4; else d=2;
 int c=0;
  for (s=2; s<100; s++) {
    f=iFractals(sy, tf, mode, s);
    if (f!=0) 
    {
    c++;
    if(c==count) return(NormalizeDouble(s, d));
    }
  }
  Print("FindNearFractal():");
  return(0);
}

int PlaceSupDemUP(int count=1)
{
int per;
if (Period()>PERIOD_H1) per=Period(); else per=PERIOD_D1;

int barshift=FindNearFractal("0", per,MODE_UPPER,count);
if(ObjectFind("SupDemUP"+count)==-1) ObjectCreate("SupDemUP"+count,OBJ_RECTANGLE,0,iTime(NULL,per,barshift),iHigh(NULL,per,barshift),Time[0],MathMax(iClose(NULL,per,barshift),iOpen(NULL,per,barshift)));
ObjectSet("SupDemUP"+count,OBJPROP_TIME1,iTime(NULL,per,barshift));
ObjectSet("SupDemUP"+count,OBJPROP_PRICE1,iHigh(NULL,per,barshift));
ObjectSet("SupDemUP"+count,OBJPROP_TIME2,Time[0]);
ObjectSet("SupDemUP"+count,OBJPROP_PRICE2,MathMax(iClose(NULL,per,barshift),iOpen(NULL,per,barshift)));
ObjectSet("SupDemUP"+count,OBJPROP_COLOR,TopColor);
return(0);
}

int PlaceSupDemDN(int count=1)
{
int per;
if (Period()>PERIOD_H1) per=Period(); else per=PERIOD_D1;

int barshift=FindNearFractal("0", per,MODE_LOWER,count);
if(ObjectFind("SupDemDN"+count)==-1) ObjectCreate("SupDemDN"+count,OBJ_RECTANGLE,0,iTime(NULL,per,barshift),MathMin(iClose(NULL,per,barshift),iOpen(NULL,per,barshift)),Time[0],iLow(NULL,per,barshift));
ObjectSet("SupDemDN"+count,OBJPROP_TIME1,iTime(NULL,per,barshift));
ObjectSet("SupDemDN"+count,OBJPROP_PRICE1,MathMin(iClose(NULL,per,barshift),iOpen(NULL,per,barshift)));
ObjectSet("SupDemDN"+count,OBJPROP_TIME2,Time[0]);
ObjectSet("SupDemDN"+count,OBJPROP_PRICE2,iLow(NULL,per,barshift));
ObjectSet("SupDemDN"+count,OBJPROP_COLOR,BotColor);
return(0);
}

bool NewBar() {

	static datetime LastTime = 0;

	if (Time[0] != LastTime) {
		LastTime = Time[0];		
		return (true);
	} else
		return (false);
}