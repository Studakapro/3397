//+------------------------------------------------------------------+
//|                                               HighLight_Pins.mq4 |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_color1 clrSilver
#property indicator_color2 clrSilver
extern bool    TopOnly = true;
extern int    Диапазон = 5;
extern int           z = 34;
extern double      pin = 2;
extern color     Color = clrYellow;
extern int       Width = 6;
extern int ГлубинаИстории = 100;
double ExtMapBuffer1[], ExtMapBuffer2[], zz;
int key;
//+------------------------------------------------------------------+
int init()  {
   SetIndexBuffer(0,ExtMapBuffer1);   SetIndexStyle(0,DRAW_HISTOGRAM,STYLE_SOLID,Width,Color);
   SetIndexBuffer(1,ExtMapBuffer2);   SetIndexStyle(1,DRAW_HISTOGRAM,STYLE_SOLID,Width,Color);
   return(0);
}
//+------------------------------------------------------------------+
int deinit()  {   return(0);  }
//+------------------------------------------------------------------+
int start()  {
   if(key==Time[0]) return(0);
   for(int i=ГлубинаИстории; i>=1; i--)  {
     ExtMapBuffer1[i] = 0;
     ExtMapBuffer2[i] = 0;
     if( FindPin(i) )  {
       ExtMapBuffer1[i]=High[i];
       ExtMapBuffer2[i]=Low[i];
       if(i<2) Alert(Symbol(),"   ",_Period,"   Пин - Бар !!!!");
     }
   }
   key=Time[0];
   return(0);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool FindPin(int k)  {
  double  PinLevel, high_0, high_1, high_2, high_3, low_0, low_1, low_2, low_3, open_0, open_1, open_2, close_0, close_1, close_2;
  double bar_length;
  int time, t;
  //+------------------------------------------------------------------+
  high_0=High[k-1];
  high_1=High[k];
  high_2=High[k+1];
  high_3=High[k+2];
  low_0  =Low[k-1];
  low_1  =Low[k];
  low_2  =Low[k+1];
  low_3  =Low[k+2];
  time   =Time[k-1];
  open_0 =Open[k-1]; 
  open_1 =Open[k];
  open_2 =Open[k+1];
  close_0=Close[k-1]; 
  close_1=Close[k];
  close_2=Close[k+1];
//+------------------------------------------------------------------+
  bar_length=high_1-low_1;
  PinLevel=NormalizeDouble(low_1+bar_length/pin, Digits);
  if(high_1>high_2 && open_1<PinLevel && close_1<PinLevel && open_0<high_1) { 
    if(TopOnly)  {
      zz=iCustom(NULL,0,"ZigZag",z,1,1,0,k);
      if(zz>0 && zz==high_1) return(true);
    }
    else  {
      for(t=k; t<=k+Диапазон; t++)  {
        zz=iCustom(NULL,0,"ZigZag",z,1,1,0,t);
        if(zz>0 && zz>=high_1) return(true);
  } } }
/*
*/  
  PinLevel=NormalizeDouble(high_1-bar_length/pin, Digits);
  if(low_1<low_2 && open_1>PinLevel && close_1>PinLevel && open_0>low_1)   { 
    if(TopOnly)  {
      zz=iCustom(NULL,0,"ZigZag",z,1,1,0,k);
      if(zz>0 && zz==low_1) return(true);
    }
    else  {
      for( t=k; t<=k+Диапазон; t++)  {
        zz=iCustom(NULL,0,"ZigZag",z,1,1,0,t);
        if(zz>0 && zz<=low_1) return(true);
  } } }
  return(0);
}
//+------------------------------------------------------------------+
