//+------------------------------------------------------------------+
//|                                                cm trend info.mq4 |
//|                                Copyright 2014, cmillion@narod.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, cmillion@narod.ru"
#property link      "cmillion@narod.ru"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   for(int j=0; j<ObjectsTotal(); j++)
     {
      string name=ObjectName(j);
      if(ObjectType(name)!=OBJ_TREND) continue;
      datetime t1=(datetime)ObjectGet(name,OBJPROP_TIME1);
      double p1=ObjectGet(name,OBJPROP_PRICE1);
      string txt=StringConcatenate(" Trend ",DoubleToStr((p1-ObjectGet(name,OBJPROP_PRICE2))/Point,0),"p.");

      color c=(color)ObjectGet(name,OBJPROP_COLOR);
      name=StringConcatenate(name," t");
      ObjectDelete(0,name);
      TextCreate(0,name,0,t1,p1,txt,"Arial",8,c);
     }
   return(rates_total);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool TextCreate(const long              chart_ID=0,               // ID �������
                const string            name="Text",              // ��� �������
                const int               sub_window=0,             // ����� �������
                datetime                time=0,                   // ����� ����� ��������
                double                  price=0,                  // ���� ����� ��������
                const string            text="Text",              // ��� �����
                const string            font="Arial",             // �����
                const int               font_size=10,             // ������ ������
                const color             clr=clrRed,               // ����
                const double            angle=0.0,                // ������ ������
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // ������ ��������
                const bool              back=false,               // �� ������ �����
                const bool              selection=false,          // �������� ��� �����������
                const bool              hidden=true,              // ����� � ������ ��������
                const long              z_order=0)                // ��������� �� ������� �����
  {
   ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": �� ������� ������� ������ \"�����\"! ��� ������ = ",GetLastError());
      return(false);
     }
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }
//+------------------------------------------------------------------+
