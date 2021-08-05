
// +----------------------------------------------------------------------------------------+ //
// |                                          XARD SEMA4X  \¦/                              | //
// |                            Knowledge of the ancients (ò ó)                             | //
// |_________________________________________________o0o___(_)___o0o________________________| //
// |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|____|_____| //
// |                                                                                XARD777 | //
// |----------------------------------------------------------------------------------------| //
// | Programming language:     MQL4                                                         | //
// | Development platform:     MetaTrader 4                                                 | //
// |          End product:     Indicator for MetaTrader 4 designed                          | //
// |                           for Build 226 (current version)                              | //
// +----------------------------------------------------------------------------------------+ //

#property indicator_chart_window 
#property indicator_buffers 8
#property indicator_color1 Red
#property indicator_color2 Red
#property indicator_color3 Lime
#property indicator_color4 Lime
#property indicator_color5 White
#property indicator_color6 White
#property indicator_color7 DodgerBlue
#property indicator_color8 DodgerBlue
 
#property indicator_width1 4
#property indicator_width2 4
#property indicator_width3 4
#property indicator_width4 4
#property indicator_width5 4
#property indicator_width6 4
#property indicator_width7 4
#property indicator_width8 4
                              //Mapping the Forex Market...Periods set by Xard777
extern double Period1=60;     //Base = 12 Period1 = Base X 5
extern double Period2=96;     //Base = 12 Period2 = Base X 8
extern double Period3=156;    //Base = 12 Period3 = Base X 13
extern double Period4=252;    //Base = 12 Period4 = Base X 21
 
string   Dev_Step_1="1,1";
string   Dev_Step_2="1,1";
string   Dev_Step_3="1,1";
string   Dev_Step_4="1,1";

int Symbol_1_Kod=164;
int Symbol_2_Kod=164;
int Symbol_3_Kod=164;
int Symbol_4_Kod=164;
 
extern string _____           ="";
extern bool   Box.Alerts      = false ;
extern bool   Email.Alerts    = false ;
extern bool   Sound.Alerts    = false ;

extern bool   Alert.Lv1    = false ;
extern bool   Alert.Lv2    = false ;
extern bool   Alert.Lv3    = false ;
extern bool   Alert.Lv4    = false ;

string Alert.Lv1.High.SoundFile       =  "pirate.wav";
string Alert.Lv1.Low.SoundFile        =  "pirate.wav";
string Alert.Lv2.High.SoundFile       =  "pirate.wav";
string Alert.Lv2.Low.SoundFile        =  "pirate.wav";
string Alert.Lv3.High.SoundFile       =  "pirate.wav";
string Alert.Lv3.Low.SoundFile        =  "pirate.wav";
string Alert.Lv4.High.SoundFile       =  "pirate.wav";
string Alert.Lv4.Low.SoundFile        =  "pirate.wav";
 
double FP_BuferUp[];
double FP_BuferDn[]; 
double NP_BuferUp[];
double NP_BuferDn[]; 
double HP_BuferUp[];
double HP_BuferDn[];
double XP_BuferUp[];
double XP_BuferDn[];

int F_Period;
int N_Period;
int H_Period;
int X_Period;

int Dev1;
int Stp1;
int Dev2;
int Stp2;
int Dev3;
int Stp3;
int Dev4;
int Stp4;
 
string symbol, tChartPeriod,  tShortName ;  
int    digits, period  ; 

bool Trigger1,  Trigger2,  Trigger3,  Trigger4 ;

int OldBars = -1 ;

color tColor = Yellow ;
 
int init() 
  { 
  
   period       = Period() ;     
   tChartPeriod =  TimeFrameToString(period) ;
   symbol       =  Symbol() ;
   digits       =  Digits ;   

   tShortName = "tbb"+ symbol + tChartPeriod  ;
       
   if (Period1>0) F_Period=MathCeil(Period1*Period()); else F_Period=0; 
   if (Period2>0) N_Period=MathCeil(Period2*Period()); else N_Period=0; 
   if (Period3>0) H_Period=MathCeil(Period3*Period()); else H_Period=0;
   if (Period4>0) X_Period=MathCeil(Period4*Period()); else X_Period=0; 
    
   if (Period1>0)
   {
   SetIndexStyle(0,DRAW_ARROW); 
   SetIndexArrow(0,Symbol_1_Kod); 
   SetIndexBuffer(0,FP_BuferUp); 
   SetIndexEmptyValue(0,0.0); 
   
   SetIndexStyle(1,DRAW_ARROW); 
   SetIndexArrow(1,Symbol_1_Kod); 
   SetIndexBuffer(1,FP_BuferDn); 
   SetIndexEmptyValue(1,0.0); 
   }
    
   if (Period2>0)
   {
   SetIndexStyle(2,DRAW_ARROW); 
   SetIndexArrow(2,Symbol_2_Kod); 
   SetIndexBuffer(2,NP_BuferUp); 
   SetIndexEmptyValue(2,0.0); 
   
   SetIndexStyle(3,DRAW_ARROW); 
   SetIndexArrow(3,Symbol_2_Kod); 
   SetIndexBuffer(3,NP_BuferDn); 
   SetIndexEmptyValue(3,0.0); 
   }

   if (Period3>0)
   {
   SetIndexStyle(4,DRAW_ARROW); 
   SetIndexArrow(4,Symbol_3_Kod); 
   SetIndexBuffer(4,HP_BuferUp); 
   SetIndexEmptyValue(4,0.0); 

   SetIndexStyle(5,DRAW_ARROW); 
   SetIndexArrow(5,Symbol_3_Kod); 
   SetIndexBuffer(5,HP_BuferDn); 
   SetIndexEmptyValue(5,0.0); 
   }
   
   if (Period4>0)
   {
   SetIndexStyle(6,DRAW_ARROW); 
   SetIndexArrow(6,Symbol_4_Kod); 
   SetIndexBuffer(6,XP_BuferUp); 
   SetIndexEmptyValue(6,0.0); 

   SetIndexStyle(7,DRAW_ARROW); 
   SetIndexArrow(7,Symbol_4_Kod); 
   SetIndexBuffer(7,XP_BuferDn); 
   SetIndexEmptyValue(7,0.0); 
   }

   int CDev=0;
   int CSt=0;
   int Mass[]; 
   int C=0;  
   if (IntFromStr(Dev_Step_1,C, Mass)==1) 
      {
        Stp1=Mass[1];
        Dev1=Mass[0];
      }
   
   if (IntFromStr(Dev_Step_2,C, Mass)==1)
      {
        Stp2=Mass[1];
        Dev2=Mass[0];
      }      
      
   if (IntFromStr(Dev_Step_3,C, Mass)==1)
      {
        Stp3=Mass[1];
        Dev3=Mass[0];
      }
      
   if (IntFromStr(Dev_Step_4,C, Mass)==1)
      {
        Stp4=Mass[1];
        Dev4=Mass[0];
      }
          
   return(0); 
  } 
 
int deinit() 
  { 
  
   return(0); 
  } 
 
int start() 
  { 
   
   if( Bars != OldBars ) { Trigger1 = True ; Trigger2 = True ; Trigger3 = True ; Trigger4 = True ;}
        
   if (Period1>0) CountZZ(FP_BuferUp,FP_BuferDn,Period1,Dev1,Stp1);
   if (Period2>0) CountZZ(NP_BuferUp,NP_BuferDn,Period2,Dev2,Stp2);
   if (Period3>0) CountZZ(HP_BuferUp,HP_BuferDn,Period3,Dev3,Stp3);
   if (Period4>0) CountZZ(XP_BuferUp,XP_BuferDn,Period4,Dev4,Stp4);
       
   string alert.level;   string alert.message;
   
   alert.message = symbol+"  "+ tChartPeriod+ " at "+ DoubleToStr(Close[0] ,digits);

      if ( Trigger1 &&  Alert.Lv1 ) 
      {
        if( FP_BuferUp[0] != 0 ) {  Trigger1 = False ; alert.level =" ZZS: Level 1 Low;  "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv1.Low.SoundFile); 
                                   }

        if( FP_BuferDn[0] != 0 ) {  Trigger1 = False ; alert.level =" ZZS: Level 1 High; ";
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv1.High.SoundFile);
                                   }
      }
      
      if ( Trigger2 &&  Alert.Lv2 ) 
      {
        if( NP_BuferUp[0] != 0 ) {  Trigger2 = False ; alert.level =" ZZS: Level 2 Low;  "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv2.Low.SoundFile); 
                                   }

        if( NP_BuferDn[0] != 0 ) {  Trigger2 = False ; alert.level =" ZZS: Level 2 High; "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv2.High.SoundFile);
                                   }
      }

      if ( Trigger3 &&  Alert.Lv3 ) 
      {     
        if( HP_BuferUp[0] != 0 ) {  Trigger3 = False ; alert.level =" ZZS: Level 3 Low;  "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv3.Low.SoundFile); 
                                    }

        if( HP_BuferDn[0] != 0 ) {  Trigger3 = False ; alert.level =" ZZS: Level 3 High; "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv3.High.SoundFile);
                                   }
      }
      
      if ( Trigger4 &&  Alert.Lv4 ) 
      {     
        if( XP_BuferUp[0] != 0 ) {  Trigger4 = False ; alert.level =" ZZS: Level 4 Low;  "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv4.Low.SoundFile); 
                                    }

        if( XP_BuferDn[0] != 0 ) {  Trigger4 = False ; alert.level =" ZZS: Level 4 High; "; 
                                    if(Box.Alerts)    Alert(alert.level,alert.message); 
                                    if(Email.Alerts)  SendMail(alert.level,alert.message);
                                    if(Sound.Alerts)  PlaySound(Alert.Lv4.High.SoundFile);
                                   }
      }

   OldBars = Bars ;   
 
   return(0);
}
  
string TimeFrameToString(int tf)
{
   string tfs;
   switch(tf) {
      case PERIOD_M1:  tfs="M1"  ; break;
      case PERIOD_M5:  tfs="M5"  ; break;
      case PERIOD_M15: tfs="M15" ; break;
      case PERIOD_M30: tfs="M30" ; break;
      case PERIOD_H1:  tfs="H1"  ; break;
      case PERIOD_H4:  tfs="H4"  ; break;
      case PERIOD_D1:  tfs="D1"  ; break;
      case PERIOD_W1:  tfs="W1"  ; break;
      case PERIOD_MN1: tfs="MN";
   }
   return(tfs);
}
 
int CountZZ( double& ExtMapBuffer[], double& ExtMapBuffer2[], int ExtDepth, int ExtDeviation, int ExtBackstep )
  {
   int    shift, back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;

   for(shift=Bars-ExtDepth; shift>=0; shift--)
     {
      val=Low[Lowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      if(val==lastlow) val=0.0;
      else 
        { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=ExtMapBuffer[shift+back];
               if((res!=0)&&(res>val)) ExtMapBuffer[shift+back]=0.0; 
              }
           }
        } 
        
          ExtMapBuffer[shift]=val;

      val=High[Highest(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(val==lasthigh) val=0.0;
      else 
        {
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=ExtMapBuffer2[shift+back];
               if((res!=0)&&(res<val)) ExtMapBuffer2[shift+back]=0.0; 
              } 
           }
        }
      ExtMapBuffer2[shift]=val;
     }
 
   lasthigh=-1; lasthighpos=-1;
   lastlow=-1;  lastlowpos=-1;

   for(shift=Bars-ExtDepth; shift>=0; shift--)
     {
      curlow=ExtMapBuffer[shift];
      curhigh=ExtMapBuffer2[shift];
      if((curlow==0)&&(curhigh==0)) continue;

      if(curhigh!=0)
        {
         if(lasthigh>0) 
           {
            if(lasthigh<curhigh) ExtMapBuffer2[lasthighpos]=0;
            else ExtMapBuffer2[shift]=0;
           }

         if(lasthigh<curhigh || lasthigh<0)
           {
            lasthigh=curhigh;
            lasthighpos=shift;
           }
         lastlow=-1;
        }

      if(curlow!=0)
        {
         if(lastlow>0)
           {
            if(lastlow>curlow) ExtMapBuffer[lastlowpos]=0;
            else ExtMapBuffer[shift]=0;
           }

         if((curlow<lastlow)||(lastlow<0))
           {
            lastlow=curlow;
            lastlowpos=shift;
           } 
         lasthigh=-1;
        }
     }
  
   for(shift=Bars-1; shift>=0; shift--)
     {
      if(shift>=Bars-ExtDepth) ExtMapBuffer[shift]=0.0;
      else
        {
         res=ExtMapBuffer2[shift];
         if(res!=0.0) ExtMapBuffer2[shift]=res;
        }
     }
 }
   
int Str2Massive(string VStr, int& M_Count, int& VMass[])
  {
    int val=StrToInteger( VStr);
    if (val>0)
       {
         M_Count++;
         int mc=ArrayResize(VMass,M_Count);
         if (mc==0)return(-1);
          VMass[M_Count-1]=val;
         return(1);
       }
    else return(0);    
  } 
     
int IntFromStr(string ValStr,int& M_Count, int& VMass[])
  {
    
    if (StringLen(ValStr)==0) return(-1);
    string SS=ValStr;
    int NP=0; 
    string CS;
    M_Count=0;
    ArrayResize(VMass,M_Count);
    while (StringLen(SS)>0)
      {
            NP=StringFind(SS,",");
            if (NP>0)
               {
                 CS=StringSubstr(SS,0,NP);
                 SS=StringSubstr(SS,NP+1,StringLen(SS));  
               }
               else
               {
                 if (StringLen(SS)>0)
                    {
                      CS=SS;
                      SS="";
                    }
               }
            if (Str2Massive(CS,M_Count,VMass)==0) 
               {
                 return(-2);
               }
      }
    return(1);    
  }
  // ------------------------------------------------------------------------------------------ //
//                                     E N D   P R O G R A M                                  //
// ------------------------------------------------------------------------------------------ //
/*
                                                            
                                                          
                              ud$$$**$$$$$$$bc.                          
                          u@**"        4$$$$$$$Nu                       
                        J                ""#$$$$$$r                     
                       @                       $$$$b                    
                     .F                        ^*3$$$                   
                    :% 4                         J$$$N                  
                    $  :F                       :$$$$$                  
                   4F  9                       J$$$$$$$                 
                   4$   k             4$$$$bed$$$$$$$$$                 
                   $$r  'F            $$$$$$$$$$$$$$$$$r                
                   $$$   b.           $$$$$$$$$$$$$$$$$N                
                   $$$$$k 3eeed$$b    XARD777."$$$$$$$$$                
    .@$**N.        $$$$$" $$$$$$F'L $$$$$$$$$$$  $$$$$$$                
    :$$L  'L       $$$$$ 4$$$$$$  * $$$$$$$$$$F  $$$$$$F         edNc   
   @$$$$N  ^k      $$$$$  3$$$$*%   $F4$$$$$$$   $$$$$"        d"  z$N  
   $$$$$$   ^k     '$$$"   #$$$F   .$  $$$$$c.u@$$$          J"  @$$$$r 
   $$$$$$$b   *u    ^$L            $$  $$$$$$$$$$$$u@       $$  d$$$$$$ 
    ^$$$$$$.    "NL   "N. z@*     $$$  $$$$$$$$$$$$$P      $P  d$$$$$$$ 
       ^"*$$$$b   '*L   9$E      4$$$  d$$$$$$$$$$$"     d*   J$$$$$r   
            ^$$$$u  '$.  $$$L     "#" d$$$$$$".@$$    .@$"  z$$$$*"     
              ^$$$$. ^$N.3$$$       4u$$$$$$$ 4$$$  u$*" z$$$"          
                '*$$$$$$$$ *$b      J$$$$$$$b u$$P $"  d$$P             
                   #$$$$$$ 4$ 3*$"$*$ $"$'c@@$$$$ .u@$$$P               
                     "$$$$  ""F~$ $uNr$$$^&J$$$$F $$$$#                 
                       "$$    "$$$bd$.$W$$$$$$$$F $$"                   
                         ?k         ?$$$$$$$$$$$F'*                     
                          9$$bL     z$$$$$$$$$$$F                       
                           $$$$    $$$$$$$$$$$$$                        
                            '#$$c  '$$$$$$$$$"                          
                             .@"#$$$$$$$$$$$$b                          
                           z*      $$$$$$$$$$$$N.                       
                         e"      z$$"  #$$$k  '*$$.                     
                     .u*      u@$P"      '#$$c   "$$c                   
              u@$*"""       d$$"            "$$$u  ^*$$b.               
            :$F           J$P"                ^$$$c   '"$$$$$$bL        
           d$$  ..      @$#                      #$$b         '#$       
           9$$$$$$b   4$$                          ^$$k         '$      
            "$$6""$b u$$                             '$    d$$$$$P      
              '$F $$$$$"                              ^b  ^$$$$b$       
               '$W$$$$"                                'b@$$$$"         
                                                        ^$$$*  
*/                     