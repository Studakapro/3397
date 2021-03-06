//+------------------------------------------------------------------+
//|                                  1-2-3 Trading Signals Panel.mq4 |
//|                                        Copyright © 2018, kaza007 |
//|                                                                  |
//+------------------------------------------------------------------+
//| Credits to:                                                      |
//| Lawgirl's Trend Display v1.02, gspe                              |
//| - used code as a template so I didn't have to reinvent the wheel |
//| EA 123 02, Blueseahorse                                          |
//| - used code for long and short rules for triggers                |
//| xzl Countdown Timer fix b2, Madhatt30                            |
//| - used code to get accurate bar time remaining                   |
//|                                                                  |
//| Thanks for sharing your code guys :)                             |                                     |
//+------------------------------------------------------------------+

#property copyright "Copyright © 2018, kaza007"
#property link      "https://www.forexfactory.com/kaza007"

#property indicator_chart_window
#property indicator_buffers 0

extern string	PairsToTrade = "AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURNZD,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPNZD,GBPUSD,NZDCAD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDJPY"; // List of symbols (separated by ",")
extern bool		ShowCurrentPairOnly  = false; //	Dispaly only chart Pair

extern string	info0="----bar clock inputs----";
input int      Broker_Time_Offset = 2;

extern string	info1="----Pair display inputs----";
extern int		FontSize       = 11;
extern color	FontColour     = Yellow;
extern string	Font_Font      = "Lucida Sans Unicode";
extern int	   DisplayStarts_X= 5;	//we are positioning the object from the top right corner of window
extern int	   DisplayStarts_Y= 15;

extern color	colorCodeSUP      = Lime;
extern color	colorCodeSDN      = Red;
extern color	colorCodeNoSignal = MidnightBlue;

extern string	info2="----Signal Trigger level----";
extern int     TEST_PIPS      = 100;

//extern string	info3="----Alerts----";
//extern bool    SoundAlert     = true; // not used yet

int            timeOffset;
datetime       ServerLocalOffset;
datetime       prevTime,myTime,localtime;

int	         symbolCodeSUP=233,
		         symbolCodeSDN=234,
		         symbolCodeNoSignal=232;

//Pair extraction
int		NoOfPairs;				   // Holds the number of pairs passed by the user via the inputs screen
string	TradePair[];			   //Array to hold the pairs traded by the user
int		TradeTrendSymbol[];	//Array to hold the pairs trend symbol
color 	TradeTrendColor[];	//Array to hold the pairs trend color

int      WindowNo = 0;
//+------------------------------------------------------------------+
// objects drawn by this indicator will be prefixed with these strings
string objPrefix;
string buff_str;
string barend_str;
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
{
//+------------------------------------------------------------------+ 
//----
   EventSetTimer(1);
   int s=0,i=StringFind(PairsToTrade,";",s);
   //string current;
	objPrefix = WindowExpertName();
	
	if(!ShowCurrentPairOnly)
	{
		//Extract the pairs traded by the user
		NoOfPairs = StringFindCount(PairsToTrade,",")+1;
		ArrayResize(TradePair, NoOfPairs);
		string AddChar = StringSubstr(Symbol(),6,4);
		StrPairToStringArray(PairsToTrade, TradePair, AddChar);
	}
	else
	{
		//Fill the array with only chart pair
		NoOfPairs = 1;
		ArrayResize(TradePair, NoOfPairs);
		TradePair[0] = Symbol();
	}
	
//----	
	ArrayResize(TradeTrendSymbol, NoOfPairs);
	ArrayInitialize(TradeTrendSymbol, symbolCodeNoSignal);		// Inizialize the array with symbolCodeNoSignal
	ArrayResize(TradeTrendColor, NoOfPairs);
	ArrayInitialize(TradeTrendColor, colorCodeNoSignal);		// Inizialize the array with colorCodeNoSignal
//----
   localtime = TimeLocal();//-ServerLocalOffset;

   datetime srvtime,tmpOffset;
   
   tmpOffset = TimeSeconds(srvtime) - TimeSeconds(localtime);
   if(tmpOffset < 30 && tmpOffset >= 0){
      timeOffset = TimeSeconds(srvtime) - TimeSeconds(localtime);
   }

//-----------------------------------------

	return(0);
}// End init()

//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
{
//----
   EventKillTimer();

	Comment("");   
//+------------------------------------------------------------------+ 
	RemoveObjects(objPrefix);

//----
	return(0);
}// End deinit()

//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
{
   return(0);

}//End start()
//+------------------------------------------------------------------+

//-------------------------------------------------------------------+
// RemoveObjects                                                     |
//-------------------------------------------------------------------+
void RemoveObjects(string Pref)
{   
	int i;
	string objname = "";

	for (i = ObjectsTotal(); i >= 0; i--)
	{
		objname = ObjectName(i);
		if (StringFind(objname, Pref, 0) > -1) ObjectDelete(objname);
	}
	return(0);
} // End void RemoveObjects(string Pref)

//+------------------------------------------------------------------+
// StringFindCount                                                   |
//+------------------------------------------------------------------+
int StringFindCount(string str, string str2)
// Returns the number of occurrences of STR2 in STR
// Usage:   int x = StringFindCount("ABCDEFGHIJKABACABB","AB")   returns x = 3
{
  int c = 0;
  for (int i=0; i<StringLen(str); i++)
    if (StringSubstr(str,i,StringLen(str2)) == str2)  c++;
  return(c);
} // End int StringFindCount(string str, string str2)

//+------------------------------------------------------------------+
// StrPairToStringArray                                                  |
//+------------------------------------------------------------------+
void StrPairToStringArray(string str, string &a[], string p_suffix, string delim=",")
{
	int z1=-1, z2=0;
	for (int i=0; i<ArraySize(a); i++)
	{
		z2 = StringFind(str,delim,z1+1);
		a[i] = StringSubstr(str,z1+1,z2-z1-1) + p_suffix;
		if (z2 >= StringLen(str)-1)   break;
		z1 = z2;
	}
	return(0);
} // End void StrPairToStringArray(string str, string &a[], string p_suffix, string delim=",") 

//+------------------------------------------------------------------+
// StrToStringArray                                                  |
//+------------------------------------------------------------------+
void StrToStringArray(string str, string &a[], string delim=",")
{
	int z1=-1, z2=0;
	for (int i=0; i<ArraySize(a); i++)
	{
		z2 = StringFind(str,delim,z1+1);
		a[i] = StringSubstr(str,z1+1,z2-z1-1);
		if (z2 >= StringLen(str)-1)   break;
		z1 = z2;
	}
	return(0);
} // End void StrToStringArray(string str, string &a[], string delim=",") 

//+------------------------------------------------------------------+
// StringUpper(string str)                                           |
//+------------------------------------------------------------------+
// Converts any lowercase characters in a string to uppercase
// Usage:    string x=StringUpper("The Quick Brown Fox")  returns x = "THE QUICK BROWN FOX"
string StringUpper(string str)
{
  string outstr = "";
  string lower  = "abcdefghijklmnopqrstuvwxyz";
  string upper  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for(int i=0; i<StringLen(str); i++)  {
    int t1 = StringFind(lower,StringSubstr(str,i,1),0);
    if (t1 >=0)  
      outstr = outstr + StringSubstr(upper,t1,1);
    else
      outstr = outstr + StringSubstr(str,i,1);
  }
  return(outstr);
}  
//+------------------------------------------------------------------+
//| GetPairTrends                                                    |
//+------------------------------------------------------------------+
void GetPairTrends(int &trend_symbol[], color &trend_color[])
{
	int i;
	
	for(i=0; i<NoOfPairs; i++)
	{
	//PrintFormat(TradePair[i]);
			trend_symbol[i] = symbolCodeNoSignal;
			trend_color[i] = colorCodeNoSignal;
			
      //test long----------------------------------------------------------------------------
      if (
      // Low[1] == iLow(NULL,PERIOD_D1,0) && Low[0] > Low[1] && Low[0] < Open[0]
         iLow(TradePair[i],PERIOD_H1,1) == iLow(TradePair[i],PERIOD_D1,0) && iLow(TradePair[i],PERIOD_H1,0) > iLow(TradePair[i],PERIOD_H1,1) && iLow(TradePair[i],PERIOD_H1,0) < iOpen(TradePair[i],PERIOD_H1,0)
      // && Low[0] < ( Low[1] + TEST_PIPS*Point ) //&& Open[0] - Low[0] > 0.3 *(Open[0] - Low[1]) 
         && iLow(TradePair[i],PERIOD_H1,0) < ( iLow(TradePair[i],PERIOD_H1,1) + TEST_PIPS*MarketInfo(TradePair[i],MODE_POINT) ) //&& Open[0] - Low[0] > 0.3 *(Open[0] - Low[1]) 
      // && Bid > Open[0]
         && MarketInfo(TradePair[i],MODE_BID) > iOpen(TradePair[i],PERIOD_H1,0)
         ) 
         {
            trend_symbol[i] = symbolCodeSUP;
            trend_color[i] = colorCodeSUP;
         }
         
      //test short-------------------------------------------------------------------------------
      if (
      // High[1] == iHigh(TradePair[i],PERIOD_D1,0) && High[0] < High[1] && High[0] > Open[0]
         iHigh(TradePair[i],PERIOD_H1,1) == iHigh(TradePair[i],PERIOD_D1,0) && iHigh(TradePair[i],PERIOD_H1,0) < iHigh(TradePair[i],PERIOD_H1,1) && iHigh(TradePair[i],PERIOD_H1,0) > iOpen(TradePair[i],PERIOD_H1,0)
      // && High[0] > ( High[1] - TEST_PIPS*Point ) //&& High[0] - Open[0] > 0.3 *(High[1] - Open[0])
         && iHigh(TradePair[i],PERIOD_H1,0) > ( iHigh(TradePair[i],PERIOD_H1,1) - TEST_PIPS*MarketInfo(TradePair[i],MODE_POINT) ) //&& High[0] - Open[0] > 0.3 *(High[1] - Open[0])
      // && Ask < Open[0]
         && MarketInfo(TradePair[i],MODE_ASK) < iOpen(TradePair[i],PERIOD_H1,0)
         )
         {
            trend_symbol[i] = symbolCodeSDN;
            trend_color[i] = colorCodeSDN;
         }
	} //End for(i=0; i<NoOfPairs; i++)
	return(0);

}//End GetPairTrends(int &trend_symbol[], color &trend_color[])

//+------------------------------------------------------------------+
//| PrintPairTrends                                                    |
//+------------------------------------------------------------------+
void PrintPairTrends()
{
	RemoveObjects(objPrefix);
	int i;
	
   //separater
		buff_str = StringConcatenate(objPrefix, "_LineStart");
		ObjectDelete(buff_str);
		ObjectCreate(buff_str,OBJ_LABEL,WindowNo,0,0,0,0);
		ObjectSet(buff_str,OBJPROP_CORNER,1);
		ObjectSet(buff_str,OBJPROP_XDISTANCE,DisplayStarts_X + (FontSize*2)*1);
		ObjectSet(buff_str,OBJPROP_YDISTANCE,DisplayStarts_Y + (i+0)*(FontSize+FontSize/2));
      ObjectSetText(buff_str,"---------------",FontSize-2,Font_Font,FontColour);

	//bar timer
      localtime = TimeLocal()+(TimeGMTOffset()+((60*60)*Broker_Time_Offset));
      
		buff_str = StringConcatenate(objPrefix, "_BarTimer");
		barend_str = "Bar end:" + TimeToStr(Time[0]+Period()*60-localtime-timeOffset,TIME_SECONDS);
		ObjectDelete(buff_str);
		ObjectCreate(buff_str,OBJ_LABEL,WindowNo,0,0,0,0);
		ObjectSet(buff_str,OBJPROP_CORNER,1);
		ObjectSet(buff_str,OBJPROP_XDISTANCE,DisplayStarts_X + (FontSize*2)*1);
		ObjectSet(buff_str,OBJPROP_YDISTANCE,DisplayStarts_Y + (i+1)*(FontSize+FontSize/2));
      ObjectSetText(buff_str,barend_str,FontSize-2,Font_Font,FontColour);

   //bar timer separater
		buff_str = StringConcatenate(objPrefix, "_BarTimer_Line");
		ObjectDelete(buff_str);
		ObjectCreate(buff_str,OBJ_LABEL,WindowNo,0,0,0,0);
		ObjectSet(buff_str,OBJPROP_CORNER,1);
		ObjectSet(buff_str,OBJPROP_XDISTANCE,DisplayStarts_X + (FontSize*2)*1);
		ObjectSet(buff_str,OBJPROP_YDISTANCE,DisplayStarts_Y + (i+2)*(FontSize+FontSize/2));
      ObjectSetText(buff_str,"---------------",FontSize-2,Font_Font,FontColour);

	//Set Trade Pair
	for(i=0; i<NoOfPairs; i++)
	{
		buff_str = StringConcatenate(objPrefix, TradePair[i], "H1");
		ObjectDelete(buff_str);
		ObjectCreate(buff_str,OBJ_LABEL,WindowNo,0,0,0,0);
		ObjectSet(buff_str,OBJPROP_CORNER,1);
		ObjectSet(buff_str,OBJPROP_XDISTANCE,DisplayStarts_X + (FontSize*2)*3);
		ObjectSet(buff_str,OBJPROP_YDISTANCE,DisplayStarts_Y + (i+3)*(FontSize+FontSize/2));
		ObjectSetText(buff_str,TradePair[i],FontSize-2,Font_Font,FontColour);
	}
	
	//Set Trade Trend
	for(i=0; i<NoOfPairs; i++)
	{
	   buff_str = StringConcatenate(objPrefix, TradePair[i]);
		ObjectDelete(buff_str);
		ObjectCreate(buff_str,OBJ_LABEL,WindowNo,0,0,0,0);
 		ObjectSet(buff_str,OBJPROP_CORNER,1);
		ObjectSet(buff_str,OBJPROP_XDISTANCE,DisplayStarts_X + (FontSize*2)*1.5);
		ObjectSet(buff_str,OBJPROP_YDISTANCE,DisplayStarts_Y + (i+3)*(FontSize+FontSize/2));
		ObjectSetText(buff_str,CharToStr(TradeTrendSymbol[i]),FontSize,"Wingdings",TradeTrendColor[i]);
	}
	
   //separater
		buff_str = StringConcatenate(objPrefix, "_LineEnd");
		ObjectDelete(buff_str);
		ObjectCreate(buff_str,OBJ_LABEL,WindowNo,0,0,0,0);
		ObjectSet(buff_str,OBJPROP_CORNER,1);
		ObjectSet(buff_str,OBJPROP_XDISTANCE,DisplayStarts_X + (FontSize*2)*1);
		ObjectSet(buff_str,OBJPROP_YDISTANCE,DisplayStarts_Y + (i+3)*(FontSize+FontSize/2));
      ObjectSetText(buff_str,"---------------",FontSize-2,Font_Font,FontColour);

	
//----
	return(0);

}//End PrintPairTrends()

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   GetPairTrends(TradeTrendSymbol, TradeTrendColor);
   PrintPairTrends();

  }
//+------------------------------------------------------------------+ 

