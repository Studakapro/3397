//+------------------------------------------------------------------+
//|                                                  CGTrendline.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include "CGraphBase.mqh"
//+------------------------------------------------------------------+
//|  ����� ��� ������ � ��������� ������ (Trendline)                 |
//+------------------------------------------------------------------+
class CGTrendline
  {
private:
   string            m_name;                                               // object name
   long              m_id;                                                 // chart ID
   int               m_subwin;                                             // subwindow index
   bool              m_created;                                            // true if object created
   //
   datetime          m_time1;                                              // ������ (�����) ���������� �������
   double            m_price1;                                             // ������ (�����) ���������� ����
   datetime          m_time2;                                              // ������ (������) ���������� �������
   double            m_price2;                                             // ������ (������) ���������� ����
   color             m_color;                                              // ���� ��������� �����
   ENUM_LINE_STYLE   m_style;                                              // ����� ��������� �����
   int               m_width;                                              // ������� ��������� �����
   bool              m_back;                                               // �� ������ �����
   bool              m_selected;                                           // �������� ��� �����������
   bool              m_selectable;                                         // ����������� ���������
   bool              m_ray_right;                                          // ����������� ����� ������
   bool              m_hidden;                                             // ����� � ������ ��������
   long              m_zorder;                                             // ��������� �� ������� �����
   CGraphBase        *m_graph_base;                                        // pointer to CGraphPrimitives
public:
   CGTrendline(string aName,long aID=0,int aSubWin=0);
   ~CGTrendline();
   // �������
   void              Create(void);                                         // �������� ��������� �����
   void              DeleteTrend(void);                                    // �������� ��������� �����                                             
   void              SetLeftPos(datetime aTime,double aPrice);             // ��������� ����� ���������
   void              SetRightPos(datetime aTime,double aPrice);            // ��������� ������ ���������
   void              SetPositions(datetime aTime1,double aPrice1,datetime aTime2,double aPrice2);
   void              SetColor(color aColor=clrRed);                        // ��������� �����
   void              SetStyle(ENUM_LINE_STYLE aStyle=STYLE_SOLID);         // ��������� �����
   void              SetWidth(int aWidth=1);                               // ��������� ������� �����
   void              SetBack(bool aValue=false);                           // �������� ���� �� ���������
   void              SetSelected(bool aValue=false);                       // ��������� �������
   void              SetSelectable(bool aValue=true);                      // ��������� ����������� ���������
   void              SetRay(bool aValue=false);                            // setting rays right/left
   void              SetHidden(bool aValue=false);                         // ������� � ������ ��������
   void              SetZOrder(long aValue=0);                             // ������� ���������� ������� �����
   // �������
   string            Name(void) {return(m_name);}                          // �������� ���
   bool              Selected(void);                                       // �������� ������� �����������
   double            PriceByTime(datetime aTime);                          // �������� �������� ���� �� �������
  };
//+------------------------------c------------------------------------+
//| �����������                                                      |
//+------------------------------------------------------------------+
CGTrendline::CGTrendline(string aName,long aID=0,int aSubWin=0)
  {
   m_created=false;
   m_name=aName;
   m_id=aID;
   m_subwin=aSubWin;
   m_graph_base=new CGraphBase(m_name,m_id,m_subwin,true);
  }
//+------------------------------------------------------------------+
//| �������� ������� TrendLine                                       |
//+------------------------------------------------------------------+
void CGTrendline::Create(void)
  {
   m_created=false;
   if(m_graph_base.CreateTrend())
      m_created=true;
  }
//+------------------------------------------------------------------+
//| ����������                                                       |
//+------------------------------------------------------------------+
CGTrendline::~CGTrendline()
  {
   delete m_graph_base;
  }
//+------------------------------------------------------------------+
//| ��������� ����� ���������                                        |
//+------------------------------------------------------------------+
void CGTrendline::SetLeftPos(datetime aTime,double aPrice)
  {
   if(m_created)
     {
      m_time1=aTime;
      m_price1=aPrice;
      m_graph_base.SetTimePrice(0,m_time1,m_price1);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������ ���������                                       |
//+------------------------------------------------------------------+
void CGTrendline::SetRightPos(datetime aTime,double aPrice)
  {
   if(m_created)
     {
      m_time2=aTime;
      m_price2=aPrice;
      m_graph_base.SetTimePrice(1,m_time2,m_price2);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ���� ���������                                         |
//+------------------------------------------------------------------+
void CGTrendline::SetPositions(datetime aTime1,double aPrice1,datetime aTime2,double aPrice2)
  {
   SetLeftPos(aTime1,aPrice1);
   SetRightPos(aTime2,aPrice2);
  }
//+------------------------------------------------------------------+
//| �������� ��������� �����                                         |
//+------------------------------------------------------------------+
void CGTrendline::DeleteTrend(void)
  {
   if(m_created)
      m_graph_base.Delete();
  }
//+------------------------------------------------------------------+
//| ��������� �����                                                  |
//+------------------------------------------------------------------+
void CGTrendline::SetColor(color aColor=255)
  {
   if(m_created)
     {
      //Print("��������� �����.");
      m_color=aColor;
      m_graph_base.SetColor(m_color);
     }
  }
//+------------------------------------------------------------------+
//| Setting Rays right/left                                          |
//+------------------------------------------------------------------+
void CGTrendline::SetRay(bool aValue=false)
  {
   if(m_created)
     {
      m_ray_right=aValue;
      m_graph_base.SetRayRight(m_ray_right);
     }
  }
//+------------------------------------------------------------------+
//| ��������� �����                                                  |
//+------------------------------------------------------------------+
void CGTrendline::SetStyle(ENUM_LINE_STYLE aStyle=0)
  {
   if(m_created)
     {
      //Print("��������� �����.");
      m_style=aStyle;
      m_graph_base.SetStyle(m_style);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������                                                 |
//+------------------------------------------------------------------+
void CGTrendline::SetWidth(int aWidth=1)
  {
   if(m_created)
     {
      m_width=aWidth;
      m_graph_base.SetWidth(m_width);
     }
  }
//+------------------------------------------------------------------+
//| ��������� �� ��������/������ ����                                |
//+------------------------------------------------------------------+
void CGTrendline::SetBack(bool aValue=false)
  {
   if(m_created)
     {
      m_back=aValue;
      m_graph_base.SetBack(m_back);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ���������                                              |
//+------------------------------------------------------------------+
void CGTrendline::SetSelected(bool aValue=false)
  {
   if(m_created)
     {
      m_selected=aValue;
      m_graph_base.SetSelected(m_selected);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ����������� ���������                                  |
//+------------------------------------------------------------------+
void CGTrendline::SetSelectable(bool aValue=true)
  {
   if(m_created)
     {
      m_selectable=aValue;
      m_graph_base.SetSelectable(m_selectable);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ������� � ������ ��������                              |
//+------------------------------------------------------------------+
void CGTrendline::SetHidden(bool aValue=false)
  {
   if(m_created)
     {
      m_hidden=aValue;
      m_graph_base.SetHidden(m_hidden);
     }
  }
//+------------------------------------------------------------------+
//| ��������� ���������� �� ������ ����                              |
//+------------------------------------------------------------------+
void CGTrendline::SetZOrder(long aValue=0)
  {
   if(m_created)
     {
      m_zorder=aValue;
      m_graph_base.SetZOrder(m_zorder);
     }
  }
//+------------------------------------------------------------------+
