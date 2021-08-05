//**************************************************
//*  RoundNrMulti.mq4 (No Copyright)               *
//*                                                *
//*  Draws horizontal lines at round price levels  *
//*                                                *
//*  Written by: Totoro                            *
//**************************************************

#property indicator_chart_window

extern int    Line1Space     = 50; // 1 unit = 0.01 of basic value (e.g. 1 USD cent)
extern color  Line1Color     = DeepPink;
extern int    Line1Style     = 2;
extern string LineStyleInfo  = "0=Solid,1=Dash,2=Dot,3=DashDot,4=DashDotDot";
extern string LineText      = "RoundNr ";

double Hoch;
double Tief;
bool FirstRun = true;

int deinit()
{
   double Oben    = MathRound(110*Hoch)/100;
   double Unten   = MathRound(80*Tief)/100;
 
   double AbSpace = 0.01*Line1Space;   
   for(double i=0; i<=Oben; i+=AbSpace)
   {
      if(i<Unten) continue;
      ObjectDelete(LineText+DoubleToStr(i,2));
   }
   
   return(0);
}

int start()
{
   if(FirstRun)
   {
      Hoch = NormalizeDouble( High[iHighest(NULL,0,MODE_HIGH,Bars-1,0)], 2 );
      Tief = NormalizeDouble( Low[iLowest(NULL,0,MODE_LOW,Bars-1,0)], 2 );
      FirstRun = false;
   }
   DrawLines();
   return(0);
}

void DrawLines()
{
   double Oben    = MathRound(110*Hoch)/100;
   double Unten   = MathRound(80*Tief)/100;

   double AbSpace = 0.01*Line1Space;
   for(double i=0; i<=Oben; i+=AbSpace)
   {
      if(i<Unten) continue;
      
      string StringNr1 = DoubleToStr(i,2); // 2 digits number in object name
      
      if (ObjectFind(LineText+StringNr1) != 0) // HLine not in main chartwindow
      {                     
         ObjectCreate(LineText+StringNr1, OBJ_HLINE, 0, 0, i);
         ObjectSet(LineText+StringNr1, OBJPROP_STYLE, Line1Style);
         ObjectSet(LineText+StringNr1, OBJPROP_COLOR, Line1Color);
      }
      else
      {
         ObjectSet(LineText+StringNr1, OBJPROP_STYLE, Line1Style);
         ObjectSet(LineText+StringNr1, OBJPROP_COLOR, Line1Color);
      }
   }



   WindowRedraw();
}