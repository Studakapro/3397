//+------------------------------------------------------------------+
//|                                                  PanelDialog.mqh |
//|                   Copyright 2009-2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include "Dependencies\Signincustomdialog.mqh"
#include <Controls\Label.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
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
//| Class CPanelDialog3                                               |
//| Usage: main dialog of the SimplePanel application                |
//+------------------------------------------------------------------+
int SignInParentWindow_Width=0;
int SignInParentWindow_Height=0;
//int getsecondx=0;
class CPanelDialog3 : public CAppDialog3
  {
public:
   CLabel            signin_lbl_existusertitle;
   CLabel            signin_lbl_email;
   CLabel            signin_lbl_password;
   CLabel            signin_lbl_forgettitle;
   CLabel            signin_lbl_forgetemail;
   CLabel            signin_lbl_error1;

   CEdit             signin_txt_email;
   CEdit             signin_txt_password;
   CEdit             signin_txt_forgetemail;

   CButton           signin_btn_signin;
   CButton           signin_btn_clear;
   CButton           signin_up_btn;
   CButton           signin_btn_forgetpassword;
   CButton           signin_btn_forgetpasswordsubmit;
   CButton           signin_btn_forgetpasswordcancel;

   CLabel            signin_up_lbl_newusertitle;
   CLabel            signin_up_lbl_name;
   CLabel            signin_up_lbl_email;
   CLabel            signin_up_lbl_password;
   CLabel            signin_up_lbl_country;
   CLabel            signin_up_lbl_error1;

   CEdit             signin_up_txt_name;
   CEdit             signin_up_txt_email;
   CEdit             signin_up_txt_password;
   CEdit             signin_up_txt_country;

   CButton           signin_up_btn_submit;
   CButton           signin_up_btn_clear;
   CButton           signin_btn_signin_link;

public:
                     CPanelDialog3(void);
                    ~CPanelDialog3(void);

   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateLabel(void);
   bool              CreateEdit(void);
   bool              CreateButton(void);
   //--- handlers of the dependent controls events
   //void              OnClick_signin_btn_signin(void);
   //void              OnClick_signin_btn_clear(void);
   //void              OnClick_signin_up_btn(void);
   //void              OnClick_signin_btn_forgetpassword(void);
   //void              OnClick_signin_btn_forgetpasswordsubmit(void);
   //void              OnClick_signin_btn_forgetpasswordcancel(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CPanelDialog3::CPanelDialog3(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CPanelDialog3::~CPanelDialog3(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CPanelDialog3::Create(const long chart,const string name,const int subwin,int x1,const int y1,int x2,const int y2)
  {
//   int GetWindow_Width=x2-x1;
//   int GetWindow_Height=y2-y1;
//   Print(GetWindow_Width);
//    if(GetWindow_Width <  543)
//    {
//       x1=0;
//       //x2=543;
//    }
//    
   if(!CAppDialog3::Create(chart,name,subwin,x1,y1+8,x2,y2-10))
      return(false);
// SignInParentWindow_Width=x2-x1;
// SignInParentWindow_Height=y2-y1;

//int getsecondwidth = x2-x1;

//getsecondx= getsecondwidth;

// Print("getsecondwidth="+getsecondwidth);

//  Print("getsecondx="+getsecondx);

   SignInParentWindow_Width=465;
   SignInParentWindow_Height=400;
// Print("SignInParentWindow_Width="+SignInParentWindow_Width);
// Print("SignInParentWindow_Height="+SignInParentWindow_Height);
////--- create dependent controls
   if(!CreateLabel())
      return(false);
   if(!CreateEdit())
      return(false);
   if(!CreateButton())
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CPanelDialog3::CreateLabel(void)
  {
   int TotalWidth=SignInParentWindow_Width;
   int TotalHeight=SignInParentWindow_Height;

   int requiredwidth=TotalWidth/16;
   int requiredheight=(TotalHeight/10);

   int label_width=100;
   int label_height=30;

   int label_x1=requiredwidth;
   int label_y1= requiredheight;
   int label_x2=label_x1+label_width;
   int label_y2=label_y1+label_height;

   string fontname="Calibri";
   int fontsize=13;

////--- create
   if(!signin_lbl_existusertitle.Create(m_chart_id,m_name+"signin_lbl_existusertitle",m_subwin,label_x1-30,(label_y1-30),label_x2,label_y2))
      return(false);
   if(!signin_lbl_existusertitle.Text("Existing User "))
      return(false);
   if(!Add(signin_lbl_existusertitle))
      return(false);
   signin_lbl_existusertitle.Font(fontname);
   signin_lbl_existusertitle.FontSize(fontsize+3);
   signin_lbl_existusertitle.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_lbl_existusertitle.Visible(true);
//--- succeed

////--- create
   if(!signin_lbl_email.Create(m_chart_id,m_name+"signin_lbl_email",m_subwin,label_x1,(label_y1*2)-30,label_x2,label_y2))
      return(false);
   if(!signin_lbl_email.Text("Email ID "))
      return(false);
   if(!Add(signin_lbl_email))
      return(false);
   signin_lbl_email.Font(fontname);
   signin_lbl_email.FontSize(fontsize);
   signin_lbl_email.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_lbl_email.Visible(true);
//--- succeed
//--- create
   if(!signin_lbl_password.Create(m_chart_id,m_name+"signin_lbl_password",m_subwin,label_x1,(label_y1*3)-30,label_x2,label_y2))
      return(false);
   if(!signin_lbl_password.Text("Password "))
      return(false);
   if(!Add(signin_lbl_password))
      return(false);
   signin_lbl_password.Font(fontname);
   signin_lbl_password.FontSize(fontsize);
   signin_lbl_password.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_lbl_password.Visible(true);
////--- succeed
//--- create
   if(!signin_lbl_forgettitle.Create(m_chart_id,m_name+"signin_lbl_forgettitle",m_subwin,label_x1-30,(label_y1*5)-30,label_x2,label_y2))
      return(false);
   if(!signin_lbl_forgettitle.Text("Forgot Password"))
      return(false);
   if(!Add(signin_lbl_forgettitle))
      return(false);
   signin_lbl_forgettitle.Font(fontname);
   signin_lbl_forgettitle.FontSize(fontsize+3);
   signin_lbl_forgettitle.Visible(false);
   signin_lbl_forgettitle.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_lbl_forgettitle.Visible(false);
////--- succeed
////--- create
   if(!signin_lbl_forgetemail.Create(m_chart_id,m_name+"signin_lbl_forgetemail",m_subwin,label_x1,(label_y1*6)-30,label_x2,label_y2))
      return(false);
   if(!signin_lbl_forgetemail.Text("Email ID "))
      return(false);
   if(!Add(signin_lbl_forgetemail))
      return(false);
   signin_lbl_forgetemail.Font(fontname);
   signin_lbl_forgetemail.FontSize(fontsize);
   signin_lbl_forgetemail.Visible(false);
   signin_lbl_forgetemail.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_lbl_forgetemail.Visible(false);
//--- succeed
//--- create
   if(!signin_lbl_error1.Create(m_chart_id,m_name+"signin_lbl_error1",m_subwin,(label_x1),(label_y1*8)-30,label_x2,label_y2))
      return(false);
   if(!signin_lbl_error1.Text(NULL))
      return(false);
   signin_lbl_error1.Color(clrRed);
   if(!Add(signin_lbl_error1))
      return(false);
   signin_lbl_error1.Font(fontname);
   signin_lbl_error1.FontSize(fontsize);
   signin_lbl_error1.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_lbl_error1.Visible(false);
////--- succeed

//Signup process *************************************************
   requiredwidth=TotalWidth/16;
   requiredheight=(TotalHeight/8);

   label_width=100;
   label_height=30;

   label_x1=requiredwidth;
   label_y1= requiredheight;
   label_x2=label_x1+label_width;
   label_y2=label_y1+label_height;

////--- create
   if(!signin_up_lbl_newusertitle.Create(m_chart_id,m_name+"signin_up_lbl_newusertitle",m_subwin,label_x1-30,(label_y1-60),label_x2,label_y2))
      return(false);
   if(!signin_up_lbl_newusertitle.Text("New User "))
      return(false);
   if(!Add(signin_up_lbl_newusertitle))
      return(false);
   signin_up_lbl_newusertitle.Font(fontname);
   signin_up_lbl_newusertitle.FontSize(fontsize+3);
   signin_up_lbl_newusertitle.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_lbl_newusertitle.Visible(false);
//--- succeed

////--- create
   if(!signin_up_lbl_name.Create(m_chart_id,m_name+"signin_up_lbl_name",m_subwin,label_x1,(label_y1*2)-70,label_x2,label_y2))
      return(false);
   if(!signin_up_lbl_name.Text("Name "))
      return(false);
   if(!Add(signin_up_lbl_name))
      return(false);
   signin_up_lbl_name.Font(fontname);
   signin_up_lbl_name.FontSize(fontsize);
   signin_up_lbl_name.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_lbl_name.Visible(false);
//--- succeed
//--- create
   if(!signin_up_lbl_email.Create(m_chart_id,m_name+"signin_up_lbl_email",m_subwin,label_x1,(label_y1*3)-70,label_x2,label_y2))
      return(false);
   if(!signin_up_lbl_email.Text("Email "))
      return(false);
   if(!Add(signin_up_lbl_email))
      return(false);
   signin_up_lbl_email.Font(fontname);
   signin_up_lbl_email.FontSize(fontsize);
   signin_up_lbl_email.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_lbl_email.Visible(false);
////--- succeed
//--- create
   if(!signin_up_lbl_password.Create(m_chart_id,m_name+"signin_up_lbl_password",m_subwin,label_x1,(label_y1*4)-70,label_x2,label_y2))
      return(false);
   if(!signin_up_lbl_password.Text("Password "))
      return(false);
   if(!Add(signin_up_lbl_password))
      return(false);
   signin_up_lbl_password.Font(fontname);
   signin_up_lbl_password.FontSize(fontsize);
   signin_up_lbl_password.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_lbl_password.Visible(false);
////--- succeed

//--- create
   if(!signin_up_lbl_country.Create(m_chart_id,m_name+"signin_up_lbl_country",m_subwin,label_x1,(label_y1*5)-70,label_x2,label_y2))
      return(false);
   if(!signin_up_lbl_country.Text("Country "))
      return(false);
   if(!Add(signin_up_lbl_country))
      return(false);
   signin_up_lbl_country.Font(fontname);
   signin_up_lbl_country.FontSize(fontsize);
   signin_up_lbl_country.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_lbl_country.Visible(false);
////--- succeed

//--- create
   if(!signin_up_lbl_error1.Create(m_chart_id,m_name+"signin_up_lbl_error1",m_subwin,label_x1,(label_y1*7)-45,label_x2,label_y2))
      return(false);
   if(!signin_up_lbl_error1.Text(NULL))
      return(false);
   if(!Add(signin_up_lbl_error1))
      return(false);
   signin_up_lbl_error1.Color(clrRed);
   signin_up_lbl_error1.Font(fontname);
   signin_up_lbl_error1.FontSize(fontsize);
   signin_up_lbl_error1.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_lbl_error1.Visible(false);
////--- succeed

   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CPanelDialog3::CreateEdit(void)
  {
   int TotalWidth=SignInParentWindow_Width;
   int TotalHeight=SignInParentWindow_Height;

   int requiredwidth=(TotalWidth/4);
   int requiredheight=((TotalHeight/10)-1);

   int label_width=260;
   int label_height=30;

   int label_x1=requiredwidth;
   int label_y1= requiredheight;
   int label_x2=label_x1+label_width;
   int label_y2=label_y1;

   string fontname="Calibri";
   int fontsize=15;

//--- create
   if(!signin_txt_email.Create(m_chart_id,m_name+"signin_txt_email",m_subwin,label_x1,(label_y1*2)-30,label_x2,((label_y2*2)+label_height-30)))
      return(false);
   if(!signin_txt_email.ReadOnly(false))
      return(false);
   if(!Add(signin_txt_email))
      return(false);
   signin_txt_email.Font(fontname);
   signin_txt_email.FontSize(fontsize);
   signin_txt_email.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_txt_email.Visible(true);
//--- succeed
//--- create
   if(!signin_txt_password.Create(m_chart_id,m_name+"signin_txt_password",m_subwin,label_x1,(label_y1*3)-30,label_x2,((label_y2*3)+label_height-30)))
      return(false);
   if(!signin_txt_password.ReadOnly(false))
      return(false);
   if(!Add(signin_txt_password))
      return(false);
   signin_txt_password.Font("MS Outlook");
   signin_txt_password.FontSize(fontsize);
   signin_txt_password.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_txt_password.Visible(true);
////--- succeed
//--- create
   if(!signin_txt_forgetemail.Create(m_chart_id,m_name+"signin_txt_forgetemail",m_subwin,label_x1,(label_y1*6)-30,label_x2,((label_y2*6)+label_height-30)))
      return(false);
   if(!signin_txt_forgetemail.ReadOnly(false))
      return(false);
   if(!Add(signin_txt_forgetemail))
      return(false);
   signin_txt_forgetemail.Font(fontname);
   signin_txt_forgetemail.FontSize(fontsize);
   signin_txt_forgetemail.Visible(false);
   signin_txt_forgetemail.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_txt_forgetemail.Visible(false);
////--- succeed

//signup process ***************************
   requiredwidth=(TotalWidth/4);
   requiredheight=((TotalHeight/8)-1);

   label_width=260;
   label_height=30;

   label_x1=requiredwidth;
   label_y1= requiredheight;
   label_x2=label_x1+label_width;
   label_y2=label_y1;

//--- create
   if(!signin_up_txt_name.Create(m_chart_id,m_name+"signin_up_txt_name",m_subwin,label_x1,(label_y1*1)-20,label_x2,((label_y2*1)+label_height-20)))
      return(false);
   if(!signin_up_txt_name.ReadOnly(false))
      return(false);
   if(!Add(signin_up_txt_name))
      return(false);
   signin_up_txt_name.Font(fontname);
   signin_up_txt_name.FontSize(fontsize);
   signin_up_txt_name.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_txt_name.Visible(false);
//--- succeed
//--- create
   if(!signin_up_txt_email.Create(m_chart_id,m_name+"signin_up_txt_email",m_subwin,label_x1,(label_y1*2)-20,label_x2,((label_y2*2)+label_height-20)))
      return(false);
   if(!signin_up_txt_email.ReadOnly(false))
      return(false);
   if(!Add(signin_up_txt_email))
      return(false);
   signin_up_txt_email.Font(fontname);
   signin_up_txt_email.FontSize(fontsize);
   signin_up_txt_email.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_txt_email.Visible(false);
//--- succeed
//--- create
   if(!signin_up_txt_password.Create(m_chart_id,m_name+"signin_up_txt_password",m_subwin,label_x1,(label_y1*3)-20,label_x2,((label_y2*3)+label_height-20)))
      return(false);
   if(!signin_up_txt_password.ReadOnly(false))
      return(false);
   if(!Add(signin_up_txt_password))
      return(false);
   signin_up_txt_password.Font("MS Outlook");
   signin_up_txt_password.FontSize(fontsize);
   signin_up_txt_password.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_txt_password.Visible(false);
//--- succeed

//--- create
   if(!signin_up_txt_country.Create(m_chart_id,m_name+"signin_up_txt_country",m_subwin,label_x1,(label_y1*4)-20,label_x2,((label_y2*4)+label_height-20)))
      return(false);
   if(!signin_up_txt_country.ReadOnly(false))
      return(false);
   if(!Add(signin_up_txt_country))
      return(false);
   signin_up_txt_country.Font(fontname);
   signin_up_txt_country.FontSize(fontsize);
   signin_up_txt_country.Alignment(WND_ALIGN_WIDTH,INDENT_LEFT,0,INDENT_RIGHT+BUTTON_WIDTH+CONTROLS_GAP_X,0);
   signin_up_txt_country.Visible(false);
//--- succeed

   return(true);
  }
color str_color3=StringToColor("55,180,224");
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CPanelDialog3::CreateButton(void)
  {
   int TotalWidth=SignInParentWindow_Width;
   int TotalHeight=SignInParentWindow_Height;

   int requiredwidth=(TotalWidth/4);
   int requiredheight=((TotalHeight/10)-1);

   int label_width=125;
   int label_height=30;

   int label_x1=requiredwidth;
   int label_y1= requiredheight;
   int label_x2=label_x1+label_width;
   int label_y2=label_y1;

   string fontname="Calibri";
   int fontsize=12;

//--- create
   if(!signin_btn_signin.Create(m_chart_id,m_name+"signin_btn_signin",m_subwin,label_x1,(label_y1*4)-30,label_x2,((label_y2*4)+label_height-30)))
      return(false);
   if(!signin_btn_signin.Text("SIGN IN"))
      return(false);
   if(!Add(signin_btn_signin))
      return(false);
   signin_btn_signin.ColorBackground(str_color3);
   signin_btn_signin.Color(clrWhite);
   signin_btn_signin.ColorBorder(clrWhite);
   signin_btn_signin.Font(fontname);
   signin_btn_signin.FontSize(fontsize);
   signin_btn_signin.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
   signin_btn_signin.Visible(true);
////--- succeed
////--- create
   if(!signin_btn_clear.Create(m_chart_id,m_name+"signin_btn_clear",m_subwin,label_x1+130,(label_y1*4)-30,(label_x2+130),((label_y2*4)+label_height-30)))
      return(false);
   if(!signin_btn_clear.Text("CLEAR"))
      return(false);
   signin_btn_clear.Left(signin_btn_clear.Left()+5);
   if(!Add(signin_btn_clear))
      return(false);
   signin_btn_clear.ColorBackground(clrWhite);
   signin_btn_clear.Color(str_color3);
   signin_btn_clear.ColorBorder(str_color3);
   signin_btn_clear.Font(fontname);
   signin_btn_clear.FontSize(fontsize);
   signin_btn_clear.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
   signin_btn_clear.Visible(true);

//--- succeed
////--- create
   if(!signin_btn_forgetpassword.Create(m_chart_id,m_name+"signin_btn_forgetpassword",m_subwin,label_x1,(label_y1*6)-30,label_x2+130,((label_y2*6)+label_height-30)))
      return(false);
   if(!signin_btn_forgetpassword.Text("Forgot Your Password?"))
      return(false);
   if(!Add(signin_btn_forgetpassword))
      return(false);
   signin_btn_forgetpassword.ColorBackground(clrWhite);
   signin_btn_forgetpassword.Color(str_color3);
   signin_btn_forgetpassword.ColorBorder(clrWhite);
   signin_btn_forgetpassword.Font(fontname);
   signin_btn_forgetpassword.FontSize(fontsize);
   signin_btn_forgetpassword.Alignment(WND_ALIGN_RIGHT,0,0,0,0);
   signin_btn_forgetpassword.Visible(true);

//--- succeed
////--- create
   if(!signin_up_btn.Create(m_chart_id,m_name+"signin_up_btn",m_subwin,label_x1,(label_y1*5)-30,label_x2+130,((label_y2*5)+label_height-30)))
      return(false);
   if(!signin_up_btn.Text("Dont have an account ?"))
      return(false);
   if(!Add(signin_up_btn))
      return(false);
   signin_up_btn.ColorBackground(clrWhite);
   signin_up_btn.Color(str_color3);
   signin_up_btn.ColorBorder(clrWhite);
   signin_up_btn.Font(fontname);
   signin_up_btn.FontSize(fontsize);
   signin_up_btn.Alignment(WND_ALIGN_RIGHT,0,0,0,0);
   signin_up_btn.Visible(true);

//--- succeed
////--- create
   if(!signin_btn_forgetpasswordsubmit.Create(m_chart_id,m_name+"signin_btn_forgetpasswordsubmit",m_subwin,label_x1,(label_y1*7)-30,label_x2,((label_y2*7)+label_height-30)))
      return(false);
   if(!signin_btn_forgetpasswordsubmit.Text("RESET"))
      return(false);
   if(!Add(signin_btn_forgetpasswordsubmit))
      return(false);
   signin_btn_forgetpasswordsubmit.ColorBackground(str_color3);
   signin_btn_forgetpasswordsubmit.Color(clrWhite);
   signin_btn_forgetpasswordsubmit.ColorBorder(clrWhite);
   signin_btn_forgetpasswordsubmit.Font(fontname);
   signin_btn_forgetpasswordsubmit.FontSize(fontsize);
   signin_btn_forgetpasswordsubmit.Visible(false);
   signin_btn_forgetpasswordsubmit.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
   signin_btn_forgetpasswordsubmit.Visible(false);

//--- succeed
////--- create
   if(!signin_btn_forgetpasswordcancel.Create(m_chart_id,m_name+"signin_btn_forgetpasswordcancel",m_subwin,label_x1+134,(label_y1*7)-30,label_x2+134,((label_y2*7)+label_height-30)))
      return(false);
   if(!signin_btn_forgetpasswordcancel.Text("CLEAR"))
      return(false);
   if(!Add(signin_btn_forgetpasswordcancel))
      return(false);
   signin_btn_forgetpasswordcancel.ColorBackground(clrWhite);
   signin_btn_forgetpasswordcancel.Color(str_color3);
   signin_btn_forgetpasswordcancel.ColorBorder(str_color3);
   signin_btn_forgetpasswordcancel.Font(fontname);
   signin_btn_forgetpasswordcancel.FontSize(fontsize);
   signin_btn_forgetpasswordcancel.Visible(false);
   signin_btn_forgetpasswordcancel.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
   signin_btn_forgetpasswordcancel.Visible(false);
//--- succeed

//signup process ***************************
   requiredwidth=(TotalWidth/4);
   requiredheight=((TotalHeight/11)-1);

   label_width=125;
   label_height=30;

   label_x1=requiredwidth;
   label_y1= requiredheight;
   label_x2=label_x1+label_width;
   label_y2=label_y1;

//--- create
   if(!signin_up_btn_submit.Create(m_chart_id,m_name+"signin_up_btn_submit",m_subwin,label_x1,(label_y1*7)-20,label_x2,((label_y2*7)+label_height-20)))
      return(false);
   if(!signin_up_btn_submit.Text("SIGN UP"))
      return(false);
   if(!Add(signin_up_btn_submit))
      return(false);
   signin_up_btn_submit.ColorBackground(str_color3);
   signin_up_btn_submit.Color(clrWhite);
   signin_up_btn_submit.ColorBorder(clrWhite);
   signin_up_btn_submit.Font(fontname);
   signin_up_btn_submit.FontSize(fontsize);
   signin_up_btn_submit.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
   signin_up_btn_submit.Visible(false);
////--- succeed

////--- create
   if(!signin_up_btn_clear.Create(m_chart_id,m_name+"signin_up_btn_clear",m_subwin,label_x1+130,(label_y1*7)-20,(label_x2+130),((label_y2*7)+label_height-20)))
      return(false);
   if(!signin_up_btn_clear.Text("CLEAR"))
      return(false);
   signin_up_btn_clear.Left(signin_up_btn_clear.Left()+5);
   if(!Add(signin_up_btn_clear))
      return(false);
   signin_up_btn_clear.ColorBackground(clrWhite);
   signin_up_btn_clear.Color(str_color3);
   signin_up_btn_clear.ColorBorder(str_color3);
   signin_up_btn_clear.Font(fontname);
   signin_up_btn_clear.FontSize(fontsize);
   signin_up_btn_clear.Alignment(WND_ALIGN_RIGHT,0,0,INDENT_RIGHT,0);
   signin_up_btn_clear.Visible(false);

//--- succeed

////--- create
   if(!signin_btn_signin_link.Create(m_chart_id,m_name+"signin_btn_signin_link",m_subwin,label_x1,(label_y1*8)-10,label_x2+130,((label_y2*8)+label_height-10)))
      return(false);
   if(!signin_btn_signin_link.Text("Already have an account ?"))
      return(false);
   if(!Add(signin_btn_signin_link))
      return(false);
   signin_btn_signin_link.ColorBackground(clrWhite);
   signin_btn_signin_link.Color(str_color3);
   signin_btn_signin_link.ColorBorder(clrWhite);
   signin_btn_signin_link.Font(fontname);
   signin_btn_signin_link.FontSize(fontsize);
   signin_btn_signin_link.Alignment(WND_ALIGN_RIGHT,0,0,0,0);
   signin_btn_signin_link.Visible(false);
//--- succeed

   return(true);
  }
//+------------------------------------------------------------------+
