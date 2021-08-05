//+------------------------------------------------------------------+
//|                                                  PanelDialog.mqh |
//|                   Copyright 2009-2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Dependencies\Signupcustomdialog.mqh"
#include <Controls\Label.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\Picture.mqh>
#resource "Dependencies\\res\\Trial.bmp"
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (10)      // gap by X coordinate
#define CONTROLS_GAP_Y                      (10)      // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
//+------------------------------------------------------------------+
//| Class CPanelDialog2                                               |
//| Usage: main dialog of the SimplePanel application                |
//+------------------------------------------------------------------+
int SignUpParentWindow_Width=0;
int SignUpParentWindow_Height=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CPanelDialog2 : public CAppDialog2
  {
private:

   CPicture          signup_pic_logo;
public:
                     CPanelDialog2(void);
                    ~CPanelDialog2(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   //virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateLabel(void);
   bool              CreateEdit(void);
   bool              CreateButton(void);
   //--- handlers of the dependent controls events
   void              OnClick_signup_btn_signup(void);
   void              OnClick_signup_btn_clear(void);
  };
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPanelDialog2::CPanelDialog2(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPanelDialog2::~CPanelDialog2(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CPanelDialog2::Create(const long chart,const string name,const int subwin,const int x1,const int y1,int x2,const int y2)
  {
   SignUpParentWindow_Width=x2-x1;
   SignUpParentWindow_Height=y2-y1;
   if(SignUpParentWindow_Width<465)
     {
      SignUpParentWindow_Width=465;
      x2=465;
     }
   if(!CAppDialog2::Create(chart,name,subwin,x1,y1+2,x2,y2+2))
      return(false);

////--- create dependent controls
   if(!CreateLabel())
      return(false);;
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CPanelDialog2::CreateLabel(void)
  {
// ParentWindow_Width=x2-x1;
//ParentWindow_Height=y2-y1;

   int TotalWidth=SignUpParentWindow_Width;
   int TotalHeight=SignUpParentWindow_Height;

   int requiredwidth=((TotalWidth-465)/2)-4;
   int requiredheight=((TotalHeight-303)/3);

   int label_width=TotalWidth;
   int label_height=TotalHeight;

   int label_x1=requiredwidth;
   int label_y1= requiredheight;
   int label_x2=label_x1+label_width;
   int label_y2=label_y1+label_height;

   string fontname="Calibri";
   int fontsize=13;
   color fontcolor=clrWhite;

//////--- create
   if(!signup_pic_logo.Create(m_chart_id,m_name+"signup_pic_logo",m_subwin,label_x1,(label_y1*1)+8,0,0))
      return(false);
   if(!signup_pic_logo.BmpName("::Dependencies\\res\\Trial.bmp"))
      return(false);
   if(!Add(signup_pic_logo))
      return(false);
   signup_pic_logo.Font(fontname);
   signup_pic_logo.FontSize(1);
   signup_pic_logo.Color(clrRed);
   signup_pic_logo.Show();
   signup_pic_logo.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   return(true);
  }
//+------------------------------------------------------------------+
