//+------------------------------------------------------------------+
//|                                                    DT_ZZ_nen.mq4 |
//|           Модифицировал nen 11-1-2007                            |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, klot."
#property link      "klot@mail.ru"
#property link      "http://onix-trade.net/forum/index.php?s=&showtopic=4786&view=findpost&p=273797"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Aqua
#property indicator_color2 Blue
#property indicator_color3 Red
#property indicator_width2 2
#property indicator_width3 2 

//---- indicator parameters
extern int ExtDepth=12;
extern int ExtLabel=0;
//---- indicator buffers
double zzL[];
double zzH[];
double zz[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
 //  IndicatorBuffers(3);
//---- drawing settings
   SetIndexStyle(0,DRAW_SECTION);
   SetIndexStyle(1,DRAW_ARROW);
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexArrow(1,159);
   SetIndexArrow(2,159);
//---- indicator buffers mapping
   SetIndexBuffer(0,zz);
   SetIndexBuffer(1,zzH);
   SetIndexBuffer(2,zzL);
   SetIndexEmptyValue(0,0.0);
   SetIndexEmptyValue(1,0.0);
   SetIndexEmptyValue(2,0.0);
     
//---- indicator short name
   IndicatorShortName("DT_ZZ("+ExtDepth+")");
//---- initialization done
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int    i,shift,pos,lasthighpos,lastlowpos,curhighpos,curlowpos;
   double curlow,curhigh,lasthigh,lastlow;
   double min, max;
   ArrayInitialize(zz,0.0);
   ArrayInitialize(zzL,0.0);
   ArrayInitialize(zzH,0.0);
   
   lasthighpos=Bars; lastlowpos=Bars;
   lastlow=Low[Bars];lasthigh=High[Bars];
  for(shift=Bars-ExtDepth; shift>=0; shift--)
    {
      curlowpos=Lowest(NULL,0,MODE_LOW,ExtDepth,shift);
      curlow=Low[curlowpos];
      curhighpos=Highest(NULL,0,MODE_HIGH,ExtDepth,shift);
      curhigh=High[curhighpos];
      //------------------------------------------------
      if( curlow>=lastlow ) { lastlow=curlow; }
      else
         { 
            //идем вниз
            if( lasthighpos>curlowpos  ) 
            { 
            zzL[curlowpos]=curlow;
              ///*
              min=100000; pos=lasthighpos;
              for(i=lasthighpos; i>=curlowpos; i--)
                 { 
                   if (zzL[i]==0.0) continue;
                   if (zzL[i]<min) { min=zzL[i]; pos=i; }
                   zz[i]=0.0;
                 } 
              zz[pos]=min;
              //*/
            } 
          lastlowpos=curlowpos;
          lastlow=curlow; 
         }
      //--- high
      if( curhigh<=lasthigh )  { lasthigh=curhigh;}
      else
         {  
            // идем вверх
            if( lastlowpos>curhighpos ) 
            {  
            zzH[curhighpos]=curhigh;
           ///*
               max=-100000; pos=lastlowpos;
               for(i=lastlowpos; i>=curhighpos; i--)
                  { 
                    if (zzH[i]==0.0) continue;
                    if (zzH[i]>max) { max=zzH[i]; pos=i; }
                    zz[i]=0.0;
                  } 
               zz[pos]=max;
           //*/     
            }  
         lasthighpos=curhighpos;
         lasthigh=curhigh;    
         }       
    //----------------------------------------------------------------------
    }
 if (ExtLabel>0) Metka();

 return(0);
}
//+------------------------------------------------------------------+


//--------------------------------------------------------
// Расстановка меток. Начало.
//--------------------------------------------------------
void Metka()
  {
   int metka=0; // =0 - до первого перелома ZZ. =1 - ищем метки максимумов. =2 - ищем метки минимумов.
   for(int shift=Bars-ExtDepth; shift>=0; shift--)
     {
      if (zz[shift]>0)
        {
         if (zzH[shift]>0)
           {
            metka=2; zzL[shift]=0; shift--;
           }
         else
           {
            metka=1; zzH[shift]=0; shift--;
           }
        }

      if (metka==0)
        {
         zzH[shift]=0; zzL[shift]=0;
        }
      else if (metka==1)
        {
         if (zzH[shift]>0) metka=0;
         zzL[shift]=0;
        }
      else if (metka==2)
        {
         if (zzL[shift]>0) metka=0;
         zzH[shift]=0;
        }
     }
  }
//--------------------------------------------------------
// Расстановка меток. Конец.
//--------------------------------------------------------


