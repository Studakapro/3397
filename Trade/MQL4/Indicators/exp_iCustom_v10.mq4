#property copyright "http://dmffx.com"
#property link      "http://dmffx.com"

/*
   ????? ? v10:

   ????? 6 ??? _O_Mode ? _C_Mode - ????? ????? ? ???????????? ????? 0 ? ??????????? ? ????????? ????. ? ???????? ??????? ???
   ????? ????????? ?? ???????? ????? 5, ????? ??????????? ????? 6.
*/


extern int        TimeFrame                  = 0;        // ??????? ????????? ????????: 0 - ????????? ??????? ?? ??????? ???????? ??????? ??? ??????? ?????? ? ???????. ??? ?????????? ???????? 1,5,15,30,60,240,1440...
extern bool       Buy                        = true;     // ????????? ?????? buy
extern bool       Sell                       = true;     // ????????? ?????? sell  
extern string     Order_Comment              = "";       // ??????????? ??????, ????? ???? ????? ????? ??????? ?????? ???? ?????? ??? ?????? ?? ?????? ?????????????
extern string     s0                         = "==== ????????? ??? ???????? (Mode: 1 - ???????, 2 - ??????? ? ??????????, 3 - ????? ? ??????, 4 - ?????????, 5 - ????? ????? ??? ???????? ?????? 0, 6 - ????? ????? ????? ????) ====";
extern int        _O_Mode                    = 1;        // 1-????????? ?????? ???????, ???????? ?? ????????, 2-? ?????????? ??????? ? ?????????? ?????, ???????? ??? ??????????? ?????, 3-???????????? ???? ????? ? ?? ??????????? ? ????????, 4-?????????, 5-????? ?????
extern string     _O_iCustomName             = "??????? ??? ??????????"; // ??? Custom ??????????
extern string     _O_iCustomParam            = "??????? ?????? ?????????? ????? ??????????? /"; // ?????? ?????????? ????? ??????????? "/". ??? ?????????? ???? bool ?????? ???????? true ???????????? 1, ?????? false - 0. ???? ? ?????????? ?????????? ???? ????????? ??????????, ??????? ???????? ?? ?????!!!
extern int        _O_M1_iBuyBufIndex         = 0;        // ?????? ?????? ?? ????????? ?? ???????
extern int        _O_M1_iSellBufIndex        = 1;        // ?????? ?????? ?? ????????? ?? ???????
extern int        _O_M2_iMainBufIndex        = 0;        // ?????? ?????? ??????? ?????
extern int        _O_M2_iSignalBufIndex      = 1;        // ?????? ?????? ?????????? ?????
extern int        _O_M3_iBufIndex            = 0;        // ?????? ?????? ?????
extern double     _O_M3_BuyLevel             = 20;       // ??????? ??????? (??????????? ????? ?????)
extern double     _O_M3_SellLevel            = 80;       // ??????? ??????? (??????????? ?????? ????)
extern int        _O_M4_iBufIndex            = 0;        // ?????? ?????? ?????
extern int        _O_M5_iBuyBufIndex         = 0;        // ?????? ?????? ????? ???????????? ??? ?????? ?????
extern int        _O_M5_iSellBufIndex        = 1;        // ?????? ?????? ????? ???????????? ??? ?????? ????
extern int        _O_iShift                  = 1;        // ????? ??????????. 1 - ?? ?????????????? ?????, 0 - ?? ????????????? ???? (?? ?????????????). ????? ????? ???? ?????? ???????? 2,3,4...
extern bool       _O_Opt_1_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 1. ??? ????????? ?????????????? ?????????? ?????? ???????? ?? ?????? iCustomParam, ????????????? ?????????? Opt_X_Index ????? ?????????????? ???????? ?????????? Opt_X_Value
extern int        _O_Opt_1_Index             = 0;        // ?????? ?????????????? ?????????? 1 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _O_Opt_1_Value             = 0;        // ???????? ?????????????? ?????????? 1
extern bool       _O_Opt_2_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 2
extern int        _O_Opt_2_Index             = 0;        // ?????? ?????????????? ?????????? 2 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _O_Opt_2_Value             = 0;        // ???????? ?????????????? ?????????? 2
extern bool       _O_Opt_3_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 3
extern int        _O_Opt_3_Index             = 0;        // ?????? ?????????????? ?????????? 3 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _O_Opt_3_Value             = 0;        // ???????? ?????????????? ?????????? 3
extern bool       _O_Opt_4_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 4
extern int        _O_Opt_4_Index             = 0;        // ?????? ?????????????? ?????????? 4 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _O_Opt_4_Value             = 0;        // ???????? ?????????????? ?????????? 4
extern bool       _O_Opt_5_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 5
extern int        _O_Opt_5_Index             = 0;        // ?????? ?????????????? ?????????? 5 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _O_Opt_5_Value             = 0;        // ???????? ?????????????? ?????????? 5
extern string     s1                         = "==== == (_O?_Mode: 1 - ?? sl ? tp, 2 - ????????, 3 - _?_...) == ====";
extern int        _O?_Mode                   = 1;        // 1-???????? ?? ???????? ? ??????????, 2-????? ????????? ??????????? ??????????????? ?????? ?? ???????? ???????? ?????????? _O_, 3-???????????? ??????? ???????? ?????????? _C_
extern string     s2                         = "==== ????????? ??? ???????? (Mode: 1 - ???????, 2 - ??????? ? ??????????, 3 ????? ? ??????, 4 ?????????, 5 - ????? ????? ??? ???????? ?????? 0, 6 - ????? ????? ????? ????) ====";
extern int        _C_Mode                    = 1;        // 1-????????? ?????? ???????, ???????? ?? ????????, 2-? ?????????? ??????? ? ?????????? ?????, ???????? ??? ??????????? ?????, 3-???????????? ???? ????? ? ?? ??????????? ? ????????, 4-?????????, 5-????? ?????
extern bool       _C_UseOpenParam            = false;    // ?????????? ??? ????????? ? ?????????? ???????? (????? ? ??? ??????????). ??????? ?? ?????? ????????????? ?????????? ?? ????????? ???????? ? ????????? ????????, ? ????? ??????????? ?????????? ?????????? _C_UseOpenParam=true ? ??????? ?????? ??????? _C_M1_..., _C_M2_..., _C_M3_... ? ?????????? ????? _C_Mode (???????? ?? ???????? ???????????? ???????, ? ?? ???????? ??????????? ?????)
extern string     _C_iCustomName             = "??????? ??? ??????????"; // ??? Custom ??????????
extern string     _C_iCustomParam            = "??????? ?????? ?????????? ????? ??????????? /"; // ?????? ?????????? ????? ??????????? "/". ??? ?????????? ???? bool ?????? ???????? true ???????????? 1, ?????? false - 0. ???? ? ?????????? ?????????? ??? ????????? ??????????, ??????? ???????? ?? ?????!!!
extern int        _C_M1_iCloseBuyBufIndex    = 0;        // ?????? ?????? ?? ????????? ?? ???????
extern int        _C_M1_iCloseSellBufIndex   = 1;        // ?????? ?????? ?? ????????? ?? ???????
extern int        _C_M2_iMainBufIndex        = 0;        // ?????? ?????? ??????? ?????
extern int        _C_M2_iSignalBufIndex      = 1;        // ?????? ?????? ?????????? ?????
extern int        _C_M3_iBufIndex            = 0;        // ?????? ?????? ?????
extern double     _C_M3_CloseBuyLevel        = 80;       // ??????? ???????? ??????? (??????????? ?????? ????)
extern double     _C_M3_CloseSellLevel       = 20;       // ??????? ???????? ??????? (??????????? ????? ?????)
extern int        _C_M4_iBufIndex            = 0;        // ?????? ?????? ?????
extern int        _C_M5_iBuyBufIndex         = 0;        // ?????? ?????? ????? ???????????? ??? ?????? ?????
extern int        _C_M5_iSellBufIndex        = 1;        // ?????? ?????? ????? ???????????? ??? ?????? ????
extern int        _C_iShift                  = 1;        // ????? ??????????. 1 - ?? ?????????????? ?????, 0 - ?? ????????????? ???? (?? ?????????????). ????? ????? ???? ?????? ???????? 2,3,4...
extern bool       _C_Opt_1_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 1. ??? ????????? ?????????????? ?????????? ?????? ???????? ?? ?????? iCustomParam, ????????????? ?????????? Opt_X_Index ????? ?????????????? ???????? ?????????? Opt_X_Value
extern int        _C_Opt_1_Index             = 0;        // ?????? ?????????????? ?????????? 1 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _C_Opt_1_Value             = 0;        // ???????? ?????????????? ?????????? 1
extern bool       _C_Opt_2_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 2
extern int        _C_Opt_2_Index             = 0;        // ?????? ?????????????? ?????????? 2 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _C_Opt_2_Value             = 0;        // ???????? ?????????????? ?????????? 2
extern bool       _C_Opt_3_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 3
extern int        _C_Opt_3_Index             = 0;        // ?????? ?????????????? ?????????? 3 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _C_Opt_3_Value             = 0;        // ???????? ?????????????? ?????????? 3
extern bool       _C_Opt_4_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 4
extern int        _C_Opt_4_Index             = 0;        // ?????? ?????????????? ?????????? 4 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _C_Opt_4_Value             = 0;        // ???????? ?????????????? ?????????? 4
extern bool       _C_Opt_5_Use               = false;    // ????????? ????????????? ?????????????? ?????????? 5
extern int        _C_Opt_5_Index             = 0;        // ?????? ?????????????? ?????????? 5 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _C_Opt_5_Value             = 0;        // ???????? ?????????????? ?????????? 5
extern string     s22                        = "==== ?????????????? ??????? ???????? ====";
extern bool       CheckProfit                = false;    // ????????? ??????? ?????? ??? ????????, ?????? ? ??????, ??? MinimalProfit ???????? ?? ???????????
extern int        MinimalProfit              = 0;        // ??. ?????????? CheckProfit
extern bool       CheckSL                    = false;    // ???? ???????? ?????? ????????? ??????? ?? ?????? ??? MinimalSLProfit, ????? ?? ???????????
extern int        MinimalSLProfit            = 0;        // ??. ?????????? CheckSL
extern string     s3                         = "=== ??????????? ??????? ???? ===";
extern int        MMMethod                   = 0;        // ????? ??: 0-Lots, 1-????? (Risk) ?? ????????? ???????, 2-????? (Risk) ?? ????????? ??????? ????????????? ?? ???????? MeansStep (???????? Risk=0.1, MeansStep=1000, ???? ??????? ?????? 2000, ??? ????? 0.1, ???? ??????? ????? 2000 ??? ????? - 0.2 ????, 3000 ? ????? - 0.3 ???? ? ?.?. )
extern double     Lots                       = 0.1;      // ?????????? ????? ??? MMMethod=0
extern double     Risk                       = 0.1;      // ????. ???????? ?? ??????? ??? FixedLot=false
extern int        MeansType                  = 3;        // ??? ??????? ???????????? ??? ??????? ??????? ????. 1 - Balance, 2 - Equity, 3 - FreeMargin
extern double     MeansStep                  = 1000;     // ??? ???????. ???????????? ??? MMMethod=2
extern int        LotsDigits                 = 1;        // ?????????? ?????? ????? ??????? ? ??????? ????
extern string     s4                         = "=== ????? (OrdType: 0-Market, 1-Stop, 2-Limit) ===";
extern int        OrdType                    = 0;        // ??? ???????: 0 - ????????, 1 - ????, 2 - ?????. ??? ????? 1 ? 2 ??. ??????????
extern int        Slippage                   = 3;        // ?????????? ?????????? ?? ??????????? ????
extern double     StopLoss                   = 25;       // ????????
extern double     TakeProfit                 = 25;       // ??????????
extern int        SleepBars                  = 1;        // ??????? ????? ???????? ?????? ? ?????????? ????? ???????? ??????????
extern bool       CancelSleeping             = true;     // ????????? ?????? ???????? ??? ???????? ?????? ???????????????? ???????????.
extern int        Magic_N                    = 96778;    // ?????
extern bool       MW_Mode                    = false;    // ????? ???????? ??? ????????/?????????? ? ????????? ????????/?????????? ????? ???????? ??????
extern string     s41                        = "---- ---- ?????????? ?????? (PendNewSigMode: 1-??? ?????????????, 2-??????? ?????????????, 3-????????????? ?? ?????? ???????) ---- ----";
extern double     PendLevel                  = 20;       // ??????? ????????? ??????????? ?????? ?? ?????? ???????? ????
extern int        PendPromPrice              = 1;        // ???? ????????? ??????????? ?????? ????????????? ?? ???? ???????? ????, ??? ???????? PendPromPrice=0 - ?? ???? ???????? (????????????? ??????? ???????? ????), 1 - ?? ???? ???????? ????
extern int        PendNewSigMode             = 2;        // ?????? ?????????? ?????????? ??????? ?? ?????? ????????? ???????: ??????. 0 - ???? ????? ??? ??? ??????????, ?? ??? ????????? ?????? ????????? ??????? ?? ??????????? ?? ????? ????????, 1 - ????????????? ?????? ?? ?????? ???????, 2 - ?? ?????? ??????? ????? ??????????????????? ?? "?????? ???????" - ??????? ?????? ????, ???????? ?????? ?????, ???????? ?????? ?????, ???????? ?????? ????
extern bool       PendPriceFollow            = false;    // ????? ?????????? ?? ?????. ????? ?????????????? ??? ?????? ????????? ???? ???????????? ?????????? PendPromPrice, ????? ??????????????????? ?????? ?? "?????? ????" (??. ???????? ?????????? PendNewSigMode)
extern bool       PendDelete                 = true;     // ???????? ??????????? ?????? ?? ???????????????? ????????? ???????. ??? ???????? false, ???????? ????????????? ????????????? ???? ??????? ??????? ???????????
extern int        PendExpiration             = 0;        // ???? ??????????? ?????? ? ??????? (??????????? ???????? 11 ?????)
extern string     s42                        = "---- ---- ???? ???????? ??????? ---- ----";
extern int        MaxOrdersCount             = -1;       // ?????????? ????? ?????????? ???????? ???????. -1 - ?? ??????????
extern int        MaxBuyCount                = -1;       // ?????????? ?????????? ???????? ??????? buy. -1 - ?? ?????????? 
extern int        MaxSellCount               = -1;       // ?????????? ?????????? ???????? ??????? sell. -1 - ?? ??????????
extern string     s5                         = "=== ???????? ===";
extern bool       TrailingStop_Use           = false;    // ????????? ??????? ?????????????
extern double     TrailingStopStart          = 50;       // ??????? ?????? ??? ??????? ???????? ???????? ????????????
extern double     TrailingStop               = 15;       // ??????? ?????????????
extern string     s6                         = "=== ????????? ===";
extern bool       BreakEven_Use              = false;    // ????????? ??????? ?????????
extern double     BreakEvenStart             = 30;       // ??????? ?????? ??? ??????? ??????????? ?????????
extern double     BreakEvenLevel             = 15;       // ??????? ?? ??????? ??????????????? ???????? ?? ???? ???????????? ?????????
extern string     s7                         = "=== ???????? ?? ?????????? ===";
extern bool       _TS_ON                     = false;    // ????????? ????????? ?? ??????????
extern string     _TS_iCustomName            = "??????? ??? ??????????"; // ??? Custom ??????????
extern string     _TS_iCustomParam           = "??????? ?????? ?????????? ????? ??????????? /"; // ?????? ?????????? ????? ??????????? "/". ??? ?????????? ???? bool ?????? ??????? true ???????????? 1, ?????? false - 0. ???? ? ?????????? ?????????? ??? ????????? ??????????, ??????? ???????? ?? ?????!!!
extern int        _TS_iForBuyBufIndex        = 0;        // ?????? ?????? ??? ??????? buy
extern int        _TS_iForSellBufIndex       = 1;        // ?????? ?????? ??? ??????? sell
extern int        _TS_iShift                 = 1;        // ????? ??????????. 1 - ?? ?????????????? ?????, 0 - ?? ????????????? ???? (?? ?????????????). ????? ????? ???? ?????? ???????? 2,3,4...
extern bool       _TS_Opt_1_Use              = false;    // ????????? ????????????? ?????????????? ?????????? 1. ??? ????????? ?????????????? ?????????? ?????? ???????? ?? ?????? iCustomParam, ????????????? ?????????? Opt_X_Index ????? ?????????????? ???????? ?????????? Opt_X_Value
extern int        _TS_Opt_1_Index            = 0;        // ?????? ?????????????? ?????????? 1 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _TS_Opt_1_Value            = 0;        // ???????? ?????????????? ?????????? 1
extern bool       _TS_Opt_2_Use              = false;    // ????????? ????????????? ?????????????? ?????????? 2
extern int        _TS_Opt_2_Index            = 0;        // ?????? ?????????????? ?????????? 2 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _TS_Opt_2_Value            = 0;        // ???????? ?????????????? ?????????? 2
extern bool       _TS_Opt_3_Use              = false;    // ????????? ????????????? ?????????????? ?????????? 3
extern int        _TS_Opt_3_Index            = 0;        // ?????? ?????????????? ?????????? 3 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _TS_Opt_3_Value            = 0;        // ???????? ?????????????? ?????????? 3
extern bool       _TS_Opt_4_Use              = false;    // ????????? ????????????? ?????????????? ?????????? 4
extern int        _TS_Opt_4_Index            = 0;        // ?????? ?????????????? ?????????? 4 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _TS_Opt_4_Value            = 0;        // ???????? ?????????????? ?????????? 4
extern bool       _TS_Opt_5_Use              = false;    // ????????? ????????????? ?????????????? ?????????? 5
extern int        _TS_Opt_5_Index            = 0;        // ?????? ?????????????? ?????????? 5 ? ??????? ?????????? (? ?????? iCustomParam). ?????? ?????????? ? ????.
extern double     _TS_Opt_5_Value            = 0;        // ???????? ?????????????? ?????????? 5
extern double     _TS_Indent                 = 0;        // ?????? ? ??????? ?? ???????? ??????????
extern double     _TS_TrailInProfit          = 0;        // ??????????? ??????????? ???????. ???????? ?????????????? ? ??? ??????, ???? ?? ????????? ?? ????? ??? _TS_TrailInProfit ??????? ??????? 
extern   string   s8                         =  "=== ????? ===";  
extern   bool     UseTime                    =  false;   // ????????? ???????? ???????
extern   int      StartHour                  =  10;      // ??? ?????? ???????
extern   int      StartMinute                =  0;       // ?????? ?????? ???????
extern   int      EndHour                    =  14;      // ??? ????????? ???????
extern   int      EndMinute                  =  0;       // ?????? ????????? ???????
extern string     s9                         = "=== ?????? ===";
extern bool       Auto5Digits                = true;     // ?????????????? ????????? ?????????? ????????? ???????????? ? ??????? ?? 10 ?? 5-?? ? 3-?? ??????? ??????????. ?????????? ?????????: Slippage, StopLoss, TakeProfit, PendLevel, TrailingStopStart, TrailingStop, BreakEvenStart, BreakEvenLevel, _TS_Indent, _TS_TrailInProfit
extern bool       InPercents                 = false;    // ??? ????????? ????????? ???????????? ? ??????? (StopLoss, TakeProfit, PendLevel, TrailingStopStart, TrailingStop, BreakEvenStart, BreakEvenLevel, _TS_Indent, _TS_TrailInProfit) ???????? ? ????????? ?? ???????? ????. ? ???? ?????? Auto5Digits ?? ????????. ???????? Slippage ???????? ???????.

               
               
double _O_ParArr[];
double _C_ParArr[];
double _TS_ParArr[];

int LastBuyTime,LastSellTime;

string BuyComment;
string SellComment;
string BuyStopComment;
string SellStopComment;
string BuyLimitComment;
string SellLimitComment;

double x_StopLoss;
double x_TakeProfit;
double x_PendLevel;
double x_TrailingStopStart;
double x_TrailingStop;
double x_BreakEvenStart;
double x_BreakEvenLevel;
double x_TS_Indent;
double x_TS_TrailInProfit;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+

int init(){

      if(InPercents){
         x_StopLoss=StopLoss/100.0;
         x_TakeProfit=TakeProfit/100.0;
         x_PendLevel=PendLevel/100.0;
         x_TrailingStopStart=TrailingStopStart/100.0;
         x_TrailingStop=TrailingStop/100.0;
         x_BreakEvenStart=BreakEvenStart/100.0;
         x_BreakEvenLevel=BreakEvenLevel/100.0;
         x_TS_Indent=_TS_Indent/100.0;
         x_TS_TrailInProfit=_TS_TrailInProfit/100.0;
      }
      else{
         if(Auto5Digits){
            if(Digits==5 || Digits==3){
               Slippage*=10;
               StopLoss*=10;
               TakeProfit*=10;
               PendLevel*=10;
               TrailingStopStart*=10;
               TrailingStop*=10;
               BreakEvenStart*=10;
               BreakEvenLevel*=10;
               _TS_Indent*=10;
               _TS_TrailInProfit*=10;
            }
         } 
      }              

   Order_Comment=StringTrimLeft(StringTrimRight(Order_Comment));
   BuyComment="";
   SellComment="";
   BuyStopComment="";
   SellStopComment="";
   BuyLimitComment="";
   SellLimitComment="";
      if(Order_Comment!=""){
         BuyComment=Order_Comment+" BUY";
         SellComment=Order_Comment+" SELL";
         BuyStopComment=Order_Comment+" BUYSTOP";
         SellStopComment=Order_Comment+" SELLSTOP";
         BuyLimitComment=Order_Comment+" BUYLIMIT";
         SellLimitComment=Order_Comment+" SELLIMIT";
      }
      
   if(TimeFrame==0)TimeFrame=Period();

   string tmp[];
   fStrSplit(_O_iCustomParam,tmp,"/");
   fConvertColorToDouble(tmp);
   fCopyStrToDouble(tmp,_O_ParArr);

      if(_O_Opt_1_Use){
         if(_O_Opt_1_Index<ArraySize(_O_ParArr))_O_ParArr[_O_Opt_1_Index]=_O_Opt_1_Value;
      }
      if(_O_Opt_2_Use){
         if(_O_Opt_2_Index<ArraySize(_O_ParArr))_O_ParArr[_O_Opt_2_Index]=_O_Opt_2_Value;
      }
      if(_O_Opt_3_Use){
         if(_O_Opt_3_Index<ArraySize(_O_ParArr))_O_ParArr[_O_Opt_3_Index]=_O_Opt_3_Value;
      }
      if(_O_Opt_4_Use){
         if(_O_Opt_4_Index<ArraySize(_O_ParArr))_O_ParArr[_O_Opt_4_Index]=_O_Opt_4_Value;
      }
      if(_O_Opt_5_Use){
         if(_O_Opt_5_Index<ArraySize(_O_ParArr))_O_ParArr[_O_Opt_5_Index]=_O_Opt_5_Value;
      }   
      
      
      if(_O?_Mode==3){ 
         if(_C_UseOpenParam){
            ArrayResize(_C_ParArr,ArraySize(_O_ParArr));
            ArrayCopy(_C_ParArr,_O_ParArr,0,0,ArraySize(_O_ParArr));
            _C_iCustomName=_O_iCustomName;
         }
         else{
            fStrSplit(_C_iCustomParam,tmp,"/");
            fConvertColorToDouble(tmp);
            fCopyStrToDouble(tmp,_C_ParArr);            
               if(_C_Opt_1_Use){
                  if(_C_Opt_1_Index<ArraySize(_C_ParArr))_C_ParArr[_C_Opt_1_Index]=_C_Opt_1_Value;
               }
               if(_C_Opt_2_Use){
                  if(_C_Opt_2_Index<ArraySize(_C_ParArr))_C_ParArr[_C_Opt_2_Index]=_C_Opt_2_Value;
               }
               if(_C_Opt_3_Use){
                  if(_C_Opt_3_Index<ArraySize(_C_ParArr))_C_ParArr[_C_Opt_3_Index]=_C_Opt_3_Value;
               }
               if(_C_Opt_4_Use){
                  if(_C_Opt_4_Index<ArraySize(_C_ParArr))_C_ParArr[_C_Opt_4_Index]=_C_Opt_4_Value;
               }
               if(_C_Opt_5_Use){
                  if(_C_Opt_5_Index<ArraySize(_C_ParArr))_C_ParArr[_C_Opt_5_Index]=_C_Opt_5_Value;
               }
         }
      }
      
   fStrSplit(_TS_iCustomParam,tmp,"/");
   fConvertColorToDouble(tmp);
   fCopyStrToDouble(tmp,_TS_ParArr);   
      if(_TS_Opt_1_Use){
         if(_TS_Opt_1_Index<ArraySize(_TS_ParArr))_TS_ParArr[_TS_Opt_1_Index]=_TS_Opt_1_Value;
      }
      if(_TS_Opt_2_Use){
         if(_TS_Opt_2_Index<ArraySize(_TS_ParArr))_TS_ParArr[_TS_Opt_2_Index]=_TS_Opt_2_Value;
      }
      if(_TS_Opt_3_Use){
         if(_TS_Opt_3_Index<ArraySize(_TS_ParArr))_TS_ParArr[_TS_Opt_3_Index]=_TS_Opt_3_Value;
      }
      if(_TS_Opt_4_Use){
         if(_TS_Opt_4_Index<ArraySize(_TS_ParArr))_TS_ParArr[_TS_Opt_4_Index]=_TS_Opt_4_Value;
      }
      if(_TS_Opt_5_Use){
         if(_TS_Opt_5_Index<ArraySize(_TS_ParArr))_TS_ParArr[_TS_Opt_5_Index]=_TS_Opt_5_Value;
      } 
      
      if(_TS_iCustomName=="??????? ??? ??????????"){
         _TS_ON=false;             
      }

   return(0);
  }

void fConvertColorToDouble(string & aArr[]){
   for(int i=0;i<ArraySize(aArr);i++){
      aArr[i]=StringTrimLeft(StringTrimRight(aArr[i]));
         if(StringFind(aArr[i],"color:",0)==0){
            aArr[i]=StringSubstr(aArr[i],6,StringLen(aArr[i])-6);
               if(StringFind(aArr[i],",",0)!=-1){
                  string tmp[];
                  fStrSplit(aArr[i],tmp,",");
                  aArr[i]=fRGB(StrToInteger(tmp[0]),StrToInteger(tmp[1]),StrToInteger(tmp[2]));
               }
               else{
                  aArr[i]=fColFromString(aArr[i]);
               }
         }
         else if(StringFind(aArr[i],"date:",0)==0){
            aArr[i]=StringSubstr(aArr[i],5,StringLen(aArr[i])-5);
            aArr[i]=StrToTime(aArr[i]);
         }
   }
}

color fRGB(int aR,int aG, int aB){
   return(aR+256*aG+65536*aB);
}

color fColFromString(string aName){
   color tColor[]={  Black, DarkGreen, DarkSlateGray, Olive, Green, Teal, Navy, Purple, 
                     Maroon, Indigo, MidnightBlue, DarkBlue, DarkOliveGreen, SaddleBrown, 
                     ForestGreen, OliveDrab, SeaGreen, DarkGoldenrod, DarkSlateBlue, 
                     Sienna, MediumBlue, Brown, DarkTurquoise, DimGray, LightSeaGreen, 
                     DarkViolet, FireBrick, MediumVioletRed, MediumSeaGreen, Chocolate, 
                     Crimson, SteelBlue, Goldenrod, MediumSpringGreen, LawnGreen, 
                     CadetBlue, DarkOrchid, YellowGreen, LimeGreen, OrangeRed, DarkOrange, 
                     Orange, Gold, Yellow, Chartreuse, Lime, SpringGreen, Aqua, DeepSkyBlue, 
                     Blue, Magenta, Red, Gray, SlateGray, Peru, BlueViolet, LightSlateGray, 
                     DeepPink, MediumTurquoise, DodgerBlue, Turquoise, RoyalBlue, SlateBlue, 
                     DarkKhaki, IndianRed, MediumOrchid, GreenYellow, MediumAquamarine, 
                     DarkSeaGreen, Tomato, RosyBrown, Orchid, MediumPurple, PaleVioletRed, 
                     Coral, CornflowerBlue, DarkGray, SandyBrown, MediumSlateBlue, Tan, 
                     DarkSalmon, BurlyWood, HotPink, Salmon, Violet, LightCoral, SkyBlue, 
                     LightSalmon, Plum, Khaki, LightGreen, Aquamarine, Silver, LightSkyBlue, 
                     LightSteelBlue, LightBlue, PaleGreen, Thistle, PowderBlue, PaleGoldenrod, 
                     PaleTurquoise, LightGray, Wheat, NavajoWhite, Moccasin, LightPink, 
                     Gainsboro, PeachPuff, Pink, Bisque, LightGoldenrod, BlanchedAlmond, 
                     LemonChiffon, Beige, AntiqueWhite, PapayaWhip, Cornsilk, LightYellow, 
                     LightCyan, Linen, Lavender, MistyRose, OldLace, WhiteSmoke, Seashell, 
                     Ivory, Honeydew, AliceBlue, LavenderBlush, MintCream, Snow, White
                  };  
   string tName[]={   "Black", "DarkGreen", "DarkSlateGray", "Olive", "Green", "Teal", "Navy", "Purple", 
                     "Maroon", "Indigo", "MidnightBlue", "DarkBlue", "DarkOliveGreen", "SaddleBrown", 
                     "ForestGreen", "OliveDrab", "SeaGreen", "DarkGoldenrod", "DarkSlateBlue", 
                     "Sienna", "MediumBlue", "Brown", "DarkTurquoise", "DimGray", "LightSeaGreen", 
                     "DarkViolet", "FireBrick", "MediumVioletRed", "MediumSeaGreen", "Chocolate", 
                     "Crimson", "SteelBlue", "Goldenrod", "MediumSpringGreen", "LawnGreen", 
                     "CadetBlue", "DarkOrchid", "YellowGreen", "LimeGreen", "OrangeRed", "DarkOrange", 
                     "Orange", "Gold", "Yellow", "Chartreuse", "Lime", "SpringGreen", "Aqua", "DeepSkyBlue", 
                     "Blue", "Magenta", "Red", "Gray", "SlateGray", "Peru", "BlueViolet", "LightSlateGray", 
                     "DeepPink", "MediumTurquoise", "DodgerBlue", "Turquoise", "RoyalBlue", "SlateBlue", 
                     "DarkKhaki", "IndianRed", "MediumOrchid", "GreenYellow", "MediumAquamarine", 
                     "DarkSeaGreen", "Tomato", "RosyBrown", "Orchid", "MediumPurple", "PaleVioletRed", 
                     "Coral", "CornflowerBlue", "DarkGray", "SandyBrown", "MediumSlateBlue", "Tan", 
                     "DarkSalmon", "BurlyWood", "HotPink", "Salmon", "Violet", "LightCoral", "SkyBlue", 
                     "LightSalmon", "Plum", "Khaki", "LightGreen", "Aquamarine", "Silver", "LightSkyBlue", 
                     "LightSteelBlue", "LightBlue", "PaleGreen", "Thistle", "PowderBlue", "PaleGoldenrod", 
                     "PaleTurquoise", "LightGray", "Wheat", "NavajoWhite", "Moccasin", "LightPink", 
                     "Gainsboro", "PeachPuff", "Pink", "Bisque", "LightGoldenrod", "BlanchedAlmond", 
                     "LemonChiffon", "Beige", "AntiqueWhite", "PapayaWhip", "Cornsilk", "LightYellow", 
                     "LightCyan", "Linen", "Lavender", "MistyRose", "OldLace", "WhiteSmoke", "Seashell", 
                     "Ivory", "Honeydew", "AliceBlue", "LavenderBlush", "MintCream", "Snow", "White"
                  };
      aName=StringTrimLeft(StringTrimRight(aName));      
         for(int i=0;i<ArraySize(tName);i++){
            if(aName==tName[i])return(tColor[i]);
         }
      return(Red);                                     
                  
}  

void fCopyStrToDouble(string aStr[],double & aDoub[]){
   ArrayResize(aDoub,ArraySize(aStr));
      for(int i=0;i<ArraySize(aStr);i++){
         aDoub[i]=StrToDouble(aStr[i]);
      }
}

//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start(){

      if(InPercents){
         StopLoss=MathRound(Bid*x_StopLoss/Point);
         TakeProfit=MathRound(Bid*x_TakeProfit/Point);
         PendLevel=MathRound(Bid*x_PendLevel/Point);
         TrailingStopStart=MathRound(Bid*x_TrailingStopStart/Point);
         TrailingStop=MathRound(Bid*x_TrailingStop/Point);
         BreakEvenStart=MathRound(Bid*x_BreakEvenStart/Point);
         BreakEvenLevel=MathRound(Bid*x_BreakEvenLevel/Point);
         _TS_Indent=MathRound(Bid*x_TS_Indent/Point);
         _TS_TrailInProfit=MathRound(Bid*x_TS_TrailInProfit/Point);
         StopLoss=MathMax(StopLoss,MarketInfo(Symbol(),MODE_STOPLEVEL)+MarketInfo(Symbol(),MODE_SPREAD));
         TakeProfit=MathMax(TakeProfit,MarketInfo(Symbol(),MODE_STOPLEVEL));
         PendLevel=MathMax(PendLevel,MarketInfo(Symbol(),MODE_STOPLEVEL));
         TrailingStop=MathMax(TrailingStop,MarketInfo(Symbol(),MODE_STOPLEVEL));
         BreakEvenLevel=MathMax(BreakEvenLevel,MarketInfo(Symbol(),MODE_STOPLEVEL));
      }

   static bool ft=false;
   
      if(!ft){
         int CheckTypeBuy;
         int CheckTypeSell;              
            switch(OrdType){
               case 0:
                  CheckTypeBuy=OP_BUY;
                  CheckTypeSell=OP_SELL;               
               break;
               case 1:
                  CheckTypeBuy=OP_BUYSTOP;
                  CheckTypeSell=OP_SELLSTOP;                   
               break;
               case 2:
                  CheckTypeBuy=OP_BUYLIMIT;
                  CheckTypeSell=OP_SELLLIMIT;                 
               break;
            }
            for(int i=0;i<OrdersTotal();i++){
               if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
                  if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
                     if(OrderType()==CheckTypeBuy)LastBuyTime=MathMax(LastBuyTime,OrderOpenTime());
                     if(OrderType()==CheckTypeSell)LastSellTime=MathMax(LastSellTime,OrderOpenTime());                    
                  }
               }
               else{
                  return(0);
               }
            }   
            for(i=0;i<HistoryTotal();i++){
               if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)){
                  if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
                     if(OrderType()==CheckTypeBuy)LastBuyTime=MathMax(LastBuyTime,OrderOpenTime());
                     if(OrderType()==CheckTypeSell)LastSellTime=MathMax(LastSellTime,OrderOpenTime());                    
                  }
               }
               else{
                  return(0);
               }
            }  
            
            if(LastBuyTime>LastSellTime)LastSellTime=0;
            if(LastSellTime>LastBuyTime)LastBuyTime=0;
            LastBuyTime=TimeFrame*60*MathFloor(LastBuyTime/(TimeFrame*60));
            LastSellTime=TimeFrame*60*MathFloor(LastSellTime/(TimeFrame*60));
            
         ft=true;
      }
  
      if(MW_Mode){
         fMW();
      }    
  
   bool BuySignal=false;
   bool SellSignal=false;    
   
   bool TestMode=true;
   
   
      switch (_O_Mode){
         case 1:
            double buyarrow=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M1_iBuyBufIndex,_O_ParArr,_O_iShift);
            double sellarrow=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M1_iSellBufIndex,_O_ParArr,_O_iShift);
            BuySignal=(buyarrow!=EMPTY_VALUE && buyarrow!=0);
            SellSignal=(sellarrow!=EMPTY_VALUE && sellarrow!=0);
         break;
         case 2:
            double main_1=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M2_iMainBufIndex,_O_ParArr,_O_iShift);
            double signal_1=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M2_iSignalBufIndex,_O_ParArr,_O_iShift); 
            double main_2=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M2_iMainBufIndex,_O_ParArr,_O_iShift+1);
            double signal_2=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M2_iSignalBufIndex,_O_ParArr,_O_iShift+1);             
            BuySignal=(main_1>signal_1 && !(main_2>signal_2));
            SellSignal=(main_1<signal_1 && !(main_2<signal_2));               
         break;
         case 3:
            double line_1=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M3_iBufIndex,_O_ParArr,_O_iShift);
            double line_2=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M3_iBufIndex,_O_ParArr,_O_iShift+1);
            BuySignal=(line_1>_O_M3_BuyLevel && !(line_2>_O_M3_BuyLevel));
            SellSignal=(line_1<_O_M3_SellLevel && !(line_2<_O_M3_SellLevel));
         break;
         case 4:
            line_1=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M4_iBufIndex,_O_ParArr,_O_iShift);
            line_2=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M4_iBufIndex,_O_ParArr,_O_iShift+1);
            double line_3=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M3_iBufIndex,_O_ParArr,_O_iShift+2);
            BuySignal=(line_1>line_2 && line_3>line_2);
            SellSignal=(line_1<line_2 && line_3<line_2);
         break;         
         case 5:
            double upnow=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iBuyBufIndex,_O_ParArr,_O_iShift);
            double uppre=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iBuyBufIndex,_O_ParArr,_O_iShift+1);
            double dnnow=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iSellBufIndex,_O_ParArr,_O_iShift);
            double dnpre=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iSellBufIndex,_O_ParArr,_O_iShift+1);
            BuySignal=(upnow>0 && upnow!=EMPTY_VALUE && (uppre==EMPTY_VALUE || uppre<=0));
            SellSignal=(dnnow>0 && dnnow!=EMPTY_VALUE && (dnpre==EMPTY_VALUE || dnpre<=0));
         break;   
         case 6:
            upnow=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iBuyBufIndex,_O_ParArr,_O_iShift);
            uppre=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iBuyBufIndex,_O_ParArr,_O_iShift+1);
            dnnow=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iSellBufIndex,_O_ParArr,_O_iShift);
            dnpre=fGetCustomValue(TimeFrame,_O_iCustomName,_O_M5_iSellBufIndex,_O_ParArr,_O_iShift+1);
            BuySignal=(upnow>0 && upnow!=EMPTY_VALUE && (uppre==EMPTY_VALUE || uppre<=0));
            SellSignal=(dnnow<0 && dnpre>=0);
         break;            
      }
         
   
   bool CloseBuySignal=false;
   bool CloseSellSignal=false;    
   
      switch(_O?_Mode){
         case 2:
            CloseBuySignal=SellSignal;
            CloseSellSignal=BuySignal;
            break;
         case 3:
            switch (_C_Mode){
               case 1:
                  double closebuyarrow=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M1_iCloseBuyBufIndex,_C_ParArr,_C_iShift);
                  double closesellarrow=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M1_iCloseSellBufIndex,_C_ParArr,_C_iShift);
                  CloseBuySignal=(closebuyarrow!=EMPTY_VALUE && closebuyarrow!=0);
                  CloseSellSignal=(closesellarrow!=EMPTY_VALUE && closesellarrow!=0);   
               break;
               case 2:
                  main_1=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M2_iMainBufIndex,_C_ParArr,_C_iShift);
                  signal_1=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M2_iSignalBufIndex,_C_ParArr,_C_iShift); 
                  main_2=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M2_iMainBufIndex,_C_ParArr,_C_iShift+1);
                  signal_2=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M2_iSignalBufIndex,_C_ParArr,_C_iShift+1);             
                  CloseSellSignal=(main_1>signal_1 && !(main_2>signal_2));
                  CloseBuySignal=(main_1<signal_1 && !(main_2<signal_2));               
               break;
               case 3:
                  line_1=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M3_iBufIndex,_C_ParArr,_C_iShift);
                  line_2=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M3_iBufIndex,_C_ParArr,_C_iShift+1);
                  CloseSellSignal=(line_1>_C_M3_CloseSellLevel && !(line_2>_C_M3_CloseSellLevel));
                  CloseBuySignal=(line_1<_C_M3_CloseBuyLevel && !(line_2<_C_M3_CloseBuyLevel));
               break;
               case 4:
                  line_1=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M4_iBufIndex,_C_ParArr,_C_iShift);
                  line_2=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M4_iBufIndex,_C_ParArr,_C_iShift+1);
                  line_3=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M4_iBufIndex,_C_ParArr,_C_iShift+2);
                  CloseSellSignal=(line_1>line_2 && line_3>line_2);
                  CloseBuySignal=(line_1<line_2 && line_3<line_2);
               break;    
               case 5:
                  upnow=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iBuyBufIndex,_C_ParArr,_C_iShift);
                  uppre=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iBuyBufIndex,_C_ParArr,_C_iShift+1);
                  dnnow=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iSellBufIndex,_C_ParArr,_C_iShift);
                  dnpre=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iSellBufIndex,_C_ParArr,_C_iShift+1);
                  CloseBuySignal=(upnow>0 && upnow!=EMPTY_VALUE && (uppre==EMPTY_VALUE || uppre<=0));
                  CloseSellSignal=(dnnow>0 && dnnow!=EMPTY_VALUE && (dnpre==EMPTY_VALUE || dnpre<=0));
               break;  
               case 6:
                  upnow=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iBuyBufIndex,_C_ParArr,_C_iShift);
                  uppre=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iBuyBufIndex,_C_ParArr,_C_iShift+1);
                  dnnow=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iSellBufIndex,_C_ParArr,_C_iShift);
                  dnpre=fGetCustomValue(TimeFrame,_C_iCustomName,_C_M5_iSellBufIndex,_C_ParArr,_C_iShift+1);
                  CloseBuySignal=(upnow>0 && upnow!=EMPTY_VALUE && (uppre==EMPTY_VALUE || uppre<=0));
                  CloseSellSignal=(dnnow<0 && dnpre>=0);
               break;                 
            }   
      }

      if(CloseBuySignal || CloseSellSignal){
         fOrderCloseMarket(CloseBuySignal,CloseSellSignal);
      }
      
      if(BuySignal && SellSignal){
         BuySignal=false;
         SellSignal=false;
      }

      if(BuySignal || SellSignal){ 
            if(OrdType!=0){
               if(PendDelete){
                  fOrderDeletePending(SellSignal,BuySignal);
               }
            }
         int BuyCount,SellCount,BuyStopCount,SellStopCount,BuyLimitCount,SellLimitCount,BuyStopTicket,SellStopTicket,BuyLimitTicket,SellLimitTicket;
         int Total=fOrdersTotal(BuyCount,SellCount,BuyStopCount,SellStopCount,BuyLimitCount,SellLimitCount,BuyStopTicket,SellStopTicket,BuyLimitTicket,SellLimitTicket);
         if(Total==-1)return(0);
         int AllCount=BuyCount+SellCount+BuyStopCount+SellStopCount+BuyLimitCount+SellLimitCount;
         int AllBuyCount=BuyCount+BuyStopCount+BuyLimitCount;
         int AllSellCount=SellCount+SellStopCount+SellLimitCount;         
         
            
               if(Buy){
                  if(BuySignal){
                     if(!CloseBuySignal){
                        if(!SellSignal){
                           // BUY
                           switch(OrdType){
                              case 0: // Buy Market
                                 if((AllCount<MaxOrdersCount || MaxOrdersCount==-1) && fTimeInZone3s()){
                                    if(AllBuyCount<MaxBuyCount || MaxBuyCount==-1){    
                                       if(iTime(NULL,TimeFrame,0)>=LastBuyTime+TimeFrame*60*SleepBars){
                                          fOrderOpenBuy();              
                                       }
                                    }
                                 }                                 
                              break;
                              case 1: // Buy Stop   
                                 if(BuyStopCount==0){ // ?????????
                                    if((AllCount<MaxOrdersCount || MaxOrdersCount==-1) && fTimeInZone3s()){
                                       if(AllBuyCount<MaxBuyCount || MaxBuyCount==-1){                               
                                          if(iTime(NULL,TimeFrame,0)>=LastBuyTime+TimeFrame*60*SleepBars){
                                             double OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel+(Ask-Bid);
                                             datetime Expir=0;
                                             if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;
                                             fOrderSetBuyStop(OpPrice,Expir); 
                                          }
                                       }
                                    }                                          
                                 }
                                 else{ // ??????????? 
                                    if(BuyStopTicket>0){
                                       switch(PendNewSigMode){
                                          case 1: // ???????
                                             if(iTime(NULL,TimeFrame,0)>=LastBuyTime+TimeFrame*60*SleepBars){
                                                if(OrderSelect(BuyStopTicket,SELECT_BY_TICKET)){
                                                   OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel+(Ask-Bid);
                                                      if(ND(OpPrice)!=ND(OrderOpenPrice())){
                                                         Expir=0;
                                                         if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                                   
                                                         fModifyBuyStop(OrderTicket(),OpPrice,Expir); 
                                                      }
                                                }
                                             }
                                          break;
                                          case 2: // ?? ?????? ????
                                             if(OrderSelect(BuyStopTicket,SELECT_BY_TICKET)){
                                                OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel+(Ask-Bid);
                                                   if(ND(OpPrice)<ND(OrderOpenPrice())){
                                                      Expir=0;
                                                      if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60; 
                                                      fModifyBuyStop(OrderTicket(),OpPrice,Expir); 
                                                   }
                                             }
                                          break;
                                       }
                                    }
                                 }                              
                              break;
                              case 2:// Buy Limit
                                 if(BuyLimitCount==0){ // ?????????
                                    if((AllCount<MaxOrdersCount || MaxOrdersCount==-1) && fTimeInZone3s()){
                                       if(AllBuyCount<MaxBuyCount || MaxBuyCount==-1){                                  
                                          if(iTime(NULL,TimeFrame,0)>=LastBuyTime+TimeFrame*60*SleepBars){
                                             OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel+(Ask-Bid);
                                             Expir=0;
                                             if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                     
                                             fOrderSetBuyLimit(OpPrice,Expir);
                                          }
                                       }
                                    }                                          
                                 }
                                 else{ // ???????????
                                    if(BuyLimitTicket>0){
                                       switch(PendNewSigMode){
                                          case 1: // ???????
                                             if(iTime(NULL,TimeFrame,0)>=LastBuyTime+TimeFrame*60*SleepBars){
                                                if(OrderSelect(BuyLimitTicket,SELECT_BY_TICKET)){
                                                   OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel+(Ask-Bid);
                                                      if(ND(OpPrice)!=ND(OrderOpenPrice())){
                                                         Expir=0;
                                                         if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                                   
                                                         fModifyBuyLimit(OrderTicket(),OpPrice,Expir); 
                                                      }
                                                }
                                             }
                                          break;
                                          case 2: // ?? ?????? ????
                                             if(OrderSelect(BuyLimitTicket,SELECT_BY_TICKET)){
                                                OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel+(Ask-Bid);
                                                   if(ND(OpPrice)>ND(OrderOpenPrice())){
                                                      Expir=0;
                                                      if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                                   
                                                      fModifyBuyLimit(OrderTicket(),OpPrice,Expir); 
                                                   }
                                             }
                                          break;
                                       }
                                    }
                                 }                              
                              break;
                           } 
                        }                              
                     }                           
                  }                                               
               }
               if(Sell){
                  if(SellSignal){
                     if(!CloseSellSignal){
                        if(!BuySignal){
                           // SELL
                           switch(OrdType){
                              case 0: // Sell Market
                                 if((AllCount<MaxOrdersCount || MaxOrdersCount==-1) && fTimeInZone3s()){
                                    if(AllSellCount<MaxSellCount || MaxSellCount==-1){                               
                                       if(iTime(NULL,TimeFrame,0)>=LastSellTime+TimeFrame*60*SleepBars){
                                          fOrderOpenSell();              
                                       }
                                    }
                                 }                                       
                              break;
                              case 1: // Sell Stop
                                 if(SellStopCount==0){ // ?????????
                                    if((AllCount<MaxOrdersCount || MaxOrdersCount==-1) && fTimeInZone3s()){
                                       if(AllSellCount<MaxSellCount || MaxSellCount==-1){                                 
                                          if(iTime(NULL,TimeFrame,0)>=LastSellTime+TimeFrame*60*SleepBars){
                                             OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel;
                                             Expir=0;
                                             if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                 
                                             fOrderSetSellStop(OpPrice,Expir);              
                                          }  
                                       }
                                    }      
                                 }
                                 else{ // ???????????
                                    if(SellStopTicket>0){
                                       switch(PendNewSigMode){
                                          case 1: // ???????
                                             if(iTime(NULL,TimeFrame,0)>=LastSellTime+TimeFrame*60*SleepBars){
                                                if(OrderSelect(SellStopTicket,SELECT_BY_TICKET)){
                                                   OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel;
                                                      if(ND(OpPrice)!=ND(OrderOpenPrice())){
                                                         Expir=0;
                                                         if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                 
                                                         fModifySellStop(OrderTicket(),OpPrice,Expir);              
                                                      }
                                                }
                                             }  
                                          break;
                                          case 2: // ?? ?????? ????
                                             if(OrderSelect(SellStopTicket,SELECT_BY_TICKET)){
                                                OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel;
                                                   if(ND(OpPrice)>ND(OrderOpenPrice())){
                                                      Expir=0;
                                                      if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                 
                                                      fModifySellStop(OrderTicket(),OpPrice,Expir);              
                                                   }
                                             }
                                          break;
                                       }
                                    }
                                 }   
                              break;
                              case 2: // Sell Limit 
                                 if(SellLimitCount==0){ // ?????????
                                    if((AllCount<MaxOrdersCount || MaxOrdersCount==-1) && fTimeInZone3s()){
                                       if(AllSellCount<MaxSellCount || MaxSellCount==-1){                               
                                          if(iTime(NULL,TimeFrame,0)>=LastSellTime+TimeFrame*60*SleepBars){
                                             OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel;
                                             Expir=0;
                                             if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                     
                                             fOrderSetSellLimit(OpPrice,Expir);              
                                          }                               
                                       }
                                    }      
                                 }
                                 else{ // ???????????
                                    if(SellLimitTicket>0){
                                       switch(PendNewSigMode){
                                          case 1:
                                             if(iTime(NULL,TimeFrame,0)>=LastSellTime+TimeFrame*60*SleepBars){
                                                if(OrderSelect(SellLimitTicket,SELECT_BY_TICKET)){
                                                   OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel;
                                                      if(ND(OpPrice)!=ND(OrderOpenPrice())){
                                                         Expir=0;
                                                         if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                 
                                                         fModifySellLimit(OrderTicket(),OpPrice,Expir);              
                                                      }
                                                }
                                             }  
                                          break;
                                          case 2:
                                             if(OrderSelect(SellLimitTicket,SELECT_BY_TICKET)){
                                                OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel;
                                                   if(ND(OpPrice)<ND(OrderOpenPrice())){
                                                      Expir=0;
                                                      if(PendExpiration!=0)Expir=TimeCurrent()+PendExpiration*60;                                 
                                                      fModifySellLimit(OrderTicket(),OpPrice,Expir);              
                                                   }
                                             }
                                          break;
                                       }
                                    }
                                 } 
                              break;
                           }
                        }
                     }
                  }                                                                                                  
               }
        
      }     
      
      IndTrailing();
      if(TrailingStop_Use)fTrailingWithStart();
      if(BreakEven_Use)fBreakEvenToLevel();
      if(OrdType!=0)if(PendPriceFollow)fPendingPriceFollow();      

   return(0);

}

//+------------------------------------------------------------------+

void fPendingPriceFollow(){
      for(int i=OrdersTotal()-1;i>=0;i--){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               switch (OrderType()){
                  case OP_BUYSTOP:
                     double OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel+(Ask-Bid);
                        if(ND(OpPrice)<ND(OrderOpenPrice())){
                           fModifyBuyStop(OrderTicket(),OpPrice,OrderExpiration());
                        }
                  break;
                  case OP_SELLSTOP:
                     OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel;
                        if(ND(OpPrice)>ND(OrderOpenPrice())){
                           fModifySellStop(OrderTicket(),OpPrice,OrderExpiration());
                        }                     
                  break;
                  case OP_BUYLIMIT:
                     OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel+(Ask-Bid);
                        if(ND(OpPrice)>ND(OrderOpenPrice())){
                           fModifyBuyLimit(OrderTicket(),OpPrice,OrderExpiration());
                        }                     
                  break;
                  case OP_SELLLIMIT:
                     OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)+Point*PendLevel;
                     OpPrice=iMA(NULL,TimeFrame,1,0,0,PendPromPrice,0)-Point*PendLevel+(Ask-Bid);
                        if(ND(OpPrice)<ND(OrderOpenPrice())){
                           fModifySellLimit(OrderTicket(),OpPrice,OrderExpiration());
                        }                       
                  break; 
               }            
            }
         }
      }   
}



double fGetLotsSimple(int aTradeType){

   double retlot;
   double Means;
   
      switch(MMMethod){
         case 0:
            retlot=Lots;
         break;         
         case 1:
               switch (MeansType){
                  case 1:
                     Means=AccountBalance();
                     break;
                  case 2:
                     Means=AccountEquity();	 
                     break;
                  case 3:
                     Means=AccountFreeMargin();
                     break;
                  default:
                     Means=AccountBalance();	       
               }
            retlot=AccountBalance()/1000*Risk;
         break;         
         case 2:
               switch (MeansType){
                  case 1:
                     Means=AccountBalance();
                     break;
                  case 2:
                     Means=AccountEquity();	 
                     break;
                  case 3:
                     Means=AccountFreeMargin();
                     break;
                  default:
                     Means=AccountBalance();	       
               }  
               if(Means<MeansStep){
                  Means=MeansStep;
               }
            retlot=(MeansStep*MathFloor(Means/MeansStep))/1000*Risk;     
         break;
         default:  
            retlot=Lots;
      }   
   if(retlot<1.0/MathPow(10,LotsDigits))retlot=1.0/MathPow(10,LotsDigits) ;  
   retlot=NormalizeDouble(retlot,LotsDigits);

   if(AccountFreeMarginCheck(Symbol(),aTradeType,retlot)<=0){
      return(-1);
   }
   if(GetLastError()==134){
      return(-2);
   }   
   
   return(retlot);   
}


int fOrderOpenBuy(){
   RefreshRates();
   double lts=fGetLotsSimple(OP_BUY);
      if(lts>0){      
         if(!IsTradeContextBusy()){
            double slts=0;
            double tpts=0;         
               if(!MW_Mode){
                  if(StopLoss!=0)slts=ND(Ask-Point*StopLoss);
                  if(TakeProfit!=0)tpts=ND(Ask+Point*TakeProfit);
               }
            int irv=OrderSend(Symbol(),OP_BUY,lts,ND(Ask),Slippage,slts,tpts,BuyComment,Magic_N,0,CLR_NONE);
               if(irv>0){
                  LastBuyTime=iTime(NULL,TimeFrame,0);
                  if(CancelSleeping)LastSellTime=0;
                     if(MW_Mode){
                        fMW();
                     }                  
                  return(irv);
               }
               else{
                  Print ("Error open BUY. "+fMyErDesc(GetLastError())); 
                  return(-1);
               }
         }
         else{
            static int lt2=0;
               if(lt2!=iTime(NULL,TimeFrame,0)){
                  lt2=iTime(NULL,TimeFrame,0);
                  Print("Need open buy. Trade Context Busy");
               }            
            return(-2);
         }
      }
      else{
         static int lt3=0;
            if(lt3!=iTime(NULL,TimeFrame,0)){
               lt3=iTime(NULL,TimeFrame,0);
               if(lts==-1)Print("Need open buy. No money");
               if(lts==-2)Print("Need open buy. Wrong lots size");                  
            }
         return(-3);                  
      }
}  

int fOrderOpenSell(){
   RefreshRates();
   double lts=fGetLotsSimple(OP_SELL);
      if(lts>0){      
         if(!IsTradeContextBusy()){
            double slts=0;
            double tpts=0;         
               if(!MW_Mode){
                  if(StopLoss!=0)slts=ND(Bid+Point*StopLoss);
                  if(TakeProfit!=0)tpts=ND(Bid-Point*TakeProfit);
               }         
            int irv=OrderSend(Symbol(),OP_SELL,lts,ND(Bid),Slippage,slts,tpts,SellComment,Magic_N,0,CLR_NONE);
               if(irv>0){
                  LastSellTime=iTime(NULL,TimeFrame,0);
                  if(CancelSleeping)LastBuyTime=0;
                     if(MW_Mode){
                        fMW();
                     }
                  return(irv);
               }
               else{
                  Print ("Error open SELL. "+fMyErDesc(GetLastError())); 
                  return(-1);
               }
         }
         else{
            static int lt2=0;
               if(lt2!=iTime(NULL,TimeFrame,0)){
                  lt2=iTime(NULL,TimeFrame,0);
                  Print("Need open sell. Trade Context Busy");
               }            
            return(-2);
         }
      }
      else{
         static int lt3=0;
            if(lt3!=iTime(NULL,TimeFrame,0)){
               lt3=iTime(NULL,TimeFrame,0);
               if(lts==-1)Print("Need open sell. No money");
               if(lts==-2)Print("Need open sell. Wrong lots size");      
            }
         return(-3);                  
      }
}  


void fMW(){
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               RefreshRates();
                  if(OrderType()==OP_BUY || OrderType()==OP_SELL){
                     if((ND(OrderStopLoss())==0 && StopLoss!=0) || (ND(OrderTakeProfit())==0 && TakeProfit!=0)){
                        if(OrderType()==OP_BUY){                     
                           double slts=ND(OrderStopLoss());
                              if(slts==0){
                                 if(StopLoss==0)slts=0;else{
                                    slts=ND(OrderOpenPrice()-Point*StopLoss);
                                    double msl=ND(Bid-Point*MarketInfo(Symbol(),MODE_STOPLEVEL)-Point);
                                    slts=MathMin(slts,msl);
                                 }
                              }
                           double tpts=ND(OrderTakeProfit());
                              if(tpts==0){
                                 if(TakeProfit==0)tpts=0;else {
                                    tpts=ND(OrderOpenPrice()+Point*TakeProfit);
                                    double mtp=ND(Bid+Point*MarketInfo(Symbol(),MODE_STOPLEVEL)+Point);
                                    tpts=MathMax(tpts,mtp);
                                 }
                              }                           
                        }  
                        if(OrderType()==OP_SELL){                     
                           slts=ND(OrderStopLoss());
                              if(slts==0){
                                 if(StopLoss==0)slts=0;else {
                                    slts=ND(OrderOpenPrice()+Point*StopLoss);
                                    msl=ND(Ask+Point*MarketInfo(Symbol(),MODE_STOPLEVEL)+Point);
                                    slts=MathMax(slts,msl);
                                 }
                              }
                           tpts=ND(OrderTakeProfit());
                              if(tpts==0){
                                 if(TakeProfit==0)tpts=0;else {
                                    tpts=ND(OrderOpenPrice()-Point*TakeProfit);
                                    mtp=ND(Ask-Point*MarketInfo(Symbol(),MODE_STOPLEVEL)-Point);
                                    tpts=MathMin(tpts,mtp);
                                 }
                              }                           
                        }  
                        if(OrderStopLoss()!=slts || OrderTakeProfit()!=tpts){
                           bool brv=OrderModify(OrderTicket(),OrderOpenPrice(),slts,tpts,0,CLR_NONE);
                           int check=GetLastError();
                                    if(brv){
                                       Print("SL/TP ??? ?????? "+OrderTicket()+" ??????????");  
                                    }
                                    else{
                                       Print("?? ??????? ?????????? SL/TP ??? ?????? "+OrderTicket()+". "+fMyErDesc(check)); 
                                    }
                        }                        
                     }
                  }
            }
         }
      }   
}


string fMyErDesc(int aErrNum){
   string pref="Err Num: "+aErrNum+" - ";
   switch(aErrNum){
      case 0: return(pref+"NO ERROR");
      case 1: return(pref+"NO RESULT");                                 
      case 2: return(pref+"COMMON ERROR");                              
      case 3: return(pref+"INVALID TRADE PARAMETERS");                  
      case 4: return(pref+"SERVER BUSY");                               
      case 5: return(pref+"OLD VERSION");                               
      case 6: return(pref+"NO CONNECTION");                             
      case 7: return(pref+"NOT ENOUGH RIGHTS");                         
      case 8: return(pref+"TOO FREQUENT REQUESTS");                     
      case 9: return(pref+"MALFUNCTIONAL TRADE");                       
      case 64: return(pref+"ACCOUNT DISABLED");                         
      case 65: return(pref+"INVALID ACCOUNT");                          
      case 128: return(pref+"TRADE TIMEOUT");                           
      case 129: return(pref+"INVALID PRICE");                           
      case 130: return(pref+"INVALID STOPS");                           
      case 131: return(pref+"INVALID TRADE VOLUME");                    
      case 132: return(pref+"MARKET CLOSED");                           
      case 133: return(pref+"TRADE DISABLED");                          
      case 134: return(pref+"NOT ENOUGH MONEY");                        
      case 135: return(pref+"PRICE CHANGED");                           
      case 136: return(pref+"OFF QUOTES");                              
      case 137: return(pref+"BROKER BUSY");                             
      case 138: return(pref+"REQUOTE");                                 
      case 139: return(pref+"ORDER LOCKED");                            
      case 140: return(pref+"LONG POSITIONS ONLY ALLOWED");             
      case 141: return(pref+"TOO MANY REQUESTS");                       
      case 145: return(pref+"TRADE MODIFY DENIED");                     
      case 146: return(pref+"TRADE CONTEXT BUSY");                      
      case 147: return(pref+"TRADE EXPIRATION DENIED");                 
      case 148: return(pref+"TRADE TOO MANY ORDERS");                   
      //---- mql4 run time errors
      case 4000: return(pref+"NO MQLERROR");                            
      case 4001: return(pref+"WRONG FUNCTION POINTER");                 
      case 4002: return(pref+"ARRAY INDEX OUT OF RANGE");               
      case 4003: return(pref+"NO MEMORY FOR FUNCTION CALL STACK");      
      case 4004: return(pref+"RECURSIVE STACK OVERFLOW");               
      case 4005: return(pref+"NOT ENOUGH STACK FOR PARAMETER");         
      case 4006: return(pref+"NO MEMORY FOR PARAMETER STRING");         
      case 4007: return(pref+"NO MEMORY FOR TEMP STRING");              
      case 4008: return(pref+"NOT INITIALIZED STRING");                 
      case 4009: return(pref+"NOT INITIALIZED ARRAYSTRING");            
      case 4010: return(pref+"NO MEMORY FOR ARRAYSTRING");              
      case 4011: return(pref+"TOO LONG STRING");                        
      case 4012: return(pref+"REMAINDER FROM ZERO DIVIDE");             
      case 4013: return(pref+"ZERO DIVIDE");                            
      case 4014: return(pref+"UNKNOWN COMMAND");                        
      case 4015: return(pref+"WRONG JUMP");                             
      case 4016: return(pref+"NOT INITIALIZED ARRAY");                  
      case 4017: return(pref+"DLL CALLS NOT ALLOWED");                  
      case 4018: return(pref+"CANNOT LOAD LIBRARY");                    
      case 4019: return(pref+"CANNOT CALL FUNCTION");                   
      case 4020: return(pref+"EXTERNAL EXPERT CALLS NOT ALLOWED");      
      case 4021: return(pref+"NOT ENOUGH MEMORY FOR RETURNED STRING");  
      case 4022: return(pref+"SYSTEM BUSY");                            
      case 4050: return(pref+"INVALID FUNCTION PARAMETERS COUNT");      
      case 4051: return(pref+"INVALID FUNCTION PARAMETER VALUE");       
      case 4052: return(pref+"STRING FUNCTION INTERNAL ERROR");         
      case 4053: return(pref+"SOME ARRAY ERROR");                       
      case 4054: return(pref+"INCORRECT SERIES ARRAY USING");           
      case 4055: return(pref+"CUSTOM INDICATOR ERROR");                 
      case 4056: return(pref+"INCOMPATIBLE ARRAYS");                    
      case 4057: return(pref+"GLOBAL VARIABLES PROCESSING ERROR");      
      case 4058: return(pref+"GLOBAL VARIABLE NOT FOUND");              
      case 4059: return(pref+"FUNCTION NOT ALLOWED IN TESTING MODE");   
      case 4060: return(pref+"FUNCTION NOT CONFIRMED");                 
      case 4061: return(pref+"SEND MAIL ERROR");                        
      case 4062: return(pref+"STRING PARAMETER EXPECTED");              
      case 4063: return(pref+"INTEGER PARAMETER EXPECTED");             
      case 4064: return(pref+"DOUBLE PARAMETER EXPECTED");              
      case 4065: return(pref+"ARRAY AS PARAMETER EXPECTED");            
      case 4066: return(pref+"HISTORY WILL UPDATED");                   
      case 4067: return(pref+"TRADE ERROR");                            
      case 4099: return(pref+"END OF FILE");                            
      case 4100: return(pref+"SOME FILE ERROR");                        
      case 4101: return(pref+"WRONG FILE NAME");                        
      case 4102: return(pref+"TOO MANY OPENED FILES");                  
      case 4103: return(pref+"CANNOT OPEN FILE");                       
      case 4104: return(pref+"INCOMPATIBLE ACCESS TO FILE");            
      case 4105: return(pref+"NO ORDER SELECTED");                      
      case 4106: return(pref+"UNKNOWN SYMBOL");                         
      case 4107: return(pref+"INVALID PRICE PARAM");                    
      case 4108: return(pref+"INVALID TICKET");                         
      case 4109: return(pref+"TRADE NOT ALLOWED");                      
      case 4110: return(pref+"LONGS  NOT ALLOWED");                     
      case 4111: return(pref+"SHORTS NOT ALLOWED");                     
      case 4200: return(pref+"OBJECT ALREADY EXISTS");                  
      case 4201: return(pref+"UNKNOWN OBJECT PROPERTY");                
      case 4202: return(pref+"OBJECT DOES NOT EXIST");                  
      case 4203: return(pref+"UNKNOWN OBJECT TYPE");                    
      case 4204: return(pref+"NO OBJECT NAME");                         
      case 4205: return(pref+"OBJECT COORDINATES ERROR");               
      case 4206: return(pref+"NO SPECIFIED SUBWINDOW");                 
      case 4207: return(pref+"SOME OBJECT ERROR");    
      default: return(pref+"WRONG ERR NUM");                
   }
}  


double ND(double v){return(NormalizeDouble(v,Digits));}


int fOrdersTotal(int & aBuyCount,int & aSellCount,int & aBuyStopCount,int & aSellStopCount,int & aBuyLimitCount,int & aSellLimitCount,int & aBuyStopTicket,int & aSellStopTicket,int & aBuyLimitTicket,int & aSellLimitTicket){
   aBuyCount=0;
   aSellCount=0;
   aBuyStopCount=0;
   aSellStopCount=0;
   aBuyLimitCount=0;
   aSellLimitCount=0;
   aBuyStopTicket=0;
   aSellStopTicket=0;
   aBuyLimitTicket=0;
   aSellLimitTicket=0;   
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               switch (OrderType()){
                  case OP_BUY:
                     aBuyCount++;
                     break;
                  case OP_SELL:
                     aSellCount++;
                     break;   
                  case OP_BUYSTOP:
                     aBuyStopCount++;
                     aBuyStopTicket=OrderTicket();
                     break;
                  case OP_SELLSTOP:
                     aSellStopCount++;
                     aSellStopTicket=OrderTicket();
                     break;                       
                  case OP_BUYLIMIT:
                     aBuyLimitCount++;
                     aBuyLimitTicket=OrderTicket();
                     break;
                  case OP_SELLLIMIT:
                     aSellLimitCount++;
                     aSellLimitTicket=OrderTicket();
                     break;                       
                      
               }
            }
         }
         else{
            return(-1);
         }
      }
   return(aBuyCount+aSellCount);
}



int fOrderCloseMarket(bool aCloseBuy=true,bool aCloseSell=true){
   int tErr=0;
      for(int i=OrdersTotal()-1;i>=0;i--){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               if(OrderType()==OP_BUY && aCloseBuy){
                  RefreshRates();               
                     if(CheckProfit){
                        if(ND(Bid-OrderOpenPrice())<ND(Point*MinimalProfit)){
                           continue;
                        }
                     }
                     if(CheckSL){
                        if(ND(OrderStopLoss())!=0){
                           if(ND(OrderStopLoss()-OrderOpenPrice())>=ND(Point*MinimalSLProfit)){
                              continue;
                           }
                        }
                     }
                     if(!IsTradeContextBusy()){
                        if(!OrderClose(OrderTicket(),OrderLots(),ND(Bid),Slippage,CLR_NONE)){
                           Print("Error close BUY "+OrderTicket()+" "+fMyErDesc(GetLastError())); 
                           tErr=-1;
                        }
                     }
                     else{
                        static int lt1=0;
                           if(lt1!=iTime(NULL,TimeFrame,0)){
                              lt1=iTime(NULL,TimeFrame,0);
                              Print("Need close BUY "+OrderTicket()+". Trade Context Busy");
                           }            
                        return(-2);
                     }   
               }
               if(OrderType()==OP_SELL && aCloseSell){
                  RefreshRates();               
                     if(CheckProfit){
                        if(ND(OrderOpenPrice()-Ask)<ND(Point*MinimalProfit)){
                           continue;
                        }
                     }
                     if(CheckSL){
                        if(ND(OrderStopLoss())!=0){
                           if(ND(OrderOpenPrice()-OrderStopLoss())>=ND(Point*MinimalSLProfit)){
                              continue;
                           }
                        }
                     }                     
                     if(!IsTradeContextBusy()){                        
                        if(!OrderClose(OrderTicket(),OrderLots(),ND(Ask),Slippage,CLR_NONE)){
                           Print("Error close SELL "+OrderTicket()+" "+fMyErDesc(GetLastError())); 
                           tErr=-1;
                        }  
                     }
                     else{
                        static int lt2=0;
                           if(lt2!=iTime(NULL,TimeFrame,0)){
                              lt2=iTime(NULL,TimeFrame,0);
                              Print("Need close SELL "+OrderTicket()+". Trade Context Busy");
                           }            
                        return(-2);
                     }          
               }
            }
         }
      }
   return(tErr);
}  

int fOrderDeletePending(bool aDeleteBuy=true,bool aDeleteSell=true){
   int tErr=0;
      for(int i=OrdersTotal()-1;i>=0;i--){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               if((OrderType()==OP_BUYSTOP || OrderType()==OP_BUYLIMIT) && aDeleteBuy){
                  RefreshRates();
                     if(!IsTradeContextBusy()){
                        if(!OrderDelete(OrderTicket())){
                           Print("Error delete order "+OrderTicket()+" "+fMyErDesc(GetLastError())); 
                           tErr=-1;
                        }
                     }
                     else{
                        static int lt1=0;
                           if(lt1!=iTime(NULL,TimeFrame,0)){
                              lt1=iTime(NULL,TimeFrame,0);
                              Print("Need delete order "+OrderTicket()+". Trade Context Busy");
                           }            
                        return(-2);
                     }   
               }
               if((OrderType()==OP_SELLSTOP || OrderType()==OP_SELLLIMIT) && aDeleteSell){
                  RefreshRates();
                     if(!IsTradeContextBusy()){                        
                        if(!OrderDelete(OrderTicket())){
                           Print("Error delete order "+OrderTicket()+" "+fMyErDesc(GetLastError())); 
                           tErr=-1;
                        }  
                     }
                     else{
                        static int lt2=0;
                           if(lt2!=iTime(NULL,TimeFrame,0)){
                              lt2=iTime(NULL,TimeFrame,0);
                              Print("Need delete order "+OrderTicket()+". Trade Context Busy");
                           }            
                        return(-2);
                     }          
               }
            }
         }
      }
   return(tErr);
}  


void fBreakEvenToLevel(){
   double slts;
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               if(OrderType()==OP_BUY){
                  RefreshRates();
                     if(ND(Bid-OrderOpenPrice())>=ND(Point*BreakEvenStart)){
                        slts=ND(OrderOpenPrice()+Point*(BreakEvenStart-BreakEvenLevel));
                           if(ND(OrderStopLoss())<slts){
                              if(!IsTradeContextBusy()){                           
                                    if(!OrderModify(OrderTicket(),OrderOpenPrice(),slts,OrderTakeProfit(),0,CLR_NONE)){
                                       Print("Error breakeven BUY "+OrderTicket()+" "+fMyErDesc(GetLastError()));
                                    }
                              }
                              else{
                                 static int lt1=0;
                                    if(lt1!=iTime(NULL,TimeFrame,0)){
                                       lt1=iTime(NULL,TimeFrame,0);
                                       Print("Need breakeven BUY "+OrderTicket()+". Trade Context Busy");
                                    } 
                              }                           
                           }
                     }
               }
               if(OrderType()==OP_SELL){
                  RefreshRates();
                     if(ND(OrderOpenPrice()-Ask)>=ND(Point*BreakEvenStart)){
                        slts=ND(OrderOpenPrice()-Point*(BreakEvenStart-BreakEvenLevel));
                           if(ND(OrderStopLoss())>slts || ND(OrderStopLoss())==0){
                              if(!IsTradeContextBusy()){                           
                                    if(!OrderModify(OrderTicket(),OrderOpenPrice(),slts,OrderTakeProfit(),0,CLR_NONE)){
                                       Print("Error breakeven SELL "+OrderTicket()+" "+fMyErDesc(GetLastError()));
                                    }
                              }
                              else{
                                 static int lt2=0;
                                    if(lt2!=iTime(NULL,TimeFrame,0)){
                                       lt2=iTime(NULL,TimeFrame,0);
                                       Print("Need breakeven SELL "+OrderTicket()+". Trade Context Busy");
                                    } 
                              } 
                           }
                     } 
               }
            }
         }
      }
}

void fTrailingWithStart(){
   double slts;
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               if(OrderType()==OP_BUY){
                  RefreshRates();
                     if(ND(Bid-OrderOpenPrice())>=ND(Point*TrailingStopStart)){
                        slts=ND(Bid-Point*TrailingStop);
                           if(ND(OrderStopLoss())<slts){
                              if(!IsTradeContextBusy()){
                                 if(!OrderModify(OrderTicket(),OrderOpenPrice(),slts,OrderTakeProfit(),0,CLR_NONE)){
                                    Print("Error trailingstop BUY "+OrderTicket()+" "+fMyErDesc(GetLastError()));
                                 }
                              }
                              else{
                                 static int lt1=0;
                                    if(lt1!=iTime(NULL,TimeFrame,0)){
                                       lt1=iTime(NULL,TimeFrame,0);
                                       Print("Need trailingstop BUY "+OrderTicket()+". Trade Context Busy");
                                    }            
                              }
                           }
                     }
               }
               if(OrderType()==OP_SELL){
                  RefreshRates();
                     if(ND(OrderOpenPrice()-Ask)>=ND(Point*TrailingStopStart)){
                        slts=ND(Ask+Point*TrailingStop);
                           if(!IsTradeContextBusy()){                           
                              if(ND(OrderStopLoss())>slts || ND(OrderStopLoss())==0){
                                 if(!OrderModify(OrderTicket(),OrderOpenPrice(),slts,OrderTakeProfit(),0,CLR_NONE)){
                                    Print("Error trailingstop SELL "+OrderTicket()+" "+fMyErDesc(GetLastError()));
                                 }
                              }
                           }
                           else{
                                 static int lt2=0;
                                    if(lt2!=iTime(NULL,TimeFrame,0)){
                                       lt2=iTime(NULL,TimeFrame,0);
                                       Print("Need trailingstop SELL "+OrderTicket()+". Trade Context Busy");
                                    } 
                           }
                     } 
               }
            }
         }
      }
}



double fGetCustomValue(int TimeFrame,string aName,int aIndex,double aParArr[],int aShift){
   double tv;
   switch (ArraySize(aParArr)){
      case 0:
         tv=iCustom(NULL,TimeFrame,aName,aIndex,aShift);
      break;
      case 1:
         tv=iCustom(NULL,TimeFrame,aName,aParArr[0],aIndex,aShift);      
      break;
      case 2:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aIndex,aShift);      
      break;      
      case 3:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aIndex,aShift);  
      break;        
      case 4:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aIndex,aShift);  
      break;        
      case 5:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aIndex,aShift); 
      break;        
      case 6:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aIndex,aShift); 
      break;   
      case 7:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6],            
            aIndex,aShift); 

      break;        
      case 8:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7],                        
            aIndex,aShift); 
      break;        
      case 9:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],                                    
            aIndex,aShift); 
      break;        
      case 10:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aIndex,aShift); 
      break;        
      case 11:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aIndex,aShift); 
      break;        
      case 12:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aIndex,aShift); 
      break;        
      case 13:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aIndex,aShift); 
      break;        
      case 14:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aIndex,aShift); 
      break;        
      case 15:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aIndex,aShift); 
      break;        
      case 16:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aIndex,aShift); 
      break;        
      case 17:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aIndex,aShift); 
      break;        
      case 18:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aIndex,aShift); 
      break;        
      case 19:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aIndex,aShift); 
      break;        
      case 20:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aIndex,aShift); 
      break;        
      case 21:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aIndex,aShift); 
      break;        
      case 22:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aIndex,aShift); 
      break;        
      case 23:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aIndex,aShift); 
      break;        
      case 24:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aIndex,aShift); 
      break;        
      case 25:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aIndex,aShift); 
      break;        
      case 26:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aIndex,aShift); 
      break;        
      case 27:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aIndex,aShift); 
      break;  
      case 28:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aIndex,aShift); 
      break;      
      case 29:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aIndex,aShift); 
      break;      
      case 30:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aIndex,aShift); 
      break;      
      case 31:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aIndex,aShift); 
      break;      
      case 32:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aIndex,aShift); 
      break;      
      case 33:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aIndex,aShift); 
      break;      
      case 34:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aIndex,aShift); 
      break;      
      case 35:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aIndex,aShift); 
      break;      
      case 36:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aIndex,aShift);  
      break;      
      case 37:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aIndex,aShift); 
      break;      
      case 38:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aIndex,aShift); 
      break;      
      case 39:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aIndex,aShift); 
      break;      
      case 40:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aIndex,aShift); 
      break;
      case 41:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aIndex,aShift); 
      break;      
      case 42:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aIndex,aShift); 
      break;      
      case 43:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aIndex,aShift); 
      break;      
      case 44:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aIndex,aShift); 
      break;      
      case 45:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aIndex,aShift); 
      break;      
      case 46:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aIndex,aShift); 
      break;      
      case 47:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aIndex,aShift); 
      break;      
      case 48:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aIndex,aShift); 
      break;      
      case 49:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aIndex,aShift); 
      break;      
      case 50:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aIndex,aShift); 
      break;      
      case 51:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aIndex,aShift); 
      break;      
      case 52:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aIndex,aShift); 
      break;      
      case 53:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aIndex,aShift); 
      break;      
      case 54:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aParArr[53],
            aIndex,aShift); 
      break;       
      case 55:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aParArr[53],
            aParArr[54],
            aIndex,aShift); 
      break;       
      case 56:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aParArr[53],
            aParArr[54],
            aParArr[55],
            aIndex,aShift); 
      break;       
      case 57:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aParArr[53],
            aParArr[54],
            aParArr[55],
            aParArr[56],
            aIndex,aShift); 
      break;       
      case 58:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aParArr[53],
            aParArr[54],
            aParArr[55],
            aParArr[56],
            aParArr[57],
            aIndex,aShift); 
      break;       
      case 59:
         tv=iCustom(NULL,TimeFrame,aName,
            aParArr[0],
            aParArr[1],
            aParArr[2],
            aParArr[3],
            aParArr[4],
            aParArr[5],
            aParArr[6], 
            aParArr[7], 
            aParArr[8],
            aParArr[9],
            aParArr[10],
            aParArr[11],
            aParArr[12],
            aParArr[13],
            aParArr[14],
            aParArr[15],
            aParArr[16],
            aParArr[17],
            aParArr[18],
            aParArr[19],
            aParArr[20],
            aParArr[21],
            aParArr[22],
            aParArr[23],
            aParArr[24],
            aParArr[25],
            aParArr[26],
            aParArr[27],
            aParArr[28],
            aParArr[29],
            aParArr[30],
            aParArr[31],
            aParArr[32],
            aParArr[33],
            aParArr[34],
            aParArr[35],
            aParArr[36],
            aParArr[37],
            aParArr[38],
            aParArr[39],
            aParArr[40],
            aParArr[41],
            aParArr[42],
            aParArr[43],
            aParArr[44],
            aParArr[45],
            aParArr[46],
            aParArr[47],
            aParArr[48],            
            aParArr[49],
            aParArr[50],
            aParArr[51],
            aParArr[52],
            aParArr[53],
            aParArr[54],
            aParArr[55],
            aParArr[56],
            aParArr[57],
            aParArr[58],              
            aIndex,aShift); 
      break;       
   }
   return(tv);
}

int fOrderSetBuyLimit(double aOpenPrice,datetime aExpiration=0){

   // fOrderSetBuyLimit();

   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Ask-Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr<=msl){
         double lts=fGetLotsSimple(OP_BUY);
            if(lts>0){
               if(!IsTradeContextBusy()){
                  double slts=ND(oppr-Point*StopLoss);
                  if(StopLoss==0)slts=0;
                  double tpts=ND(oppr+Point*TakeProfit);
                  if(TakeProfit==0)tpts=0;
                  int irv=OrderSend(Symbol(),OP_BUYLIMIT,lts,oppr,Slippage,slts,tpts,BuyLimitComment,Magic_N,aExpiration,CLR_NONE);
                     if(irv>0){
                        return(irv);
                     }
                     else{
                        Print ("Error set BUYLIMIT. "+fMyErDesc(GetLastError())); 
                        return(-1);
                     }
               }
               else{
                  static int lt2=0;
                     if(TimeCurrent()>lt2+20){
                        lt2=TimeCurrent();
                        Print("Need set BUYLIMIT. Trade Context Busy");
                     }   
                  return(-2);                 
               }
            }
            else{
               static int lt3=0;
                  if(TimeCurrent()>lt3+20){
                     lt3=TimeCurrent();
                     if(lts==-1)Print("Need set BUYLIMIT. No money");
                     if(lts==-2)Print("Need set BUYLIMIT. Wrong lots size");                  
                  }  
               return(-3);             
            }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+20){
               lt4=TimeCurrent();
               Print("Need set BUYLIMIT. Wrong price level");
            }  
         return(-4);
      }
}

int fOrderSetBuyStop(double aOpenPrice,datetime aExpiration=0){

   // fOrderSetBuyStop();

   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Ask+Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr>=msl){
         double lts=fGetLotsSimple(OP_BUY);
            if(lts>0){
               if(!IsTradeContextBusy()){
                  double slts=ND(oppr-Point*StopLoss);
                  if(StopLoss==0)slts=0;
                  double tpts=ND(oppr+Point*TakeProfit);
                  if(TakeProfit==0)tpts=0;
                  int irv=OrderSend(Symbol(),OP_BUYSTOP,lts,oppr,Slippage,slts,tpts,BuyStopComment,Magic_N,aExpiration,CLR_NONE);
                     if(irv>0){
                        return(irv);
                     }
                     else{
                        Print ("Error set BUYSTOP. "+fMyErDesc(GetLastError())); 
                        return(-1);
                     }
               }
               else{
                  static int lt2=0;
                     if(TimeCurrent()>lt2+20){
                        lt2=TimeCurrent();
                        Print("Need set BUYSTOP. Trade Context Busy");
                     }   
                  return(-2);                 
               }
            }
            else{
               static int lt3=0;
                  if(TimeCurrent()>lt3+20){
                     lt3=TimeCurrent();
                     if(lts==-1)Print("Need set BUYSTOP. No money");
                     if(lts==-2)Print("Need set BUYSTOP. Wrong lots size");                  
                  }  
               return(-3);             
            }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+20){
               lt4=TimeCurrent();
               Print("Need set BUYSTOP. Wrong price level ",msl," ",Ask);
            }  
         return(-4);
      }
}

int fOrderSetSellLimit(double aOpenPrice,datetime aExpiration=0){

   // fOrderSetSellLimit();

   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Bid+Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr>=msl){
         double lts=fGetLotsSimple(OP_SELL);
            if(lts>0){
               if(!IsTradeContextBusy()){
                  double slts=ND(oppr+Point*StopLoss);
                  if(StopLoss==0)slts=0;
                  double tpts=ND(oppr-Point*TakeProfit);
                  if(TakeProfit==0)tpts=0;
                  int irv=OrderSend(Symbol(),OP_SELLLIMIT,lts,oppr,Slippage,slts,tpts,SellLimitComment,Magic_N,aExpiration,CLR_NONE);
                     if(irv>0){
                        return(irv);
                     }
                     else{
                        Print ("Error set SELLLIMIT. "+fMyErDesc(GetLastError())); 
                        return(-1);
                     }
               }
               else{
                  static int lt2=0;
                     if(TimeCurrent()>lt2+20){
                        lt2=TimeCurrent();
                        Print("Need set SELLLIMIT. Trade Context Busy");
                     }   
                  return(-2);                 
               }
            }
            else{
               static int lt3=0;
                  if(TimeCurrent()>lt3+20){
                     lt3=TimeCurrent();
                     if(lts==-1)Print("Need set SELLLIMIT. No money");
                     if(lts==-2)Print("Need set SELLLIMIT. Wrong lots size");                  
                  }  
               return(-3);             
            }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+20){
                  lt4=TimeCurrent();
                  if(lts==-1)Print("Need set SELLIMIT. Wrong price level");
            }  
         return(-4);
      }
}

int fOrderSetSellStop(double aOpenPrice,datetime aExpiration=0){

   // fOrderSetSellStop();

   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Bid-Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr<=msl){
         double lts=fGetLotsSimple(OP_SELL);
            if(lts>0){
               if(!IsTradeContextBusy()){
                  double slts=ND(oppr+Point*StopLoss);
                  if(StopLoss==0)slts=0;
                  double tpts=ND(oppr-Point*TakeProfit);
                  if(TakeProfit==0)tpts=0;
                  int irv=OrderSend(Symbol(),OP_SELLSTOP,lts,oppr,Slippage,slts,tpts,SellStopComment,Magic_N,aExpiration,CLR_NONE);
                     if(irv>0){
                        return(irv);
                     }
                     else{
                        Print ("Error set SELLSTOP. "+fMyErDesc(GetLastError())); 
                        return(-1);
                     }
               }
               else{
                  static int lt2=0;
                     if(TimeCurrent()>lt2+20){
                        lt2=TimeCurrent();
                        Print("Need set SELLSTOP. Trade Context Busy");
                     }   
                  return(-2);                 
               }
            }
            else{
               static int lt3=0;
                  if(TimeCurrent()>lt3+20){
                     lt3=TimeCurrent();
                     if(lts==-1)Print("Need set SELLSTOP. No money");
                     if(lts==-2)Print("Need set SELLSTOP. Wrong lots size");                  
                  }  
               return(-3);             
            }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+20){
               lt4=TimeCurrent();
               Print("Need set SELLSTOP. Wrong price level");
            }  
         return(-4);
      }
}

int fModifyBuyStop(int aTicket,double aOpenPrice,datetime aExpiration=0){
   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Ask+Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr>=msl){
         if(!IsTradeContextBusy()){
            double slts=ND(oppr-Point*StopLoss);
               if(StopLoss==0)slts=0;
               double tpts=ND(oppr+Point*TakeProfit);
               if(TakeProfit==0)tpts=0;
               bool brv=OrderModify(aTicket,oppr,slts,tpts,aExpiration,CLR_NONE);
                  if(brv){
                     return(0);
                  }
                  else{
                     Print ("Error modify BUYSTOP. "+fMyErDesc(GetLastError())); 
                     return(-1);
                  }
         }
         else{
            static int lt2=0;
               if(TimeCurrent()>lt2+30){
                  lt2=TimeCurrent();
                  Print("Need modify buystop. Trade Context Busy");
               }   
            return(-2);                 
         }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+30){
               lt4=TimeCurrent();
               Print("Need modify buystop. Wrong price level ");
            }  
         return(-4);
      }
}

int fModifySellStop(int aTicket,double aOpenPrice,datetime aExpiration=0){
   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Bid-Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr<=msl){
               if(!IsTradeContextBusy()){
                  double slts=ND(oppr+Point*StopLoss);
                  if(StopLoss==0)slts=0;
                  double tpts=ND(oppr-Point*TakeProfit);
                  if(TakeProfit==0)tpts=0;
                  int irv=OrderModify(aTicket,oppr,slts,tpts,aExpiration,CLR_NONE);
                     if(irv>0){
                        return(irv);
                     }
                     else{
                        Print ("Error modify SELLSTOP. "+fMyErDesc(GetLastError())); 
                        return(-1);
                     }
               }
               else{
                  static int lt2=0;
                     if(TimeCurrent()>lt2+30){
                        lt2=TimeCurrent();
                        Print("Need modify sellstop. Trade Context Busy");
                     }   
                  return(-2);                 
               }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+30){
                  lt4=TimeCurrent();
                  Print("Need modify sellstop. Wrong price level");
            }  
         return(-4);
      }
}


int fModifyBuyLimit(int aTicket,double aOpenPrice,datetime aExpiration=0){
   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Ask-Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr<=msl){
         if(!IsTradeContextBusy()){
            double slts=ND(oppr-Point*StopLoss);
               if(StopLoss==0)slts=0;
               double tpts=ND(oppr+Point*TakeProfit);
               if(TakeProfit==0)tpts=0;
               bool brv=OrderModify(aTicket,oppr,slts,tpts,aExpiration,CLR_NONE);
                  if(brv){
                     return(0);
                  }
                  else{
                     Print ("Error modify BUYLIMIT. "+fMyErDesc(GetLastError())); 
                     return(-1);
                  }
         }
         else{
            static int lt2=0;
               if(TimeCurrent()>lt2+30){
                  lt2=TimeCurrent();
                  Print("Need modify buylimit. Trade Context Busy");
               }   
            return(-2);                 
         }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+30){
               lt4=TimeCurrent();
               Print("Need modify buylimit. Wrong price level ");
            }  
         return(-4);
      }
}

int fModifySellLimit(int aTicket,double aOpenPrice,datetime aExpiration=0){
   RefreshRates();   
   double oppr=ND(aOpenPrice);
   double msl=ND(Bid+Point*MarketInfo(Symbol(),MODE_STOPLEVEL));
      if(oppr>=msl){
               if(!IsTradeContextBusy()){
                  double slts=ND(oppr+Point*StopLoss);
                  if(StopLoss==0)slts=0;
                  double tpts=ND(oppr-Point*TakeProfit);
                  if(TakeProfit==0)tpts=0;
                  int irv=OrderModify(aTicket,oppr,slts,tpts,aExpiration,CLR_NONE);
                     if(irv>0){
                        return(irv);
                     }
                     else{
                        Print ("Error modify SELLLIMIT. "+fMyErDesc(GetLastError())); 
                        return(-1);
                     }
               }
               else{
                  static int lt2=0;
                     if(TimeCurrent()>lt2+30){
                        lt2=TimeCurrent();
                        Print("Need modify selllimit. Trade Context Busy");
                     }   
                  return(-2);                 
               }
      }
      else{
         static int lt4=0;
            if(TimeCurrent()>lt4+30){
                  lt4=TimeCurrent();
                  Print("Need modify selllimit. Wrong price level");
            }  
         return(-4);
      }
}

void IndTrailing(){
   if(!_TS_ON)return;
   double tBuyVal=0;
   double tSellVal=0;
   tBuyVal=ND(fGetCustomValue(TimeFrame,_TS_iCustomName,_TS_iForBuyBufIndex,_TS_ParArr,_TS_iShift));
   tSellVal=ND(fGetCustomValue(TimeFrame,_TS_iCustomName,_TS_iForSellBufIndex,_TS_ParArr,_TS_iShift));
      if(tBuyVal>0){
         if(tBuyVal!=EMPTY_VALUE){
            tBuyVal-=Point*_TS_Indent;
            tBuyVal=ND(tBuyVal);
         }
      }
      if(tSellVal>0){
         if(tSellVal!=EMPTY_VALUE){
            tSellVal+=Point*_TS_Indent+(Ask-Bid);     
            tSellVal=ND(tSellVal);                
         }
      }
      if(tBuyVal<=0){
         if(tSellVal<=0){
            return;
         }
      }
   
      for(int i=0;i<OrdersTotal();i++){
         if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)){
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic_N){
               if(OrderType()==OP_BUY){
                     if(tBuyVal<=0){
                        continue;
                     }
                  RefreshRates();
                     if(tBuyVal>=ND(OrderOpenPrice()+Point*_TS_TrailInProfit)){
                           if(ND(OrderStopLoss())<tBuyVal){
                              if(!IsTradeContextBusy()){
                                 if(!OrderModify(OrderTicket(),OrderOpenPrice(),tBuyVal,OrderTakeProfit(),0,CLR_NONE)){
                                    Print("Error trailingstop (ind) BUY "+OrderTicket()+" "+fMyErDesc(GetLastError()));
                                 }
                              }
                              else{
                                 static int lt1=0;
                                    if(lt1!=iTime(NULL,TimeFrame,0)){
                                       lt1=iTime(NULL,TimeFrame,0);
                                       Print("Need trailingstop BUY "+OrderTicket()+". Trade Context Busy");
                                    }            
                              }
                           }
                     }
               }
               if(OrderType()==OP_SELL){
                     if(tSellVal<=0){
                        continue;
                     }               
                  RefreshRates();
                     if(ND(tSellVal)<=ND(OrderOpenPrice()-Point*_TS_TrailInProfit)){
                           if(!IsTradeContextBusy()){                           
                              if(ND(OrderStopLoss())>tSellVal || ND(OrderStopLoss())==0){
                                 if(!OrderModify(OrderTicket(),OrderOpenPrice(),tSellVal,OrderTakeProfit(),0,CLR_NONE)){
                                    Print("Error trailingstop (ind) SELL "+OrderTicket()+" "+fMyErDesc(GetLastError()));
                                 }
                              }
                           }
                           else{
                                 static int lt2=0;
                                    if(lt2!=iTime(NULL,TimeFrame,0)){
                                       lt2=iTime(NULL,TimeFrame,0);
                                       Print("Need trailingstop SELL "+OrderTicket()+". Trade Context Busy");
                                    } 
                           }
                     } 
               }
            }
         }
      }   
}

void fStrSplit(string aString,string & aArray[],string aDelimiter){
   int tCounter=0;
   int tDelimiterLength=StringLen(aDelimiter);
   ArrayResize(aArray,tCounter);
   int tPos1=0;
   int tPos2=StringFind(aString,aDelimiter,0);
      while(tPos2!=-1){
            if(tPos2>=tPos1){
               tCounter++;
               ArrayResize(aArray,tCounter);
                  if(tPos2-tPos1==0){
                     aArray[tCounter-1]="";
                  }
                  else{
                     aArray[tCounter-1]=StringSubstr(aString,tPos1,tPos2-tPos1);
                  }
            }
         tPos1=tPos2+tDelimiterLength;
         tPos2=StringFind(aString,aDelimiter,tPos1);
      }
   tPos2=StringLen(aString);      
      if(tPos2>=tPos1){
         tCounter++;   
         ArrayResize(aArray,tCounter);
            if(tPos2-tPos1==0){
               aArray[tCounter-1]="";
            }
            else{
               aArray[tCounter-1]=StringSubstr(aString,tPos1,tPos2-tPos1);      
            }
      }
}

bool fTimeInZone3s(){
      if(UseTime){
            if(
               fTimeInZone(StartHour,StartMinute,EndHour,EndMinute,TimeCurrent())
            ){
               return(true);
            }
         return(false);
      }
   return(true);
}
       
bool fTimeInZone(int aStartHour,int aStartMinute,int aEndHour,int aEndMinute,datetime aTimeNow){
   int tStartTime=3600*aStartHour+60*aStartMinute;
   int tEndTime=3600*aEndHour+60*aEndMinute;
   datetime tTimeNow=aTimeNow-86400*(aTimeNow/86400);
      if(tStartTime<=tEndTime){
         if(tTimeNow>=tStartTime && tTimeNow<tEndTime){
            return(true);
         }
      }
      else{
         if(tTimeNow>=tStartTime || tTimeNow<tEndTime){
            return(true);
         }
      }
   return(false);
}   