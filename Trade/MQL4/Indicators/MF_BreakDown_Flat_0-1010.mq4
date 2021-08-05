//+-------------------------------------------------------------------+
//|                                       MF_BreakDown_Flat 0-1010.mq4|
//|                                       Copyright c YuraZZhunko     |
//|                                       �F YURAZ     yzh@mail.ru    |
//|19.12.2006                             �F ZHUNKO zhunko@mail.ru    |
//+-------------------------------------------------------------------+
//| ������������ ��������� ��������� �����.                           |
//| ������ ��� ������������� ������� ������ ������.                   |
//| ��� �������� ����� ����� �������.                                 |
//| �������� �� ��, ������ ���� ��� ������� ������ � ���������        |
//| ��������� ��� ������ ����� �����.                                 |
//+-------------------------------------------------------------------+
//|                                                                   |
//|                     ��������� � ����������.                       |
//| 1.��������� � MF_BreakDown_Flat 0-1010 21.12.2006 .               |
//| 1.1.����������� ����.                                             |
//+-------------------------------------------------------------------+
#property copyright "Copyright c 2006 YuraZ-Zhunko"
#property link      "yzh@mail.ru ; zhunko@mail.ru"
//----
#property indicator_chart_window
//----------------------------------------------------------------------
extern int    ����=10;                  // ������� ���� � ������� ����������.
extern string sTimeEndAsia=" 07:00:00"; // �� ������ ������ ���� �������.
extern int    m7=7;                     // ��� ��������� ���� ���������.
extern string sTimeEndEur =" 10:00:00"; // ����� �� �������� �� ������ ����.
//----------------------------------------------------------------------
double   Max, Max1, Min, Min1;
double   Max2, Min2;
int      BarsDay; // ���������� ����� �� ����
string   noR="yzR";
string   noS="yzS";
string   noP="yzP";
int      mMonth ;
int      mYear  ;
int      mDay   ;
datetime mDatBegin;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int init()
  {
   mDatBegin=StrToTime (StringConcatenate (TimeToStr (TimeCurrent(), TIME_DATE), " 00:00:00")) - (���� * 86400);
   for( mYear =0; mDatBegin < TimeCurrent();  mDatBegin+=86400 )
     {
      mYear =TimeYear (mDatBegin);
      mMonth=TimeMonth (mDatBegin);
      mDay  =TimeDay (mDatBegin);
//----
      string d=StringConcatenate (DoubleToStr (mYear,0), ".", DoubleToStr (mMonth, 0), ".", DoubleToStr (mDay , 0), " ", "07:00");
      ObjectCreate(noR+d, OBJ_TREND, 0, 0,0, 0,0,0,0); // Res �������������
      ObjectCreate(noS+d, OBJ_TREND, 0, 0,0, 0,0,0,0); // ����� 
      ObjectCreate(noP+d, OBJ_TREND, 0, 0,0, 0,0,0,0); // Sup ���������
     }
  }
//+------------------------------------------------------------------+
int start()
  {
   string d;
   if (����==0)  ����=1;
   if (����>=100)����=100;
//----
   mDatBegin=StrToTime (StringConcatenate (TimeToStr (TimeCurrent(), TIME_DATE), " 00:00:00")) - (���� * 86400);
   for(mYear =0; mDatBegin < TimeCurrent();  mDatBegin+=86400 )
     {
      mYear =TimeYear( mDatBegin);
      mMonth=TimeMonth( mDatBegin);
      mDay  =TimeDay( mDatBegin);
//----
      d=StringConcatenate (DoubleToStr (mYear,0), ".", DoubleToStr (mMonth, 0), ".", DoubleToStr (mDay , 0), " 07:00"); // sTimeEndAsia; // " " + ;
      ObjectCreate (noR + d, OBJ_TREND, 0, 0,0, 0,0,0,0); // Res �������������
      ObjectCreate (noS + d, OBJ_TREND, 0, 0,0, 0,0,0,0); // ����� 
      ObjectCreate (noP + d, OBJ_TREND, 0, 0,0, 0,0,0,0); // Sup ���������
     }
   mDatBegin=StrToTime (StringConcatenate (TimeToStr (TimeCurrent(), TIME_DATE), " 00:00:00")) - (���� * 86400);
//----
   for(mYear =0; mDatBegin < CurTime();  mDatBegin+=86400 )
     {
      mYear =TimeYear (mDatBegin);
      mMonth=TimeMonth (mDatBegin);
      mDay  =TimeDay (mDatBegin);
//----
      datetime ���������������������= TimeCurrent();
      string str���������������������=TimeToStr (���������������������, TIME_DATE|TIME_MINUTES|TIME_SECONDS);
      if (TimeHour (���������������������) < m7)
        {
         sTimeEndAsia  =StringConcatenate (" ", DoubleToStr (TimeHour (���������������������), 0), ":", DoubleToStr (TimeMinute (���������������������), 0), ":00");
        }
//----
      str���������������������=StringConcatenate (DoubleToStr (mYear, 0), ".", DoubleToStr (mMonth, 0), ".", DoubleToStr (mDay , 0), " ", sTimeEndAsia);
      // ���� ����� �������� ������ ��� �� ������ �����
      //  ���� ����� ���
      //   � ����� � ���� ����� �� 0 - 7 ����
      string strTimeBegASIA=StringConcatenate (StringSubstr (str���������������������, 0, 10), " 00:00:00");
      string strTimeEndASIA=StringConcatenate (StringSubstr (str���������������������, 0, 10), sTimeEndAsia);
      string sTimeEndEUR   =StringConcatenate (StringSubstr (str���������������������, 0, 10), sTimeEndEur);
//----
      int BarsDay1=iBarShift (Symbol(), 0 , StrToTime (strTimeBegASIA), false);
      int BarsDay2=iBarShift (Symbol(), 0 , StrToTime (strTimeEndASIA), false);
      BarsDay=BarsDay1 - BarsDay2;
      int i;
      int h1=iHighest (Symbol(), 0 , MODE_HIGH, BarsDay , BarsDay2) ;
      int l1=iLowest (Symbol(), 0 , MODE_HIGH, BarsDay , BarsDay2) ;
//-----
      Max1=High[h1];
      Min1=Low[l1];
      i=iLowest (Symbol(), 0, MODE_LOW, BarsDay , BarsDay2) ;
      Max2=High[i];
      Min2=Low[i];
      // Comment(" a "+TimeToStr(TimeCurrent( )) + "    "+Max1+" "+Min1+" "+Max2+" "+Min2+" "+BarsDay+" 1 "+BarsDay1+" 2 "+BarsDay2 );
      mYear =TimeYear (mDatBegin);
      mMonth=TimeMonth (mDatBegin);
      mDay  =TimeDay (mDatBegin);
      d=StringConcatenate (DoubleToStr (mYear, 0), ".", DoubleToStr (mMonth, 0), ".", DoubleToStr (mDay, 0), " 07:00");
//----
      ObjectSet (noR + d, OBJPROP_RAY, false);
      ObjectSet (noR + d, OBJPROP_COLOR, OrangeRed);
      ObjectSet (noR + d, OBJPROP_TIME1, StrToTime (strTimeBegASIA ));
      ObjectSet (noR + d, OBJPROP_PRICE1, Max1);
      ObjectSet (noR + d, OBJPROP_TIME2, StrToTime (sTimeEndEUR));
      ObjectSet (noR + d, OBJPROP_PRICE2, Max1);
      //
      ObjectSet (noP + d, OBJPROP_RAY,false);
      ObjectSet (noP + d, OBJPROP_COLOR,OrangeRed);
      ObjectSet (noP + d, OBJPROP_TIME1, StrToTime (strTimeBegASIA));
      ObjectSet (noP + d, OBJPROP_PRICE1, Min2 + (Max1 - Min2)/2);
      ObjectSet (noP + d, OBJPROP_TIME2, StrToTime (strTimeEndASIA));
      ObjectSet (noP + d, OBJPROP_PRICE2, Min2 + (Max1 - Min2)/2);
      //
      ObjectSet (noS + d, OBJPROP_RAY, false);
      ObjectSet (noS + d, OBJPROP_COLOR, SandyBrown);
      ObjectSet (noS + d, OBJPROP_TIME1, StrToTime (strTimeBegASIA));
      ObjectSet (noS + d, OBJPROP_PRICE1, Min2);
      ObjectSet (noS + d, OBJPROP_TIME2, StrToTime (sTimeEndEUR));
      ObjectSet (noS + d, OBJPROP_PRICE2, Min2);
     }
   return(0);
  }
//+------------------------------------------------------------------+