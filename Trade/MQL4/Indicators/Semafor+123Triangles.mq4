///+------------------------------------------------------------------+ 
// FXi 3 Semafor
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 DodgerBlue
#property indicator_color2 Red
#property indicator_color3 C'255,100,255'
#property indicator_color4 C'255,100,255'
#property indicator_color5 Yellow
#property indicator_color6 Yellow
//---- input parameters
input bool ShowSemafors = true; 
input double Period1=12; 
input double Period2=34; 
input double Period3=234;
input int Width1 = 5;
input int Width2 = 5;
input int Width3 = 5;
input int BarsCount = 3000;
input string note ="----------  Треугольники -----------";
input bool ShowTriangles  = true;
input int ОграничительТреугольников = 0;
input bool FillUp   = false;
input bool ShowMarks    = true;
input color BuyTriangle   = C'0,113,225';
input color SellTriangle  = C'210,57,0';
input color BuyMark   = DodgerBlue;
input color SellMark  = Red;
input int Width       =2;
input string copy   ="1";
int Dev=1; 
int Stp=1;
int Symbol_1_Kod=158;
int Symbol_2_Kod=159;
int Symbol_3_Kod=82;
//+----    mod of  TRO MODIFICATION ------------------------+ 
input string _____           ="       Оповещение";
input bool   ShowAlert    = true ;
input bool ShowAlertTr=false;
//---- buffers 
double FP_BuferUp[], FP_BuferDn[], NP_BuferUp[], NP_BuferDn[], HP_BuferUp[], HP_BuferDn[]; 
//+------------------------------------------------------------------+  
string symbol=Symbol();  
int    Type, key, keyTr, Ограничитель; 
color tColor = Yellow ;
//+------------------------------------------------------------------+ 
int init()   { 
   key=0;   keyTr=0;
   if(ShowSemafors) Type=DRAW_ARROW;  else Type=DRAW_NONE;
//+------------------------------------------------------------------+   
     SetIndexBuffer(0,HP_BuferUp);   SetIndexStyle(0,Type,EMPTY,Width3);   SetIndexArrow(0,Symbol_3_Kod);   SetIndexEmptyValue(0,00);  SetIndexLabel(0,"SlowUp");
     SetIndexBuffer(1,HP_BuferDn);   SetIndexStyle(1,Type,EMPTY,Width3);   SetIndexArrow(1,Symbol_3_Kod);   SetIndexEmptyValue(1,00);  SetIndexLabel(1,"SlowDn");

     SetIndexBuffer(2,NP_BuferUp);   SetIndexStyle(2,Type,EMPTY,Width2);   SetIndexArrow(2,Symbol_2_Kod);   SetIndexEmptyValue(2,00);  SetIndexLabel(2,"MiddleUp");
     SetIndexBuffer(3,NP_BuferDn);   SetIndexStyle(3,Type,EMPTY,Width2);   SetIndexArrow(3,Symbol_2_Kod);   SetIndexEmptyValue(3,00);  SetIndexLabel(3,"MiddleDn");

     SetIndexBuffer(4,FP_BuferUp);   SetIndexStyle(4,Type,EMPTY,Width1);   SetIndexArrow(4,Symbol_1_Kod);   SetIndexEmptyValue(4,00);  SetIndexLabel(4,"FastUp");
     SetIndexBuffer(5,FP_BuferDn);   SetIndexStyle(5,Type,EMPTY,Width1);   SetIndexArrow(5,Symbol_1_Kod);   SetIndexEmptyValue(5,00);  SetIndexLabel(5,"FastDn");

   if(ОграничительТреугольников==0) Ограничитель=10000; else  Ограничитель=ОграничительТреугольников;
   return(0); 
  } 
//+------------------------------------------------------------------+ 
int deinit()   {    return(0);   } 
//+------------------------------------------------------------------+ 
int start()   { 
//+------------------------------------------------------------------+    
   if (Period1>0) CountZZ(FP_BuferUp,FP_BuferDn,Period1,Dev,Stp);
   if (Period2>0) CountZZ(NP_BuferUp,NP_BuferDn,Period2,Dev,Stp);
   if (Period3>0) CountZZ(HP_BuferUp,HP_BuferDn,Period3,Dev,Stp);
//+------------------------------------------------------------------+  
   if ( ShowAlert && key!=Time[0])    {     
     if( HP_BuferUp[0] != 0 )   Alert(" Нижнее Солнышко на  " + symbol+"   "+ Period()+ "   на цене  "+ DoubleToStr(Close[0] ,Digits));
     if( HP_BuferDn[0] != 0 )   Alert(" Верхнее Солнышко на  "+ symbol+"   "+ Period()+ "   на цене  "+ DoubleToStr(Close[0] ,Digits));
     if(Period2>=34)  {
       if( NP_BuferUp[0] != 0 && HP_BuferUp[0] == 0)   Alert(" Нижняя Точка на  " + symbol+"   "+ Period()+ "   на цене  "+ DoubleToStr(Close[0] ,Digits));
       if( NP_BuferDn[0] != 0 && HP_BuferDn[0] == 0)   Alert(" Верхняя Точка на  "+ symbol+"   "+ Period()+ "   на цене  "+ DoubleToStr(Close[0] ,Digits));
     }
   }
   key=Time[0];   
//+------------------------------------------------------------------+  
   if(!ShowTriangles)   ChartCleaner();
   if(ShowTriangles)    Triangels();
   return(0);
}


double Triangels()  {
   bool  up;
   double OpenPrice, semafor3d, semafor3u, semafor1d, semafor1u, upper, lower;
   double price1, price2, price3, semafor3dn, semafor3up;
   int zz, lev1, time1, time2, time3;
//+------------------------------------------------------------------+
 if(keyTr!=Time[0])  {
   ChartCleaner();
/*
   if (zz1>0) CountZZ(FP_BuferUp,FP_BuferDn,zz1,Dev,Stp);
   if (zz2>0) CountZZ(NP_BuferUp,NP_BuferDn,zz2,Dev,Stp);
   if (zz3>0) CountZZ(HP_BuferUp,HP_BuferDn,zz3,Dev,Stp);
*/   
   double spread=MarketInfo(Symbol(), MODE_SPREAD)*Point;
   for(zz=BarsCount; zz>=1; zz--)  {
     price1=0;  price2=0;  price3=0;
     semafor3d=0; semafor3u=0;
     semafor3d=HP_BuferUp[zz];
     semafor3u=HP_BuferDn[zz];
     time1=Time[zz];
     if(semafor3d>0) {
       price1=semafor3d;
       up=false;
       OpenPrice=0; upper=0;
       for(lev1=zz-1; lev1>=1; lev1--)  {
         semafor3dn=HP_BuferUp[lev1];
         semafor3up=HP_BuferDn[lev1];
         if(semafor3up>0 || semafor3dn>0)  break;
         if(!up)  {
           semafor1u=FP_BuferDn[lev1];
           if(semafor1u>0)                  upper=semafor1u;
           if(upper>0 && upper>=semafor3d) {
             price2=upper;
             time2=Time[lev1];
             up=true;
           }
         } 
         else {
           lower=FP_BuferUp[lev1+1];
           if(lower>0 && lower>=semafor3d) {
             time3=Time[lev1+1];
             price3=lower;
           }
         }
         if(price1>0 && price2>0 && price3>0)  {
           OpenPrice=10; 
           if(lev1==1 && ShowAlertTr)  Alert(Symbol(),"   ", Period(), "     Buy!!!  Отложку на ", price2+2*2*Point+spread);
           break;
         } 
       }
       if(OpenPrice>0 && price2-price1<Ограничитель*Point)  {
         DrawTriangle(copy+"123h"+zz, time1, price1, time2, price2, time3, price3, BuyTriangle);
         DrawArrow(copy+"123_X"+lev1, time2+Period()*60, price2+2*2*Point+spread, BuyMark);
       }
     }

     if(semafor3u>0) {
       price1=semafor3u;
       up=false; 
       OpenPrice=0;  lower=0; upper=0;
       for(lev1=zz-1; lev1>=1; lev1--)  {
         semafor3dn=HP_BuferUp[lev1];
         semafor3up=HP_BuferDn[lev1];
         if(semafor3up>0 || semafor3dn>0)  break;
         if(!up)  {
           semafor1d=FP_BuferUp[lev1];
             if(semafor1d>0)               lower=semafor1d;
           if(lower>0 && lower<=semafor3u) {
             price2=lower;
             time2=Time[lev1];
             up=true;
           }
         } 
         else {
           upper=FP_BuferDn[lev1+1]; 
           if(upper>0 && upper<=semafor3u) {
             time3=Time[lev1+1];
             price3=upper;
           }
         }
         if(price1>0  && price2>0 && price3>0)  {
           OpenPrice=10; 
           if(lev1==1 && ShowAlertTr)  Alert(Symbol(),"   ", Period(), "     Sell!!!  Отложку на ", price2-2*Point);
           break;
         } 
       }
       if(OpenPrice>0 && price1-price2<Ограничитель*Point)  {
         DrawTriangle(copy+"123h"+zz, time1, price1, time2, price2, time3, price3, SellTriangle);
         DrawArrow(copy+"123_X"+lev1, time2+Period()*60, price2-2*Point, SellMark);
       }
     }
   }
   // конец функции нахождения 1-2-3 на бай
   keyTr=Time[0];
 }
 return(0);
}
//+------------------------------------------------------------------+
void DrawArrow(string name, int time, double price, color ops_color) {
   if(!ShowMarks)  return;
   int width=1, style=0;
   ObjectCreate(name, OBJ_ARROW, 0, time, price, 0, 0, 0, 0);
   ObjectSet(name, OBJPROP_WIDTH, 1);
   ObjectSet(name, OBJPROP_COLOR, ops_color);
   ObjectSet(name, OBJPROP_STYLE, 0);
   ObjectSet(name, OBJPROP_ARROWCODE, SYMBOL_RIGHTPRICE);
}
//+------------------------------------------------------------------+
void DrawTriangle(string name, int time1, double price1, int time2, double price2, int time3, double price3, color ops_color) {
   ObjectCreate(name, OBJ_TRIANGLE, 0, time1, price1, time2, price2, time3, price3);
   ObjectSet(name, OBJPROP_WIDTH, Width);
   ObjectSet(name, OBJPROP_BACK, FillUp);
   ObjectSet(name, OBJPROP_COLOR, ops_color);
}
//+------------------------------------------------------------------+
void ChartCleaner()   {
  for(int a=0; a<Bars; a++)  {
    ObjectDelete(copy+"123h" + a);
    ObjectDelete(copy+"123b" + a);
    ObjectDelete(copy+"123s" + a);
    ObjectDelete(copy+"123_X" + a);
  }
}
//+------------------------------------------------------------------+





//+------------------------------------------------------------------+   
int CountZZ( double& ExtMapBuffer[], double& ExtMapBuffer2[], int ExtDepth, int ExtDeviation, int ExtBackstep )
  {
   int    shift, back,lasthighpos,lastlowpos, limit;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;
   limit=Bars-ExtDepth;
   if(limit>BarsCount) limit=BarsCount;   
   for(shift=limit; shift>=0; shift--)
     {
      val=Low[Lowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      if(val==lastlow) val=00;
      else 
        { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) val=00;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=ExtMapBuffer[shift+back];
               if((res!=0)&&(res>val)) ExtMapBuffer[shift+back]=00; 
              }
           }
        } 
        
          ExtMapBuffer[shift]=val;
      //--- high
      val=High[Highest(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(val==lasthigh) val=00;
      else 
        {
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) val=00;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=ExtMapBuffer2[shift+back];
               if((res!=0)&&(res<val)) ExtMapBuffer2[shift+back]=00; 
              } 
           }
        }
      ExtMapBuffer2[shift]=val;
     }
   // final cutting 
   lasthigh=-1; lasthighpos=-1;
   lastlow=-1;  lastlowpos=-1;

   for(shift=limit; shift>=0; shift--)
     {
      curlow=ExtMapBuffer[shift];
      curhigh=ExtMapBuffer2[shift];
      if((curlow==0)&&(curhigh==0)) continue;
      //---
      if(curhigh!=0)
        {
         if(lasthigh>0) 
           {
            if(lasthigh<curhigh) ExtMapBuffer2[lasthighpos]=0;
            else ExtMapBuffer2[shift]=0;
           }
         //---
         if(lasthigh<curhigh || lasthigh<0)
           {
            lasthigh=curhigh;
            lasthighpos=shift;
           }
         lastlow=-1;
        }
      //----
      if(curlow!=0)
        {
         if(lastlow>0)
           {
            if(lastlow>curlow) ExtMapBuffer[lastlowpos]=0;
            else ExtMapBuffer[shift]=0;
           }
         //---
         if((curlow<lastlow)||(lastlow<0))
           {
            lastlow=curlow;
            lastlowpos=shift;
           } 
         lasthigh=-1;
        }
     }
  
   for(shift=limit; shift>=0; shift--)
     {
      if(shift>=limit) ExtMapBuffer[shift]=00;
      else
        {
         res=ExtMapBuffer2[shift];
         if(res!=00) ExtMapBuffer2[shift]=res;
        }
     }
   return(0);
 }
//+------------------------------------------------------------------+   
