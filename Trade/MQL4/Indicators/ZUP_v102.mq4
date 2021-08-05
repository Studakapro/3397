
#property copyright "nen"
#property link      "http://www.onix-trade.net/forum/index.php?showtopic=118&view=findpost&p=419660"
// описание          http://onix-trade.net/forum/index.php?s=&showtopic=373&view=findpost&p=72865

#property stacksize 65535
#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 SkyBlue //Red 
#property indicator_width1 2
#property indicator_color2 Green
#property indicator_color3 Orange
#property indicator_color4 LightSkyBlue
#property indicator_color5 LemonChiffon
//#property indicator_color4 Chartreuse
//#property indicator_color5 Red
#property indicator_color6 Magenta //Yellow
#import "user32.dll"
int GetClientRect(int hWnd,int lpRect[]);
#import

// hmaryawan@gmail.com
string s_last_signal="";


#define pi  3.14159265
#define phi 1.61803399

//===================================
//---- indicator parameters
extern string ______________0_____________ = "Parameters for ZigZag";
extern int    ExtIndicator            = 11;
extern int    ParametresZZforDMLEWA   = 2;
extern int    minBars                 = 8;
extern int    minSize                 = 50;
// Переменные от ZigZag из МТ
extern int    ExtDeviation            = 5;
extern int    ExtBackstep             = 3;
// Переменная для nen-ZigZag
extern int    GrossPeriod             = 1440;
//----
extern double minPercent              = 0.0;         // 0.08
extern int    ExtPoint=11; // количество точек зигзага для зигзага Talex 
// Параметры для зигзага, разработанного wellx
extern int    StLevel                 = 28;
extern int    BigLevel                = 32; 
extern bool   auto                    = true;
extern double minBar=38.2, maxBar=61.8;

extern bool   ExtStyleZZ              = true;

extern int    ExtMaxBar               = 1000;     // Количество баров обсчёта (0-все)
extern int    ExtMinBar               = 0;
// вывод номеров переломов зигзагов
extern bool   ExtNumberPeak           = false;
extern bool   ExtNumberPeak10         = true;
extern bool   ExtNumberPeakLow        = true;
extern color  ExtNumberPeakColor      = Red;
extern int    ExtNumberPeakFontSize   = 11;

extern string ______________1_____________ = "Parameters for fibo Levels";
extern bool   ExtFiboDinamic          = false;
extern bool   ExtFiboStatic           = false;
extern int    ExtFiboStaticNum        = 2;
extern bool   ExtFiboCorrectionExpansion = false;
extern color  ExtFiboD                = Sienna;
extern color  ExtFiboS                = Teal;
extern int    ExtFiboStyle            = 2;
extern int    ExtFiboWidth            = 0;
//-------------------------------------

extern string ______________2_____________ = "Parameters for Pesavento Patterns";
extern int    ExtPPWithBars           = 0;
extern int    ExtHidden               = 1;
extern int    ExtFractal              = 7;
extern int    ExtFractalEnd           = 7;
extern int    ExtFiboChoice           = 2;
extern bool   ExtFiboZigZag           = false;
extern double ExtDelta                = 0.04;
extern int    ExtDeltaType            = 2;
extern int    ExtSizeTxt              = 7;
extern color  ExtLine                 = DarkBlue;
extern color  ExtLine886              = Purple;
extern color  ExtNotFibo              = SlateGray;
extern color  ExtPesavento            = Yellow;
extern color  ExtGartley886           = GreenYellow;
       color  colorPPattern;

// Паттерны Gartley
extern string ______________3_____________ = "Parameters for Gartley Patterns";
extern int    maxDepth                = 55;
extern int    minDepth                = 3;
extern int    IterationStep           = 2;
extern bool   DirectionOfSearchMaxMin = true;
extern int    NumberPattern           = 5;  // Номер паттерна, по которому калибруется зигзаг и параметры которого выводятся через InfoTF
extern int    ExtGartleyTypeSearch    = 0;
extern int    ExtHiddenPP             = 1;
extern bool   ExtGartleyOnOff         = false;
//extern int    VarDisplay=0;
extern int    maxBarToD               = 15;
extern bool   patternInfluence        = false;  // true; //
extern double AllowedBandPatternInfluence = 1.618;
extern int    RangeForPointD          = 2;
extern int    VectorOfAMirrorTrend    = 0; //2;
extern color  ExtColorRangeForPointD  = Red;
extern color  ExtLineForPointD_AB     = Aqua;
extern color  ExtLineForPointD_BC     = Gold;
extern color  ExtColorPatterns        = Blue;
extern string ExtColorPatternList     = "Blue,DarkGreen,Navy,Sienna,MediumBlue,RoyalBlue,DodgerBlue,CornflowerBlue,LightSkyBlue,SlateBlue,MediumSlateBlue,SlateGray,LightSteelBlue";
extern double ExtDeltaGartley         = 0.09;
extern double ExtCD                   = 0.886;
//---------------
extern bool   Equilibrium             = false; //true;
extern bool   ReactionType            = false;
extern int    EquilibriumStyle        = 1;
extern int    EquilibriumWidth        = 0;
extern color  ColorEquilibrium        = Red;
extern color  ColorReaction           = Yellow;
//--------------- Custom 5-Point Pattern
extern int    CustomPattern           = 0; // 0 - не выводится, 1 - выводится вместе с Gartley (используется только max)
                                           // 2 - выводится вместе с Gartley (используется и max и min)
                                           // 3 - выводится без Gartley, только custom (используется только max)
                                           // 4 - выводится без Gartley, только custom (используется и max и min)
extern double minXB                   = 0.382;  //0.5;
extern double maxXB                   = 0.942;  //0.618;
extern double minAC                   = 0.447;  //0.382;
extern double maxAC                   = 0.942;  //0.618;
extern double minBD                   = 1.144;  //1.128;
extern double maxBD                   = 2.128;  //1.272;
extern double minXD                   = 0.5;    //0.618;
extern double maxXD                   = 0.942;  //0.886;

//----------------------------------------------------------------------
// Комплект инструментов, работающих совместно с вилами Эндрюса. Начало.
//----------------------------------------------------------------------
// Переменные для вил Эндрюса
extern string ______________4_____________ = "Parameters for Andrews Pitchfork";
extern int    ExtPitchforkDinamic       = 0;
extern double ExtPitchforkDinamicCustom = 0;
extern color  ExtLinePitchforkD         = MediumSlateBlue;
extern int    ExtPitchforkStatic        = 0;
extern int    ExtPitchforkStaticNum     = 3;
extern double ExtPitchforkStaticCustom  = 0;
extern color  ExtLinePitchforkS         = MediumBlue; // DarkKhaki; //
extern int    ExtMasterPitchfork        = 0;
extern color  ExtPitchforkStaticColor   = CLR_NONE;
extern int    ExtPitchforkStyle         = 1;
extern int    ExtPitchforkWidth         = 0;

// Линии реакции RL
extern bool   ExtRLDinamic              = true;
extern int    ExtRLStyleDinamic         = 1;
extern bool   ExtVisibleRLDinamic       = true;
extern bool   ExtRLStatic               = true; // false; //
extern int    ExtRLStyleStatic          = 1;
extern bool   ExtVisibleRLStatic        = true;
extern bool   ExtRL146                  = true;
extern bool   ExtRLineBase              = true;

// RedZone для линий реакции
extern bool   ExtRedZoneDinamic         = false;
extern bool   ExtRedZoneStatic          = false;
extern double ExtRZDinamicValue         = 0;
extern double ExtRZStaticValue          = 0;
extern color  ExtRZDinamicColor         = Salmon;
extern color  ExtRZStaticColor          = Salmon;

// Внутренние Сигнальные Линии
extern bool   ExtISLDinamic             = true;
extern int    ExtISLStyleDinamic        = 1;
extern bool   ExtVisibleISLDinamic      = true;
extern bool   ExtISLStatic              = true;
extern int    ExtISLStyleStatic         = 1;
extern bool   ExtVisibleISLStatic       = true;
extern int    ExtISLWidth               = 0;
//extern color  ExtISLChannelDinamicColor = DarkViolet;
//extern color  ExtISLChannelStaticColor  = CadetBlue;
extern color  ExtISLChannelDinamicColor = CLR_NONE;
extern color  ExtISLChannelStaticColor  = DarkSlateGray; // CLR_NONE; //

// Сигнальные линии 50% медианы
extern bool   ExtSLMDinamic         = false;
extern color  ExtSLMDinamicColor    = MediumSlateBlue;
extern bool   ExtSLMStatic          = false; // true; //
extern color  ExtSLMStaticColor     = MediumBlue; // DarkKhaki; //
extern bool   ExtFSLShiffLinesDinamic      = false; // вывод линии FSL линий Шиффа для динамических вил Эндрюса
extern color  ExtFSLShiffLinesDinamicColor = MediumSlateBlue; // DarkKhaki; //
extern bool   ExtFSLShiffLinesStatic       = false; // true; // вывод линии FSL линий Шиффа для статических вил Эндрюса
extern color  ExtFSLShiffLinesStaticColor  = MediumBlue; // DarkKhaki; //

// Предупреждающие и Контрольные линии статических Вил Эндрюса
extern bool   ExtUTL        = false;
extern bool   ExtLTL        = false;
extern bool   ExtUWL        = false;
extern bool   ExtVisibleUWL = false;
extern bool   ExtLWL        = false;
extern bool   ExtVisibleLWL = false;
extern bool   ExtLongWL     = false;

// Разворотная зона Pivot Zone
extern color  ExtPivotZoneDinamicColor = CLR_NONE;
extern color  ExtPivotZoneStaticColor  = CLR_NONE;
extern bool   ExtPivotZoneFramework    = false;

// Переменные для построения вил Эндрюса от произвольных свечей
extern bool   ExtCustomStaticAP = false; // true; //
// Построение комплекта вил от выбранных свечей
//----------------------------------------------------------------------
//extern datetime ExtDateTimePitchfork_1 = D'11.07.2006 00:00';
//extern datetime ExtDateTimePitchfork_2 = D'19.07.2006 00:00';
//extern datetime ExtDateTimePitchfork_3 = D'09.08.2006 00:00';
//----------------------------------------------------------------------
// Ниже выбраны временные параметры для построения вил Эндрюса для всей истории eurusd для дневок
//----------------------------------------------------------------------
extern bool     ExtPitchforkCandle     = false;
extern datetime ExtDateTimePitchfork_1 = D'15.06.1989 00:00';
extern datetime ExtDateTimePitchfork_2 = D'08.03.1995 00:00';
extern datetime ExtDateTimePitchfork_3 = D'26.10.2000 00:00';
extern bool     ExtPitchfork_1_HighLow = false;

// Переменные для фибовееров
extern bool   ExtFiboFanDinamic     = false;  // может выводиться самостоятельно
extern bool   ExtFiboFanStatic      = false;  // выводится только совместно со статическими вилами
extern bool   ExtFiboFanExp         = true;
extern bool   ExtFiboFanHidden      = false;
extern color  ExtFiboFanD           = Sienna;
extern color  ExtFiboFanS           = Teal;

extern color  ExtFiboFanMedianaDinamicColor = CLR_NONE;
extern color  ExtFiboFanMedianaStaticColor  = CLR_NONE;

// Временные зоны Фибо в составе вил Эндрюса
extern bool   ExtFiboTime1          = false;
extern bool   ExtFiboTime2          = false;
extern bool   ExtFiboTime3          = false;
extern color  ExtFiboTime1C         = Teal;
extern color  ExtFiboTime2C         = Sienna;
extern color  ExtFiboTime3C         = Aqua;
extern bool   ExtVisibleDateTime    = false;
extern string ExtVisibleNumberFiboTime = "111";

//----------------------------------------------------------------------
// Задание пользовательских уровней фибо для инструментов, встроенных в вилы Эндрюса
extern string ExtFiboFreeRLDinamic  = "0.382,0.618,1,1.618,2.618,3.618";
extern string ExtFiboFreeRLStatic   = "0.382,0.618,1,1.618,2.618,3.618";
extern string ExtFiboFreeISLDinamic = "0.25,0.75";
extern string ExtFiboFreeISLStatic  = "0.25,0.75";
extern string ExtFiboFreeUWL        = "0.382,0.618,1,1.618,2.618,3.618";
extern string ExtFiboFreeLWL        = "0.382,0.618,1,1.618,2.618,3.618";
extern string ExtFiboFreeFT1        = "0.382,0.618,1.0,1.236,1.618";
extern string ExtFiboFreeFT2        = "0.382,0.618,1.0,1.236,1.618";
extern string ExtFiboFreeFT3        = "0.382,0.618,1.0,1.236,1.618";
//----------------------------------------------------------------------

// Целевые уровни и зоны
extern int    mSelectVariantsPRZ      = 0;
extern int    mTypeBasiclAP           = 0;
extern int    mTypeExternalAP         = 0;
extern int    mExternalHandAP         = 0;

extern bool   mPivotPoints            = true;
extern bool   mPivotPointsChangeColor = false;
extern int    mSSL                    = 0;
extern int    m1_2Mediana             = 0;
extern int    mISL382                 = 0;
extern int    mMediana                = 0;
extern int    mISL618                 = 0;
extern int    mFSL                    = 0;
extern int    mSLM                    = 0;
extern int    mFSLShiffLines          = 0;
extern int    mUTL                    = 0;
extern int    mLTL                    = 0;
extern int    mUWL                    = 0;
extern int    mLWL                    = 0;

extern bool   mCriticalPoints         = false;
extern int    mSSL_d                  = 0;
extern int    m1_2Mediana_d           = 0;
extern int    mISL382_d               = 0;
extern int    mMediana_d              = 0;
extern int    mISL618_d               = 0;
extern int    mFSL_d                  = 0;
extern int    mSLM_d                  = 0;
extern int    mFSLShiffLines_d        = 0;
extern bool   mCriticalPoints_d       = false;
extern bool   mAllLevels              = true;
extern color  mColorUP                = Blue;
extern color  mColorDN                = Red;
extern color  mColor                  = DarkOrchid;
extern color  mColorRectangleUP       = LightBlue;
extern color  mColorRectangleDN       = Pink;
extern color  mColorRectangle         = Thistle;
extern bool   mBack                   = false;
extern bool   mBackZones              = true;
extern int    mLineZonesWidth         = 5;
extern bool   mVisibleST              = false;
extern bool   mVisibleISL             = true;
extern int    mPeriodWriteToFile      = 240;
extern bool   mWriteToFile            = false;
//----------------------------------------------------------------------

// Каналы micmed'a
extern string ________________5_____________ = "Parameters for micmed Channels";
extern int    ExtCM_0_1A_2B_Dinamic = 0, ExtCM_0_1A_2B_Static = 0;
extern double ExtCM_FiboDinamic = 0.618, ExtCM_FiboStatic = 0.618;
//----------------------------------------------------------------------
// Комплект инструментов, работающих совместно с вилами Эндрюса. Конец.
//----------------------------------------------------------------------

// Фибовееры дополнительные
extern string ______________6_____________ = "Parameters for fibo Fan";
extern color  ExtFiboFanColor = CLR_NONE;
extern int    ExtFiboFanNum   = 0;
extern int    ExtFanStyle     = 1;
extern int    ExtFanWidth     = 0;

// Расширения Фибоначчи
extern string ______________7_____________ = "Parameters for fibo Expansion";
extern int    ExtFiboExpansion      = 0;
extern color  ExtFiboExpansionColor = Yellow;
extern int    ExtExpansionStyle     = 2;
extern int    ExtExpansionWidth     = 0;
//--------------------------------------

extern string ______________8_____________ = "Parameters for versum Levels";
extern color  ExtVLDinamicColor = CLR_NONE;
extern color  ExtVLStaticColor  = CLR_NONE;
extern int    ExtVLStaticNum    = 0;
extern int    ExtVLStyle        = 0;
extern int    ExtVLWidth        = 0;
//--------------------------------------

extern string ______________9_____________ = "Parameters for fibo Arc";
extern int    ExtArcDinamicNum   = 0;
extern int    ExtArcStaticNum    = 0;
extern color  ExtArcDinamicColor = Sienna;
extern color  ExtArcStaticColor  = Teal;
extern double ExtArcDinamicScale = 0;
extern double ExtArcStaticScale  = 0;
extern int    ExtArcStyle        = 0;
extern int    ExtArcWidth        = 0;

extern string ______________10_____________ = "Golden Spiral";
extern int    ExtSpiralNum       = 0;
extern double goldenSpiralCycle  = 1;
extern double accurity           = 0.2;
extern int    NumberOfLines      = 200;
extern bool   clockWiseSpiral    = true;
extern color  spiralColor1       = Blue;
extern color  spiralColor2       = Red;
extern int    ExtSpiralStyle     = 0;
extern int    ExtSpiralWidth     = 0; 

extern string ______________11_____________ = "Pivot ZigZag";
extern color  ExtPivotZZ1Color = Blue;
extern color  ExtPivotZZ2Color = Red;
extern int    ExtPivotZZ1Num   = 0;
extern int    ExtPivotZZ2Num   = 0;
extern int    ExtPivotZZStyle  = 0;
extern int    ExtPivotZZWidth  = 2;

extern string ______________12_____________ = "Parameters for Channels";
extern int    ExtTypeChannels      = 0;
extern int    ExtTypeLineChannels  = 1;
extern int    ExtChannelsNum       = 2;
extern color  ExtLTColor           = Red;
extern color  ExtLCColor           = Green;
extern int    ExtLTChannelsStyle   = 0;
extern int    ExtLTChannelsWidth   = 1; 
extern int    ExtLCChannelsStyle   = 2;
extern int    ExtLCChannelsWidth   = 0; 
extern bool   ExtRay               = false;

extern string ______________13_____________ = "Parameters Fibo Time";
// Временные зоны Фибо
extern int    ExtFiboTimeNum      = 0;
extern bool   ExtFiboTime1x       = false;
extern bool   ExtFiboTime2x       = false;
extern bool   ExtFiboTime3x       = false;
extern color  ExtFiboTime1Cx      = Teal;
extern color  ExtFiboTime2Cx      = Sienna;
extern color  ExtFiboTime3Cx      = Aqua;
extern bool   ExtVisibleDateTimex = false;
extern string ExtVisibleNumberFiboTimex = "111";

extern string ______________14_____________ = "Parameters Exp";
extern bool   chHL                = false;
extern bool   PeakDet             = false;
// Переменные для i-vts
extern bool   chHL_PeakDet_or_vts = true;
extern int    ExtLabel            = 0;
extern int    ExtCodLabel         = 116;
extern int    NumberOfBars        = 1000;     // Количество баров обсчёта (0-все)
extern int    NumberOfVTS         = 13;
extern int    NumberOfVTS1        = 1;

extern string ______________15_____________ = "Common Parameters";
//--------------------------------------
extern int    ExtFiboType       = 1;
extern string ExtFiboTypeFree  = "0,0.382,0.618,0.764,1,1.236,1.618"; // пользовательские уровни фибо 
extern color  ExtObjectColor    = CLR_NONE;
extern int    ExtObjectStyle    = 1;
extern int    ExtObjectWidth    = 0; 
// вывод статических объектов в режиме динамических
extern bool   ExtDinamic        = false;
extern string ExtVisibleDinamic = "01000000000";

extern bool   ZigZagHighLow     = true;
// --------------------------------
// Дополнительные финкции
extern bool   ExtSendMail       = false;
extern bool   ExtAlert          = false;
extern bool   ExtPlayAlert      = false;
// Вывод объектов в виде фона
extern bool   ExtBack           = true;
// Сохранение статических вил Эндрюса, Fibo Time и т.д.
extern bool   ExtSave           = false;
extern string info_comment      = "11111";
extern bool   infoMerrillPattern= false;
extern bool   infoTF            = true;
extern bool   bigTetx           = false;
extern int    bigTetxSize       = 16;
extern color  bigTetxColor      = Red;
extern int    bigTetxX          = 50;
extern int    bigTetxY          = 50;
extern int    ExtComplekt       = 11;
//===================================

// Массивы для ZigZag 
// Массив для отрисовки ZigZag
double zz[];
// Массив минимумов ZigZag
double zzL[];
// Массив максимумов ZigZag
double zzH[];
// Массивы для nen-ZigZag
double nen_ZigZag[];

int    _maxbarZZ; // количество баров, участвующих в расчете зигзагов.

// Массив для оптимизированного ZigZag
//double TempBuffer[1],ZigZagBuffer[1];
// Переменные для оснастки
// Массив чисел Песавенто (Фибы и модифицированные Фибы)
//double fi[]={0.146, 0.236, 0.382, 0.447, 0.5, 0.618, 0.707, 0.786, 0.841, 0.886, 1.0, 1.128, 1.272, 1.414, 1.5, 1.618, 1.732, 1.902, 2.0, 2.236, 2.414, 2.618, 3.14, 3.618, 4.236};
//string fitxt[]={"0.146", "0.236", ".382", ".447", ".5", ".618", ".707", ".786", ".841", ".886", "1.0", "1.128", "1.272", "1.414", "1.5", "1.618", "1.732", "1.902", "2.0", "2.236", "2.414", "2.618", "3.14", "3.618", "4.236"};
//double fi1[]={0.146, 0.236, 0.382, 0.5, 0.618, 0.764, 0.854, 1.0, 1.236, 1.618};
//string fitxt1[]={"0.146", "0.236", ".382", ".5", ".618", ".764", ".854", "1.0", "1.236", "1.618"};
// Массив чисел, заданных пользователем
double fi[];
string fitxt[];
string fitxt100[];
int    Sizefi=0,Sizefi_1=0;

color  ExtLine_;

double number[64];
string numbertxt[64];
int    numberFibo[64];
int    numberPesavento[64];
int    numberGartley[64];
int    numberMix[64];
int    numberGilmorQuality[64];
int    numberGilmorGeometric[64];
int    numberGilmorHarmonic[64];
int    numberGilmorArithmetic[64];
int    numberGilmorGoldenMean[64];
int    numberSquare[64];
int    numberCube[64];
int    numberRectangle[64];
int    numberExt[64];

string nameObj,nameObjtxt,save,nameObjAPMaster;
// 
bool descript_b=false;
// PPWithBars - текст, выводимый у соединительной линии
// descript - описание объектов
string PPWithBars, descript;
// Матрица для поиска исчезнувших баров afr - массив значений времени пяти последних фракталов и отрисовки динамических и статических фиб
// afrl - минимумы, afrh - максимумы
int afr[]={0,0,0,0,0,0,0,0,0,0};
double afrl[]={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}, afrh[]={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}, afrx[]={0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
// Параметры таймфрймов
double openTF[]={0.0,0.0,0.0,0.0,0.0}, closeTF[]={0.0,0.0,0.0,0.0,0.0}, lowTF[]={0.0,0.0,0.0,0.0,0.0}, highTF[]={0.0,0.0,0.0,0.0,0.0};
double close_TF=0;
string TF[]={"MN","W1","D1","H4","H1","M30","M15","M5","M1"};
string Period_tf;
bool   afrm=true;
double ExtHL;
double HL,HLp,kk,kj,Angle;
// LowPrim,HighPrim,LowLast,HighLast - значения минимумов и максимумов баров
double LowPrim,HighPrim,LowLast,HighLast;
// numLowPrim,numHighPrim,numLowLast,numHighLast -номера баров
int numLowPrim,numHighPrim,numLowLast,numHighLast,k,k1,k2,ki,kiPRZ=0,countLow1,countHigh1,shift,shift1;
string txtkk;
// Время свечи с первым от нулевого бара фракталом
int timeFr1new;
// Счетчик фракталов
int countFr;
// Бар, до которого надо рисовать соединительные линии от нулевого бара
int countBarEnd=0,TimeBarEnd;
// Бар, до которого надо пересчитывать от нулевого бара
int numBar=0;
// Номер объекта
int numOb;
// flagFrNew=true - образовался новый фрактал или первый фрактал сместился на другой бар. =false - по умолчанию.
bool flagFrNew=false;
// идентификатор нового луча
bool newRay=true;
// flagGartley - появление нового паттерна Gartley или исчезновение паттерна Gartley
bool flagGartley=false;
// Период текущего графика
int perTF;
bool Demo;
// Переменные для зигзага, разработанного wellx
bool   first=true;
int    NewBarTime=0, countbars=0;
int    lasthighpos,lastlowpos,realcnt=0;
double lasthigh,lastlow;

double int_to_d=0, int_to_d1=0, int_to_d2=0;

int counted_bars, cbi, iBar;

// средний размер бара текущего таймфрейма
// The average size of a bar
double ASBar;

// Переменные для ZigZag Алекса и индикатора подобного встроенному в Ensign
double ha[],la[],hi,li,si,sip,di,hm,lm,ham[],lam[],him,lim,lLast=0,hLast=0;
int fs=0,fsp,countBar;
int ai,bi,ai0,bi0,aim,bim;
datetime tai,tbi,ti,tmh,tml;
// fcount0 - при обнулении счетчика пропущенных баров на 0 баре fcount0=true.
// На следующем баре =false и можно определять точку перелома
bool fh=false,fl=false,fcount0,PeakDetIni;

/*
// Переменные для Свингов Ганна
double lLast_m=0, hLast_m=0;
int countBarExt; // счетчик внешних баров
int countBarl,countBarh;
*/
// Переменные для nen-ZigZag
bool hi_nen;
bool init_zz=true;

// Переменные для расширенного режима работы индикатора
int mFibo[]={0,0}, mPitch[]={0,0,0}, mFan[]={0,0}, mExpansion[]={0,0,0}, mVL[]={0,0,0}, mArcS[]={0,0}, mArcD[]={0,0}, mSpiral[]={0,0},mChannels[]={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
// Переменные для построения вил Эндрюса по свечам
int      mPitchTime[]={0,0,0};
int      mPitchTimeSave;
double   mPitchCena[]={0.0,0.0,0.0};

// переменные для vts
double   ms[2];
// Переменные для паттернов Gartley
string   vBullBear    = ""; // переменная для обозначения бычий или медвежий паттерн
string   vNamePattern = ""; // переменная для обозначения наименования паттерна
string   vBullBearToNumberPattern = "";
string   vNamePatternToNumberPattern = "";
int      maxPeak, vPatOnOff, vPatNew=0;
int      Depth;
double   hBar, lBar;
datetime tiZZ;
int      _ExtPitchforkStatic=0;

bool     FlagForD  = true;  // Разрешение на поиск момента образования точки D паттерна (Gartley)
datetime TimeForDmin  = 0, TimeForDminToNumberPattern;
datetime TimeForDmax  = 0, TimeForDmaxToNumberPattern;
double   LevelForDmin = 0, LevelForDminToNumberPattern;
double   LevelForDmax = 0, LevelForDmaxToNumberPattern;
double   PeakCenaX[1],PeakCenaA[1],PeakCenaB[1],PeakCenaC[1],PeakCenaD[1];
datetime PeakTimeX[1],PeakTimeA[1],PeakTimeB[1],PeakTimeC[1],PeakTimeD[1];
int      countGartley = 0;      // Счетчик паттернов
int      minBarsToNumberPattern; 
color    ColorList[];
int      ColorSize=0;
int      countColor   = 0;
bool     flagExtGartleyTypeSearch2=false;
int      minBarsSave, minBarsX;
string   info_RZS_RL="",info_RZD_RL="";

// Переменные для Merrill Patterns
double   mPeak0[5][2]={0,5,0,4,0,3,0,2,0,1}, mPeak1[5][2]={0,5,0,4,0,3,0,2,0,1};
string   mMerrillPatterns[32][3]=
{"21435", "M1", "DownTrend",
"21453", "M2", "InvertedHeadAndShoulders",
"24135", "M3", "DownTrend",
"24153", "M4", "InvertedHeadAndShoulders",
"42135", "M5", "Broadening",
"42153", "M6", "InvertedHeadAndShoulders",
"24315", "M7", "*",
"24513", "M8", "InvertedHeadAndShoulders",
"42315", "M9", "*",
"42513", "M10", "InvertedHeadAndShoulders",
"45213", "M11", "InvertedHeadAndShoulders",
"24351", "M12", "*",
"24531", "M13", "Triangle",
"42351", "M14", "*",
"42531", "M15", "UpTrend",
"45231", "M16", "UpTrend",
"13245", "W1", "DownTrend",
"13524", "W2", "DownTrend",
"15324", "W3", "*",
"13224", "W4", "Triangle",
"15342", "W5", "*",
"31254", "W6", "HeadAndShoulders",
"42513", "W7", "HeadAndShoulders",
"51324", "W8", "*",
"31542", "W9", "HeadAndShoulders",
"51324", "W10", "*",
"35124", "W11", "HeadAndShoulders",
"53124", "W12", "Broadening",
"35142", "W13", "HeadAndShoulders",
"53142", "W14", "UpTrend",
"35412", "W15", "HeadAndShoulders",
"53412", "W16", "UpTrend"};

// Переменные для зигзага Talex
static int    endbar = 0;
static double endpr  = 0;

// Переменные для расчета размеров окна в пикселях для Golden Spiral
static int GPixels,VPixels;
int rect[4],hwnd;
int f=1;

// Переменные для ценовых меток в вилах Эндрюса
bool mAP = false;      // флаг разрешения вывода меток
//double mMax, mMin;   // цена ближайшей метки вверху и внизу. При пересечении этих ценовых уровней необходимо менять цвет меток.
datetime mTime;        // правая граница ближайшей ценовой зоны, при пересечении которой необходимо удалять текущую ценовую зону и выводить следующую ценовую зону.
bool mAPs, mAPd;       // Флаги - сигналы для создания меток в вилах Эндрюса
double RZs=-1, RZd=-1; // расстояние до красной зоны. Рассчитывается при выводе меток.
datetime mPeriod;    // время следующей записи значений меток в файл

// Переменные для построения вил Эндрюса от произвольных свечей
int    vX, vY; // Координаты метки APm
bool tik2 = false;

// Переменные для каналов
int DinamicChannels=-1;

// APm
bool   SlavePitchfork = false;
string nameCheckLabel_hidden="CheckLabel_hidden";
string nameCheckLabel="CheckLabel";
int    ExtComplektAPm = 0; // номер комплекта, который устанавливает метку APm в "стойло"
//   tmp="_"+StringSubstr(""+ExtComplekt,StringLen(""+ExtComplekt)-1)+"_";


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string aa, aa1, txt;
   int aa2, i, j;
   int i_APm=0; // счетчик вил с меткой APm
   int count_APm;

   vX=30; vY=30; // Координаты метки APm

   hwnd=WindowHandle(Symbol(),Period());
   if(hwnd>0)
     {
      GetClientRect(hwnd,rect);
      GPixels=rect[2]; // здесь функция возвращает кол-во пикселов по горизонтали для окна с графиком, в котором запускается индикатор
      VPixels=rect[3]; // здесь функция возвращает кол-во пикселов по вертикали
     }

   if (ParametresZZforDMLEWA>0 && (ExtIndicator==0 || ExtIndicator==6))
     {
      switch (ParametresZZforDMLEWA)
        {
         case 1:
           minBars=5; ExtDeviation=3; ExtBackstep=8;
           break;
         case 2:
           minBars=8; ExtDeviation=5; ExtBackstep=13;
           break;
         case 3:
           minBars=13; ExtDeviation=8; ExtBackstep=21;
           break;
         case 4:
           minBars=21; ExtDeviation=13; ExtBackstep=34;
           break;
         case 5:
           minBars=34; ExtDeviation=21; ExtBackstep=55;
           break;
         case 6:
           minBars=55; ExtDeviation=34; ExtBackstep=89;
           break;
         case 7:
           minBars=89; ExtDeviation=55; ExtBackstep=144;
           break;
         case 8:
           minBars=144; ExtDeviation=89; ExtBackstep=233;
        }
     }

   minBarsSave=minBars;

   IndicatorBuffers(8);

// -------
// Gartley Patterns

   if (ExtGartleyTypeSearch<0) ExtGartleyTypeSearch=0;
   if (ExtGartleyTypeSearch>2) ExtGartleyTypeSearch=2;

   if (ExtHiddenPP<0) ExtHiddenPP=0;
   if (ExtHiddenPP>2) ExtHiddenPP=2;

   if (NumberPattern<1) NumberPattern=1;

   if (ExtIndicator==14)
     {
      if (auto)
        {
         double wrmassiv[];

         if (minBar>=100) minBar=61.8;
         if (minBar<=0) minBar=61.8;
         if (maxBar>=100) maxBar=38.2;
         if (minBar<=0) minBar=38.2;

         ArrayResize(wrmassiv,Bars-1);
         for (i=Bars-1;i>0;i--) {wrmassiv[i]=High[i]-Low[i]+Point;}
         ArraySort (wrmassiv);
         i=MathFloor(minBar*Bars/100);
         StLevel=MathFloor(wrmassiv[i]/Point);
         i=MathFloor(maxBar*Bars/100);
         BigLevel=MathFloor(wrmassiv[i]/Point);
        }
     }

   if (ExtMaxBar>Bars) ExtMaxBar=Bars;
   if (ExtMaxBar>0) _maxbarZZ=ExtMaxBar; else _maxbarZZ=Bars;

   if (IterationStep<1) IterationStep=1;
   if (IterationStep>maxDepth-minDepth) IterationStep=maxDepth-minDepth;

   if (ExtIndicator==11) if (ExtHiddenPP==0 || ExtHiddenPP==2) {ExtHidden=0; ExtStyleZZ=false;}

   if (ExtGartleyTypeSearch>0)
     {
//---------
      if (!patternInfluence)
        {
         if (ExtMaxBar>0)
           {
            if (maxBarToD==0 || maxBarToD>ExtMaxBar) maxBarToD=ExtMaxBar-15;
           }
         else if (maxBarToD==0) maxBarToD=Bars-15;
        }

      if (RangeForPointD>2) RangeForPointD=2;

//---------

      i=-1;
      aa2=0;
      while (aa2>=0)    // Подготовка списка значений цвета для бабочек Gartley, заданных пользователем
        {
         aa2=StringFind(ExtColorPatternList, ",",i+1);
         if (aa2>=0)
           {i=aa2;ColorSize++;}
         else
           {
            if (StringLen(ExtColorPatternList)-i>0)
              {
               if (StrToDouble(StringSubstr(ExtColorPatternList,i+1))>0) ColorSize++;
               ArrayResize(ColorList,ColorSize);
               aa1=ExtColorPatternList;
               for (i=0;i<ColorSize;i++)
                 {
                  aa2=StringFind(aa1, ",", 0);

                  ColorList[i]=fStrToColor(StringTrimLeft(StringTrimRight(StringSubstr(aa1,0,aa2))));

                  if (aa2>=0) aa1=StringSubstr(aa1,aa2+1);
                 }
               aa2=-1;
              }
           }
        }
     }

   if (CustomPattern<0) CustomPattern=0;
   if (CustomPattern>4) CustomPattern=4;
// -------

   if (ExtStyleZZ) {SetIndexStyle(0,DRAW_SECTION);}
   else {SetIndexStyle(0,DRAW_ARROW); SetIndexArrow(0,158);}

   if (ExtLabel>0)
     {
      SetIndexStyle(3,DRAW_ARROW); SetIndexArrow(3,ExtCodLabel);
      SetIndexStyle(4,DRAW_ARROW); SetIndexArrow(4,ExtCodLabel);
     }
   else
     {
      SetIndexStyle(3,DRAW_LINE,STYLE_DOT);
      SetIndexStyle(4,DRAW_LINE,STYLE_DOT);
     }

   SetIndexLabel(0,"ZUP"+ExtComplekt+" (zz"+ExtIndicator+")");
   if (ExtIndicator==6) SetIndexLabel(5,"ZUP"+ExtComplekt+" DT6_"+minBars+"/"+ExtDeviation+"/"+ExtBackstep+"/GP"+GrossPeriod+"");
   else if (ExtIndicator==7) SetIndexLabel(5,"ZUP"+ExtComplekt+" DT7_"+minBars+"/GP"+GrossPeriod+"");
   else if (ExtIndicator==8) SetIndexLabel(5,"ZUP"+ExtComplekt+" DT8_"+minBars+"/"+ExtDeviation+"/GP"+GrossPeriod+"");

   if (ExtLabel>0)
     {
      SetIndexLabel(1,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" H_PeakDet");
      SetIndexLabel(2,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" L_PeakDet");
      SetIndexLabel(3,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" UpTrend");
      SetIndexLabel(4,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" DownTrend");
     }
   else
     {
      if (chHL_PeakDet_or_vts)
        {
         PeakDetIni=true;
         SetIndexLabel(1,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" H_PeakDet");
         SetIndexLabel(2,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" L_PeakDet");
         SetIndexLabel(3,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" H_chHL");
         SetIndexLabel(4,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" L_chHL");
        }
      else
        {
         SetIndexLabel(1,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" H_vts");
         SetIndexLabel(2,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" L_vts");
         SetIndexLabel(3,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" H_vts1");
         SetIndexLabel(4,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" L_vts1");
        }
     }

// Уровни предыдущих пиков
   SetIndexStyle(1,DRAW_LINE,STYLE_DOT);
   SetIndexStyle(2,DRAW_LINE,STYLE_DOT); 
   SetIndexBuffer(1,ham);
   SetIndexBuffer(2,lam);
// Уровни подтверждения
   SetIndexBuffer(3,ha);
   SetIndexBuffer(4,la);

   SetIndexBuffer(0,zz);
   SetIndexBuffer(5,nen_ZigZag);
   SetIndexBuffer(6,zzL);
   SetIndexBuffer(7,zzH);

   SetIndexStyle(5,DRAW_ARROW);
   SetIndexArrow(5,159);

   SetIndexEmptyValue(0,0.0);
   SetIndexEmptyValue(1,0.0);
   SetIndexEmptyValue(2,0.0);
   SetIndexEmptyValue(3,0.0);
   SetIndexEmptyValue(4,0.0);
   SetIndexEmptyValue(5,0.0);
   SetIndexEmptyValue(6,0.0);
   SetIndexEmptyValue(7,0.0);

   if (ExtIndicator<6 || ExtIndicator>10)
     {
      switch (Period())
        {
         case 1     : {Period_tf=TF[8];break;}
         case 5     : {Period_tf=TF[7];break;}
         case 15    : {Period_tf=TF[6];break;}
         case 30    : {Period_tf=TF[5];break;}
         case 60    : {Period_tf=TF[4];break;}
         case 240   : {Period_tf=TF[3];break;}
         case 1440  : {Period_tf=TF[2];break;}
         case 10080 : {Period_tf=TF[1];break;}
         case 43200 : {Period_tf=TF[0];break;}
        }
     }
   else
     {
      switch (GrossPeriod)
        {
         case 1     : {Period_tf=TF[8];break;}
         case 5     : {Period_tf=TF[7];break;}
         case 15    : {Period_tf=TF[6];break;}
         case 30    : {Period_tf=TF[5];break;}
         case 60    : {Period_tf=TF[4];break;}
         case 240   : {Period_tf=TF[3];break;}
         case 1440  : {Period_tf=TF[2];break;}
         case 10080 : {Period_tf=TF[1];break;}
         case 43200 : {Period_tf=TF[0];break;}
        }

      if (GrossPeriod>43200)
        {
         if (MathMod(GrossPeriod,43200)>0) Period_tf=GrossPeriod; else Period_tf=TF[0]+GrossPeriod/43200 + ""; 
        }
      else if (GrossPeriod<43200)
        {
         if (GrossPeriod>10080)
           { 
            if (MathMod(GrossPeriod,10080)>0) Period_tf=GrossPeriod; else Period_tf="W"+GrossPeriod/10080 + ""; 
           }
         else if (GrossPeriod<10080)
           {
            if (GrossPeriod>1440)
              { 
               if (MathMod(GrossPeriod,1440)>0) Period_tf=GrossPeriod; else Period_tf="D"+GrossPeriod/1440 + ""; 
              }
            else if (GrossPeriod<1440)
              {
               if (GrossPeriod!=60)
                 { 
                  if (MathMod(GrossPeriod,60)>0) Period_tf=GrossPeriod; else Period_tf="H"+GrossPeriod/60 + ""; 
                 }
              }
           }
        }
     }

   if (ExtIndicator==1) if (minSize!=0) di=minSize*Point/2;
   if (ExtIndicator==2) {di=minSize*Point; countBar=minBars;}
   if (ExtIndicator==3) {countBar=minBars;}

   if (ExtIndicator>5 && ExtIndicator<11 && GrossPeriod>Period())
     {
      if (GrossPeriod==43200 && Period()==10080) maxBarToD=maxBarToD*5; else maxBarToD=maxBarToD*GrossPeriod/Period();
     }
   
   if (ExtIndicator<6 ||ExtIndicator>10) GrossPeriod=Period();

   if (ExtFiboType<0) ExtFiboType=0;
   if (ExtFiboType>2) ExtFiboType=2;

   if (ExtFiboType==2) // Подготовка списка фиб, заданных пользователем
     {
      i=-1;
      aa2=0;
      while (aa2>=0)
        {
         aa2=StringFind(ExtFiboTypeFree, ",",i+1);
         if (aa2>=0)
           {i=aa2;Sizefi++;}
         else
           {
            if (StringLen(ExtFiboTypeFree)-i>0)
              {
               if (StrToDouble(StringSubstr(ExtFiboTypeFree,i+1))>0) Sizefi++;
               arrResize(Sizefi);
               aa1=ExtFiboTypeFree;
               for (i=0;i<Sizefi;i++)
                 {
                  aa2=StringFind(aa1, ",", 0);

                  fitxt[i]=StringTrimLeft(StringTrimRight(StringSubstr(aa1,0,aa2)));
                  fi[i]=StrToDouble(fitxt[i]);
                  if (fi[i]<1) fitxt[i]=StringSubstr(fitxt[i],1);
                  fitxt100[i]=DoubleToStr(100*fi[i],1);

                  if (aa2>=0) aa1=StringSubstr(aa1,aa2+1);
                 }
              }
           }
        }
     }
// -------
 
// Проверка правильности введенных внешних переменных
   if (ExtDelta<=0) ExtDelta=0.001;
   if (ExtDelta>1) ExtDelta=0.999;

   if (ExtHidden<0) ExtHidden=0;
   if (ExtHidden>5) ExtHidden=5;
 
   if (ExtDeltaType<0) ExtDeltaType=0;
   if (ExtDeltaType>3) ExtDeltaType=3;

   if (ExtFiboChoice<0) ExtFiboChoice=0;
   if (ExtFiboChoice>11) ExtFiboChoice=11;

   if (ExtPivotZZ1Num>9) ExtPivotZZ1Num=9;
   if (ExtPivotZZ2Num>9) ExtPivotZZ2Num=9;

   if (ExtPivotZZ1Num==ExtPivotZZ2Num)
     {
      if (ExtPivotZZ1Num>0) ExtPivotZZ1Num=ExtPivotZZ2Num-1;
     }

   if (ExtFractalEnd>0)
     {
      if (ExtFractalEnd<1) ExtFractalEnd=1;
     }

   if (ExtPitchforkStatic>4) ExtPitchforkStatic=4;
   _ExtPitchforkStatic=ExtPitchforkStatic;
   if (ExtPitchforkDinamic>4) ExtPitchforkDinamic=4;
   if (ExtMasterPitchfork<0 || ExtMasterPitchfork>2) ExtMasterPitchfork=0;

   if (ExtCM_0_1A_2B_Dinamic<0) ExtCM_0_1A_2B_Dinamic=0;
   if (ExtCM_0_1A_2B_Dinamic>5) ExtCM_0_1A_2B_Dinamic=5;
   if (ExtCM_0_1A_2B_Static<0) ExtCM_0_1A_2B_Static=0;
   if (ExtCM_0_1A_2B_Static>5) ExtCM_0_1A_2B_Static=5;
   if (ExtCM_FiboDinamic<0) ExtCM_FiboDinamic=0;
   if (ExtCM_FiboDinamic>1) ExtCM_FiboDinamic=1;
   if (ExtCM_FiboStatic<0) ExtCM_FiboStatic=0;
   if (ExtCM_FiboStatic>1) ExtCM_FiboStatic=1;

//--------------------------------------------
   if (ExtPitchforkStaticNum<3) ExtPitchforkStaticNum=3;
   
   if ((ExtPitchforkStatic>0 || ExtPitchforkDinamic>0) && mAllLevels && 
   (mPivotPoints || mSSL>0 || m1_2Mediana>0 || mISL382>0 || mMediana>0 || mISL618>0 || mFSL>0 || mCriticalPoints || mSLM>0 || mFSLShiffLines>0 || mUTL || mLTL || mUWL || mLWL ||
    mSSL_d>0 || m1_2Mediana_d>0 || mISL382_d>0 || mMediana_d>0 || mISL618_d>0 || mFSL_d>0 || mCriticalPoints_d || mSLM_d>0 || mFSLShiffLines_d>0)) mAP=true;

   if (mSSL<0) mSSL=0; if (mSSL>9) mSSL=9;
   if (m1_2Mediana<0) m1_2Mediana=0; if (m1_2Mediana>9) m1_2Mediana=9;
   if (mISL382<0) mISL382=0; if (mISL382>9) mISL382=9;
   if (mMediana<0) mMediana=0; if (mMediana>9) mMediana=9;
   if (mISL618<0) mISL618=0; if (mISL618>9) mISL618=9;
   if (mFSL<0) mFSL=0; if (mFSL>9) mFSL=9;
   if (mSLM<0) mSLM=0; if (mSLM>9) mSLM=9;
   if (mFSLShiffLines<0) mFSLShiffLines=0; if (mFSLShiffLines>9) mFSLShiffLines=9;
   if (mUTL<0) mUTL=0; if (mUTL>9) mUTL=9;
   if (mLTL<0) mLTL=0; if (mLTL>9) mLTL=9;
   if (mUWL<0) mUWL=0; if (mUWL>9) mUWL=9;
   if (mLWL<0) mLWL=0; if (mLWL>9) mLWL=9;

   if (mSSL_d<0) mSSL_d=0; if (mSSL_d>9) mSSL_d=9;
   if (m1_2Mediana_d<0) m1_2Mediana_d=0; if (m1_2Mediana_d>9) m1_2Mediana_d=9;
   if (mISL382_d<0) mISL382_d=0; if (mISL382_d>9) mISL382_d=9;
   if (mMediana_d<0) mMediana_d=0; if (mMediana_d>9) mMediana_d=9;
   if (mISL618_d<0) mISL618_d=0; if (mISL618_d>9) mISL618_d=9;
   if (mFSL_d<0) mFSL_d=0; if (mFSL_d>9) mFSL_d=9;
   if (mSLM_d<0) mSLM_d=0; if (mSLM_d>9) mSLM_d=9;
   if (mFSLShiffLines_d<0) mFSLShiffLines_d=0; if (mFSLShiffLines_d>9) mFSLShiffLines_d=9;

   if (mSelectVariantsPRZ>9) mSelectVariantsPRZ=-1;

   if (ExtFiboStaticNum<2) ExtFiboStaticNum=2;

   if (ExtFiboStaticNum>9)
     {
      aa=DoubleToStr(ExtFiboStaticNum,0);
      aa1=StringSubstr(aa,0,1);
      mFibo[0]=StrToInteger(aa1);
      aa1=StringSubstr(aa,1,1);
      mFibo[1]=StrToInteger(aa1);
     }
   else
     {
      mFibo[0]=ExtFiboStaticNum;
      mFibo[1]=ExtFiboStaticNum-1;
     }

   if (ExtFiboFanNum<1) ExtFiboFanNum=1;

   if (ExtFiboFanNum>9)
     {
      aa=DoubleToStr(ExtFiboFanNum,0);
      aa1=StringSubstr(aa,0,1);
      mFan[0]=StrToInteger(aa1);
      aa1=StringSubstr(aa,1,1);
      mFan[1]=StrToInteger(aa1);
     }
   else
     {
      mFan[0]=ExtFiboFanNum;
      mFan[1]=ExtFiboFanNum-1;
     }

   if (ExtPitchforkStaticNum>99)
     {
      aa=DoubleToStr(ExtPitchforkStaticNum,0);
      aa1=StringSubstr(aa,0,1);
      mPitch[0]=StrToInteger(aa1);
      aa1=StringSubstr(aa,1,1);
      mPitch[1]=StrToInteger(aa1);
      aa1=StringSubstr(aa,2,1);
      mPitch[2]=StrToInteger(aa1);
     }
   else
     {
      mPitch[0]=ExtPitchforkStaticNum;
      mPitch[1]=ExtPitchforkStaticNum-1;
      mPitch[2]=ExtPitchforkStaticNum-2;
     }

   if (ExtFiboExpansion<2) ExtFiboExpansion=0;
   
   if (ExtFiboExpansion>0)
     {
      if (ExtFiboExpansion>99)
        {
         aa=DoubleToStr(ExtFiboExpansion,0);
         aa1=StringSubstr(aa,0,1);
         mExpansion[0]=StrToInteger(aa1);
         aa1=StringSubstr(aa,1,1);
         mExpansion[1]=StrToInteger(aa1);
         aa1=StringSubstr(aa,2,1);
         mExpansion[2]=StrToInteger(aa1);
        }
      else
        {
         mExpansion[0]=ExtFiboExpansion;
         mExpansion[1]=ExtFiboExpansion-1;
         mExpansion[2]=ExtFiboExpansion-2;
        }
     }
   
   if (ExtPitchforkCandle && !ExtCustomStaticAP)
     {
      mPitchTime[0]=ExtDateTimePitchfork_1;
      mPitchTime[1]=ExtDateTimePitchfork_2;
      mPitchTime[2]=ExtDateTimePitchfork_3;

      if (ExtPitchfork_1_HighLow)
        {
         mPitchCena[0]=High[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_1,true)];
         mPitchCena[1]=Low[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_2,true)];
         mPitchCena[2]=High[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3,true)];
        }
      else
        {
         mPitchCena[0]=Low[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_1,true)];
         mPitchCena[1]=High[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_2,true)];
         mPitchCena[2]=Low[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3,true)];
        }

      if (mPitchCena[0]<=0 || mPitchCena[1]<=0 || mPitchCena[2]<=0) {ExtPitchforkCandle=false; ExtPitchforkStatic=0;}
     }

   if (ExtFiboTimeNum<=2) ExtFiboTimeNum=0;
   if (ExtFiboTimeNum>999) ExtFiboTimeNum=0;

   if (ExtVLStaticNum>0)
     {
      if (ExtVLStaticNum<2) ExtVLStaticNum=2;

      if (ExtVLStaticNum>99)
        {
         aa=DoubleToStr(ExtVLStaticNum,0);
         aa1=StringSubstr(aa,0,1);
         mVL[0]=StrToInteger(aa1);
         aa1=StringSubstr(aa,1,1);
         mVL[1]=StrToInteger(aa1);
         aa1=StringSubstr(aa,2,1);
         mVL[2]=StrToInteger(aa1);
        }
      else
        {
         mVL[0]=ExtVLStaticNum;
         mVL[1]=ExtVLStaticNum-1;
         mVL[2]=ExtVLStaticNum-2;
        }
     }

   if (ExtArcStaticNum>0)
     {
      if (ExtArcStaticNum<2) ExtArcStaticNum=2;
      if (ExtArcStaticNum<12 && ExtArcStaticNum>9) ExtArcStaticNum=9;
      if (ExtArcStaticNum>98) ExtArcStaticNum=98;

      if (ExtArcStaticNum>=12)
        {
         aa=DoubleToStr(ExtArcStaticNum,0);
         aa1=StringSubstr(aa,1,1);
         mArcS[0]=StrToInteger(aa1);
         aa1=StringSubstr(aa,0,1);
         mArcS[1]=StrToInteger(aa1);
         if (mArcS[0]==0) {ExtArcStaticNum=0; mArcS[1]=0;}
        }
      else
        {
         mArcS[1]=ExtArcStaticNum;
         mArcS[0]=ExtArcStaticNum-1;
        }
     }

   if (ExtArcDinamicNum>0)
     {
      if (ExtArcDinamicNum>90) ExtArcStaticNum=90;

      if (ExtArcDinamicNum>9)
        {
         aa=DoubleToStr(ExtArcDinamicNum,0);
         aa1=StringSubstr(aa,1,1);
         mArcD[0]=StrToInteger(aa1);
         aa1=StringSubstr(aa,0,1);
         mArcD[1]=StrToInteger(aa1);
         if (mArcD[0]>0) mArcD[0]=0;
        }
      else
        {
         mArcD[1]=0;
         mArcD[0]=ExtArcDinamicNum;
        }
     }

   // Золотая спираль
   if (ExtSpiralNum>0)
     {
      if(goldenSpiralCycle <= 0) goldenSpiralCycle = 1;
      if(accurity <= 0) accurity = 0.2;
      if (ExtSpiralNum<2) ExtSpiralNum=2;
      if (ExtSpiralNum>98) ExtSpiralNum=98;

      if (ExtSpiralNum>9)
        {
         aa=DoubleToStr(ExtSpiralNum,0);
         aa1=StringSubstr(aa,1,1);
         mSpiral[0]=StrToInteger(aa1);
         aa1=StringSubstr(aa,0,1);
         mSpiral[1]=StrToInteger(aa1);
         if (mSpiral[0]==0) {ExtSpiralNum=0; mSpiral[1]=0;}
        }
      else
        {
         mSpiral[1]=ExtSpiralNum;
         mSpiral[0]=ExtSpiralNum-1;
        }

     }

   // каналы
   if (ExtChannelsNum>9876543210) ExtChannelsNum=0;

   if (ExtChannelsNum>0)
     {
      aa=DoubleToStr(ExtChannelsNum,0);
      aa2=StringLen(aa);
   
      for (i=0;i<aa2;i++)
        {
         mChannels[i]=StrToInteger(StringSubstr(aa,i,1));
        }

      if (aa2==1) {mChannels[aa2]=mChannels[0]-1; aa2++;}

      ArraySort(mChannels,WHOLE_ARRAY,0,MODE_DESCEND);
      for (i=1;i<=9;i++)
        {
         if ((mChannels[i]==mChannels[i-1]) && mChannels[i]>=0) {mChannels[i]=-1; ArraySort(mChannels,WHOLE_ARRAY,0,MODE_DESCEND); i--;}
        }

      for (i=1;i<=9;i++)
        {
         if (mChannels[i]==0) {DinamicChannels=i; break;}
        }
     }


   if (ExtSave)
     {
      MathSrand(LocalTime());
      save=MathRand();
     }

   if (ExtCM_0_1A_2B_Static==4 || ExtCM_0_1A_2B_Dinamic==4)
     {
      for (i=Bars-1; i>-1; i--)
        {
         ASBar=ASBar + iHigh(NULL,GrossPeriod,i) - iLow(NULL,GrossPeriod,i) + Point;
        }
      ASBar=ASBar/Bars;
     }
   
   array_();
   perTF=Period();
   Demo=IsDemo();
   delete_objects1();
   if (!ExtCustomStaticAP || ExtPitchforkStatic==0)
     {
      ObjectDelete("pitchforkS" + ExtComplekt+"_APm_");
      delete_objects8();
      ExtCustomStaticAP=false;
     }

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      // восстановение флагов наличия на графике меток в вилах Эндрюса
      if (!mAPs)
        {
         if (StringFind(txt,"m#"+ExtComplekt+"_"+"s")>-1) mAPs=true;
        }

      if (!mAPd)
        {
         if (StringFind(txt,"m#"+ExtComplekt+"_"+"d")>-1) mAPd=true;
        }

      // подсчет колическтва вил с меткой APm
      if (ObjectType(txt)==OBJ_PITCHFORK)
        {
         if (StringFind(txt,"_APm",0)>0) i_APm++;
        }
     }

   ObjectDelete(nameCheckLabel_hidden);
   if (i_APm>1)
     {
      if (ObjectFind(nameCheckLabel)==0)
        {
         // Проверка положения сигнальной метки APm
         if (ObjectGet(nameCheckLabel,OBJPROP_XDISTANCE)!=vX || ObjectGet(nameCheckLabel,OBJPROP_YDISTANCE)!=vY)
           {
            count_APm=(i_APm-1)*2;
           }
         else
           {
            count_APm=i_APm;
           }

         ObjectCreate(nameCheckLabel_hidden,OBJ_TEXT,0,0,0);

         ObjectSetText(nameCheckLabel_hidden,""+i_APm+"_"+count_APm);
         ObjectSet(nameCheckLabel_hidden, OBJPROP_COLOR, CLR_NONE);
         ObjectSet(nameCheckLabel_hidden, OBJPROP_BACK, true);
        }
     }
    
   mPeriod=0; // 
   
   return(0);
  }
//+------------------------------------------------------------------+
//| Деинициализация. Удаление всех трендовых линий и текстовых объектов
//+------------------------------------------------------------------+
int deinit()
  {
   int i;

   ObjectDelete("fiboS" + ExtComplekt+"_");

   ObjectDelete("fiboFanS" + ExtComplekt+"_");
   ObjectDelete("RLineS" + ExtComplekt+"_");
   if (!ExtCustomStaticAP)
     {
      ObjectDelete("pitchforkS" + ExtComplekt+"_APm_");
      ObjectDelete("Master_pitchforkS" + ExtComplekt+"_APm_");
     }

   ObjectDelete("pitchforkS" + ExtComplekt+"_");
   ObjectDelete("Master_pitchforkS" + ExtComplekt+"_");
   ObjectDelete("pmedianaS" + ExtComplekt+"_");
   ObjectDelete("1-2pmedianaS" + ExtComplekt+"_");
   ObjectDelete("SLM382S" + ExtComplekt+"_");
   ObjectDelete("SLM618S" + ExtComplekt+"_");
   ObjectDelete("FSL Shiff Lines S" + ExtComplekt+"_");
   ObjectDelete("fiboTime1" + ExtComplekt+"_");ObjectDelete("fiboTime2" + ExtComplekt+"_");ObjectDelete("fiboTime3" + ExtComplekt+"_");
   ObjectDelete("fiboTime1Free" + ExtComplekt+"_");ObjectDelete("fiboTime2Free" + ExtComplekt+"_");ObjectDelete("fiboTime3Free" + ExtComplekt+"_");
   ObjectDelete("UTL" + ExtComplekt+"_");ObjectDelete("LTL" + ExtComplekt+"_");
   ObjectDelete("UWL" + ExtComplekt+"_");ObjectDelete("LWL" + ExtComplekt+"_");
   ObjectDelete("ISL_S" + ExtComplekt+"_");
   ObjectDelete("RZS" + ExtComplekt+"_");
   ObjectDelete("CL" + ExtComplekt+"_");
   ObjectDelete("CISL" + ExtComplekt+"_"+0);
   ObjectDelete("CISL" + ExtComplekt+"_"+1);
   ObjectDelete("PivotZoneS" + ExtComplekt+"_");
   ObjectDelete("FanMedianaStatic" + ExtComplekt+"_");

   ObjectDelete("FiboFan" + ExtComplekt+"_");
   ObjectDelete("FiboArcS" + ExtComplekt+"_");
   ObjectDelete("LinePivotZZ" + "1" + ExtComplekt+"_");
   ObjectDelete("LinePivotZZ" + "2" + ExtComplekt+"_");
   ObjectDelete("#_TextPattern_#" + ExtComplekt+"_");
   ObjectDelete("#_TextPatternMP_#" + ExtComplekt+"_");

   for (i=0;i<9; i++)
     {
      nameObj="LCChannel" + i + ExtComplekt+"_";
      ObjectDelete(nameObj);
      nameObj="LTChannel" + i + ExtComplekt+"_";
      ObjectDelete(nameObj);
     }
   
   for (i=0; i<7; i++)
     {
      nameObj="VLS"+i+" " + ExtComplekt+"_";
      ObjectDelete(nameObj);
     }

   // Соблюдать порядок следования строк при удалении объектов
   delete_objects_dinamic();
   delete_objects1();
   delete_objects3();
   delete_objects4();
   delete_objects5();
   delete_objects6();
   delete_objects7();
   delete_objects_spiral();
   delete_objects_number();
   delete_objects8();
   delete_objects9();

   Comment("");
   return(0);
  }
//********************************************************

// НАЧАЛО
int start()
  {
   if (ExtCustomStaticAP && tik2)
     {
      screenPitchforkS();
     }
   tik2 = true;

   if ((ExtIndicator==6 || ExtIndicator==7 || ExtIndicator==8 || ExtIndicator==10) && Period()>GrossPeriod) 
     {
      ArrayInitialize(zz,0);ArrayInitialize(zzL,0);ArrayInitialize(zzH,0);ArrayInitialize(nen_ZigZag,0);
      init_zz=true;
      return;
     }

   counted_bars=IndicatorCounted();
  
   if (perTF!=Period())
     {
      delete_objects1();  
      perTF=Period();
     }

   if (Demo!=IsDemo())
     {
      delete_objects1();  
      Demo=IsDemo();
      counted_bars=0;
     }

//-----------------------------------------
//
//     1.
//
// Блок заполнения буферов. Начало. 
//-----------------------------------------   
// zz[] - буфер, данные из которого берутся для отрисовки самого ZigZag-a
// zzL[] - массив минимумов черновой
// zzH[] - массив максимумов черновой
//
//-----------------------------------------   

   if (Bars-IndicatorCounted()>2)
     {
      if (ExtMaxBar>0) cbi=ExtMaxBar; else cbi=Bars-1;
      tiZZ=0;
      if (ExtIndicator==1) {ti=0; ai=0; bi=0; tai=0; tbi=0; fs=0; si=0; sip=0;} lBar=0; hBar=0;
      ArrayInitialize(zz,0);ArrayInitialize(zzL,0);ArrayInitialize(zzH,0);ArrayInitialize(nen_ZigZag,0);
      init_zz=true; afrm=true; delete_objects_dinamic(); delete_objects1(); delete_objects3();
      flagExtGartleyTypeSearch2=false; vPatOnOff=0; PeakDetIni=true;
     }
   else
     {
      if (ExtIndicator==1) cbi=Bars-IndicatorCounted()-1;
      else cbi=Bars-IndicatorCounted();

      if (ExtMinBar>0)
        {
         if ((ExtIndicator==0||ExtIndicator==1||ExtIndicator==2||ExtIndicator==3||ExtIndicator==5||ExtIndicator==6||ExtIndicator==7||ExtIndicator==8||ExtIndicator==10||ExtIndicator==11) && tiZZ==iTime(NULL,GrossPeriod,0))
         return (0);
        }

      if (lBar<=iLow(NULL,GrossPeriod,0) && hBar>=iHigh(NULL,GrossPeriod,0) && tiZZ==iTime(NULL,GrossPeriod,0)) return(0);
      else
        {
         if (tiZZ<iTime(NULL,GrossPeriod,0)) 
           {
            if (iBarShift(Symbol(),Period(),afr[0])==2 && ExtHidden<5)
              {
               if (ExtPivotZZ1Num==1 && ExtPivotZZ1Color>0) PivotZZ(ExtPivotZZ1Color, ExtPivotZZ1Num, 1);
               if (ExtPivotZZ2Num==1 && ExtPivotZZ2Color>0) PivotZZ(ExtPivotZZ2Color, ExtPivotZZ2Num, 2);
              }
           }
         lBar=iLow(NULL,GrossPeriod,0); hBar=iHigh(NULL,GrossPeriod,0); tiZZ=iTime(NULL,GrossPeriod,0);
        }
     }

   if (ExtGartleyTypeSearch<2 || ExtIndicator != 11) vNamePatternToNumberPattern = "";

   switch (ExtIndicator)
     {
      case 0     : {ZigZag_();      break;}
      case 1     : {ang_AZZ_();     break;}
      case 2     : {Ensign_ZZ();    break;}
      case 3     : {Ensign_ZZ();    break;}
      case 4     : {ZigZag_tauber();break;}
      case 5     : {GannSwing();    break;}
      case 6     : {nenZigZag();    break;} // DT-ZigZag - с исправленным, оптимизированным зигзагом ZigZag_new_nen3.mq4
      case 7     : {nenZigZag();    break;} // DT-ZigZag - вариант зигзага, который любезно предоставил klot - DT_ZZ.mq4
      case 8     : {nenZigZag();    break;} // DT-ZigZag - вариант зигзага, который любезно предоставил Candid - CZigZag.mq4
      case 10    : {nenZigZag();    break;} // DT-ZigZag - вариант зигзага ExtIndicator=5 в режиме DT - внешний зигзаг Swing_zz.mq4
// Поиск паттернов
      case 11    : 
       {
        if (ExtGartleyTypeSearch<2) vPatOnOff = 0;
        ZigZag_();
        if (ExtGartleyTypeSearch==2 && vPatOnOff == 1) flagExtGartleyTypeSearch2=true;

        if (vPatOnOff==1 && vPatNew==0)
          {
           vPatNew=1; flagGartley=true;
           if(ExtPlayAlert) 
           {
            Alert (Symbol(),"  ",Period(),"  появился новый Паттерн");
            PlaySound("alert.wav");
           }
           if (ExtSendMail) _SendMail("There was a pattern","on  " + Symbol() + " " + Period() + " pattern " + vBullBear + " " + vNamePattern);
          }
        else if (vPatOnOff==0 && vPatNew==1)
          {
           vPatNew=0; flagGartley=true; FlagForD=true;
          }

        if (minBarsSave!=minBarsX)
          {
           afrm=true; delete_objects_dinamic(); delete_objects1(); counted_bars=0; minBarsSave=minBarsX; PeakDetIni=true;
          }
        break;
       } 

      case 12    : {ZZTalex(minBars);break;}
      case 13    : {ZigZag_SQZZ();break;}  // ZigZag товароведа     
      case 14    : {ZZ_2L_nen();break;}   // ZigZag wellx     
     }

   if (ExtHidden<5) // Разрешение на вывод оснастки. Начало.
     {
      if(!chHL_PeakDet_or_vts)
        {
         if (ExtLabel==0) {i_vts(); i_vts1();}
        }
      else if (PeakDetIni && PeakDet)
        {
         PeakDetIni=false;
         double kl=0,kh=0;  // kl - min; kh - max

         for (shift=Bars; shift>0; shift--)
           {
            if (zzH[shift]>0) {kh=zzH[shift];}
            if (zzL[shift]>0) {kl=zzL[shift];}

            lam[shift]=kl;
            ham[shift]=kh;
           }
        }
      // Инициализация матрицы
      matriza();
      if (infoTF) if (close_TF!=Close[0]) info_TF();

     }

//-----------------------------------------
// Блок заполнения буферов. Конец.
//-----------------------------------------   

   if (ExtHidden<5) // Разрешение на вывод оснастки. Начало.
     {
//======================
//======================
//======================

//-----------------------------------------
//
//     2.
//
// Блок подготовки данных. Начало.
//-----------------------------------------   

      if (Bars - counted_bars>2 || flagFrNew)
        {

      // Поиск времени и номера бара, до которого будут рисоваться соединительные линии 
         if (countBarEnd==0)
           {
            if (ExtFractalEnd>0)
              {
               k=ExtFractalEnd;
               for (shift=0; shift<Bars && k>0; shift++) 
                 { 
                  if (zz[shift]>0 && zzH[shift]>0) {countBarEnd=shift; TimeBarEnd=Time[shift]; k--;}
                 }
              }
            else 
              {
               countBarEnd=Bars-3;
               TimeBarEnd=Time[Bars-3];
              }
           }
         else
           {
            countBarEnd=iBarShift(Symbol(),Period(),TimeBarEnd); 
           }

        }
//-----------------------------------------
// Блок подготовки данных. Конец.
//-----------------------------------------   


//-----------------------------------------
//
//     3.
//
// Блок проверок и удаления линий, 
// потерявших актуальность. Начало.
//-----------------------------------------   
// Коррекция соединяющих линий и чисел. Начало.

      if (Bars - counted_bars<3)
        {
         // Поиск времени бара первого экстремума, считая от нулевого бара
         for (shift1=0; shift1<Bars; shift1++) 
           {
            if (zz[shift1]>0.0 && (zzH[shift1]==zz[shift1] || zzL[shift1]==zz[shift1])) 
             {
              timeFr1new=Time[shift1];
              break;
             }
           }
         // Поиск бара, на котором первый экстремум был ранее.
         shift=iBarShift(Symbol(),Period(),afr[0]); 


         // Появился новый луч ZigZag
         if ((zzH[shift1]>0 && afrl[0]>0) || (zzL[shift1]>0 && afrh[0]>0))
           {
            newRay=true;
            if (!ExtDinamic)
              {
               ExtNumberPeak=false;
               ExtFiboStatic=false;
               ExtPitchforkStatic=0;
               ExtFiboFanNum=0;
               ExtFiboExpansion=0;
               ExtVLStaticNum=0;
               ExtArcStaticNum=0;
               ExtSpiralNum=0;
               ExtPivotZZ2Num=0;
               ExtChannelsNum=0;
               ExtFiboTimeNum=0;
              }
            else
              {
               if (StringSubstr(ExtVisibleDinamic,0,1)!="1") ExtNumberPeak=false;
               if (StringSubstr(ExtVisibleDinamic,1,1)!="1") ExtFiboStatic=false;
               if (StringSubstr(ExtVisibleDinamic,2,1)!="1") ExtPitchforkStatic=0;
               if (StringSubstr(ExtVisibleDinamic,3,1)!="1") ExtFiboFanNum=0;
               if (StringSubstr(ExtVisibleDinamic,4,1)!="1") ExtFiboExpansion=0;
               if (StringSubstr(ExtVisibleDinamic,5,1)!="1") ExtVLStaticNum=0;
               if (StringSubstr(ExtVisibleDinamic,6,1)!="1") ExtArcStaticNum=0;
               if (StringSubstr(ExtVisibleDinamic,7,1)!="1") ExtSpiralNum=0;
               if (StringSubstr(ExtVisibleDinamic,8,1)!="1") ExtPivotZZ2Num=0;
               if (StringSubstr(ExtVisibleDinamic,9,1)!="1") ExtChannelsNum=0;
               if (StringSubstr(ExtVisibleDinamic,10,1)!="1") ExtFiboTimeNum=0;
              }
      
            if (ExtAlert)
             {
              Alert (Symbol(),"  ",Period(),"  появился новый луч ZigZag");
              PlaySound("alert.wav");
             }
           }

         // Сравнение текущего значения экстремума с тем, который был ранее

         // Образовался новый экстремум
         if (timeFr1new!=afr[0])
           {
            flagFrNew=true;
            if (shift>=shift1) numBar=shift; else  numBar=shift1;
            afrm=true;
           }

         // Экстремум на максимуме сдвинулся на другой бар
         if (afrh[0]>0 && zz[shift]==0.0)
           {
            flagFrNew=true;
            if (numBar<shift) numBar=shift;
            afrm=true;
           }
         // Экстремум на минимуме сдвинулся на другой бар
         if (afrl[0]>0 && zz[shift]==0.0)
           {
            flagFrNew=true;
            if (numBar<shift) numBar=shift;
            afrm=true;
           }

//-----------3 Сместился максимум или минимум, но остался на том же баре. Начало.

//============= 1 сместился максимум. Начало.
         if (afrh[0]-High[shift]!=0 && afrh[0]>0)
           {
            flagFrNew=true;
            numBar=0;
            delete_objects2(afr[0]);
            afrx[0]=High[shift];
            afrh[0]=High[shift];
            if (ExtFiboFanDinamic) screenFiboFanD();
            if (mFibo[1]==0 && ExtFiboStatic) screenFiboS();
            if (ExtFiboDinamic) screenFiboD();
            if (ExtPitchforkDinamic>0) screenPitchforkD();
            if (ExtVLDinamicColor>0) VLD();
            if (mVL[2]==0 && ExtVLStaticNum>0) VLS();
            if (ExtFiboTimeNum>2) fiboTimeX ();
            if (ExtPitchforkStatic>0)
              {
               if (ExtCustomStaticAP)
                 {
                  screenPitchforkS();
                 }
               else
                 {
                  if (ExtPitchforkCandle)
                   {
                     if (iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)==0) screenPitchforkS();
                    }
                  else
                    {
                     if (mPitch[2]==0) screenPitchforkS();
                    }
                 }
              }
            if (mExpansion[2]==0 && ExtFiboExpansion>0) FiboExpansion();
            if (mFan[1]==0 && ExtFiboFanNum>0 && ExtFiboFanColor>0) screenFiboFan();
            if (ExtArcDinamicNum>0) screenFiboArcD();
            if (ExtArcStaticNum>0) screenFiboArcS();
           }
//============= 1 сместился максимум. Конец.
//
//============= 1 сместился минимум. Начало.
         if (afrl[0]-Low[shift]!=0 && afrl[0]>0)
           {
            flagFrNew=true;
            numBar=0;
            delete_objects2(afr[0]);
            afrx[0]=Low[shift];
            afrl[0]=Low[shift];
            if (mFibo[1]==0 && ExtFiboStatic) screenFiboS();
            if (ExtFiboDinamic) screenFiboD();
            if (ExtPitchforkDinamic>0) screenPitchforkD();
            if (ExtFiboFanDinamic) screenFiboFanD();
            if (ExtVLDinamicColor>0) VLD();
            if (mVL[2]==0 && ExtVLStaticNum>0) VLS();
            if (ExtFiboTimeNum>2) fiboTimeX ();
            if (ExtPitchforkStatic>0)
              {
               if (ExtCustomStaticAP)
                 {
                  screenPitchforkS();
                 }
               else
                 {
                  if (ExtPitchforkCandle)
                    {
                     if (iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)==0) screenPitchforkS();
                    }
                  else
                    {
                     if (mPitch[2]==0) screenPitchforkS();
                    }
                 }
              }
            if (mExpansion[2]==0 && ExtFiboExpansion>0) FiboExpansion();
            if (mFan[1]==0 && ExtFiboFanNum>0 && ExtFiboFanColor>0) screenFiboFan();
            if (ExtArcDinamicNum>0) screenFiboArcD();
            if (ExtArcStaticNum>0) screenFiboArcS();
           }
//============= 1 сместился минимум. Конец.
//-----------3 Сместился максимум или минимум, но остался на том же баре. Конец.

        // Поиск исчезнувших фракталов и удаление линий, исходящих от этих фракталов. Начало.
        countBarEnd=iBarShift(Symbol(),Period(),TimeBarEnd);
        for (k=0; k<5; k++)
          {

           // Проверка максимумов.
           if (afrh[k]>0)
             {
              // Поиск бара, на котором был этот фрактал
              shift=iBarShift(Symbol(),Period(),afr[k]); 
              if (zz[shift]==0)
                {
                 flagFrNew=true;
                 if (shift>numBar) numBar=shift;
                 afrm=true;
                 numHighPrim=shift; numHighLast=0;HighLast=0.0;
                 for (k1=shift+1; k1<=countBarEnd; k1++)
                   {
                    if (zzH[k1]>0) 
                      {
                       if (ZigZagHighLow) HighLast=High[k1]; else HighLast=zzH[k1];
                       numHighLast=k1;

                       nameObj="_" + ExtComplekt + "ph" + Time[numHighPrim] + "_" + Time[numHighLast];

                       numOb=ObjectFind(nameObj);
                       if (numOb>-1)
                         {
                          ObjectDelete(nameObj); 

                          nameObjtxt="_" + ExtComplekt + "phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];

                          ObjectDelete(nameObjtxt);
                         }
                      }
                   }
                }
             }

           // Проверка минимумов.
           if (afrl[k]>0)
             {
              // Поиск бара, на котором был этот фрактал
              shift=iBarShift(Symbol(),Period(),afr[k]); 
              if (zz[shift]==0)
                {
                 flagFrNew=true;
                 if (shift>numBar) numBar=shift;

                 afrm=true;
                 numLowPrim=shift; numLowLast=0;LowLast=10000000;
                 for (k1=shift+1; k1<=countBarEnd; k1++)
                   {
                    if (zzL[k1]>0) 
                      {
                       if (ZigZagHighLow) LowLast=Low[k1]; else LowLast=zzL[k1];
                       numLowLast=k1;

                       nameObj="_" + ExtComplekt + "pl" + Time[numLowPrim] + "_" + Time[numLowLast];

                       numOb=ObjectFind(nameObj);
                       if (numOb>-1)
                         {
                          ObjectDelete(nameObj); 

                          nameObjtxt="_" + ExtComplekt + "pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];

                          ObjectDelete(nameObjtxt);
                         }
                      }
                   }
                }
             }
          }
        // Поиск исчезнувших фракталов и удаление линий, исходящих от этих фракталов. Конец.

        // Перезапись матрицы. Начало.
        matriza ();
        // Перезапись матрицы. Конец.

        }
// Коррекция соединяющих линий и чисел. Конец.
//-----------------------------------------
// Блок проверок и удаления линий, 
// потерявших актуальность. Конец.
//-----------------------------------------   


     // Подсчет количества фракталов. Начало.
     countFractal();
     // Подсчет количества фракталов. Конец.

//-----------------------------------------
//
//     4.
//
// Блок вывода соединительных линий. Начало.
//-----------------------------------------   
      if (Bars - counted_bars>2 && ExtHidden>0)
        {
//-----------1 Отрисовка максимумов. Начало.
//+--------------------------------------------------------------------------+
//| Вывод соединяющих линий и чисел Песавенто и 0.886 для максимумов ZigZag-a
//| Отрисовка начинается от нулевого бара
//+--------------------------------------------------------------------------+

         numLowPrim=0; numLowLast=0;
         numHighPrim=0; numHighLast=0;

         LowPrim=0.0; LowLast=0.0;
         HighPrim=0.0; HighLast=0.0;

         Angle=-100;
   
         if (flagFrNew && !flagGartley) countFr=1;
         else countFr=ExtFractal;

         for (k=0; (k<Bars-1 && countHigh1>0 && countFr>0); k++)
           {
            if (zzL[k]>0.0 && (zzL[k]<LowPrim || LowPrim==0.0) && HighPrim>0 && zzL[k]==zz[k])
              {
               if (ZigZagHighLow) LowPrim=Low[k]; else LowPrim=zzL[k]; 
               numLowPrim=k;
              }
            if (zzH[k]>0.0 && zzH[k]==zz[k])
              {
               if (HighPrim>0) 
                 {

                  if (ZigZagHighLow) HighLast=High[k]; else HighLast=zzH[k];
                  numHighLast=k;

                  HL=HighLast-LowPrim;
                  kj=(HighPrim-HighLast)*1000/(numHighLast-numHighPrim);
                  if (HL>0 && (Angle>=kj || Angle==-100))  // Проверка угла наклона линии
                    {
                     Angle=kj;
                     // Создание линии и текстового объекта
                     HLp=HighPrim-LowPrim;
                     k1=MathCeil((numHighPrim+numHighLast)/2);
                     kj=HLp/HL;
               
                     if (ExtPPWithBars==0) PPWithBars="";
                     else if (ExtPPWithBars==1) PPWithBars=" ("+(numHighLast-numHighPrim)+")";
                     else if (ExtPPWithBars==2) PPWithBars=" ("+(numHighLast-numLowPrim)+"-"+(numLowPrim-numHighPrim)+")";
                     else if (ExtPPWithBars==3)
                       {
                        int_to_d1=(numLowPrim-numHighPrim);
                        int_to_d2=(numHighLast-numLowPrim);
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==4)
                       {
                        int_to_d1=(Time[numLowPrim]-Time[numHighPrim]);
                        int_to_d2=(Time[numHighLast]-Time[numLowPrim]);
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==5)
                       {
                        int_to_d1=(numLowPrim-numHighPrim)*(High[numHighPrim]-Low[numLowPrim]);
                        int_to_d2=(numHighLast-numLowPrim)*(High[numHighLast]-Low[numLowPrim]);
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==7)
                       {
                        int_to_d1=((High[numHighLast]-Low[numLowPrim])/Point)/(numHighLast-numLowPrim);
                        int_to_d2=((High[numHighPrim]-Low[numLowPrim])/Point)/(numLowPrim-numHighPrim);
                        PPWithBars=" ("+DoubleToStr(int_to_d1,3)+"/"+DoubleToStr(int_to_d2,3)+")";
                       }
                     else if (ExtPPWithBars==8)
                       {
                        int_to_d1=MathSqrt((numLowPrim-numHighPrim)*(numLowPrim-numHighPrim) + ((High[numHighPrim]-Low[numLowPrim])/Point)*((High[numHighPrim]-Low[numLowPrim])/Point));
                        int_to_d2=MathSqrt((numHighLast-numLowPrim)*(numHighLast-numLowPrim) + ((High[numHighLast]-Low[numLowPrim])/Point)*((High[numHighLast]-Low[numLowPrim])/Point));
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==9)
                       {
                        int_to_d1=100-100*Low[numLowPrim]/High[numHighLast];
                        int_to_d2=100*High[numHighPrim]/Low[numLowPrim]-100;
                        PPWithBars=" ("+DoubleToStr(int_to_d1,1)+"/"+DoubleToStr(int_to_d2,1)+")";
                       }

// ExtPPWithBars=6 Вычисляется количство пунктов и процент отклонения от ретресмента "Песавенто"

                     ExtLine_=ExtLine;
                     if (kj>0.1 && kj<9.36)
                       {
                        // Создание текстового объекта (числа Песавенто). % восстановления между максимумами
                        kk=kj;
                        k2=1;
                        Pesavento_patterns();
                        if (k2<0)
                          // процент восстановления числа Песавенто и 0.886
                          {
                           ExtLine_=ExtLine886;
                           if (ExtHidden!=4)
                             {
                              nameObj="_" + ExtComplekt + "phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];
                              ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(HighPrim+HighLast)/2);

                              if (ExtPPWithBars==6)
                                {
                                 int_to_d=MathAbs((kk-kj)/kk)*100;
                                 PPWithBars=" ("+DoubleToStr((LowPrim+(HighLast-LowPrim)*kk-HighPrim)/Point,0)+"/"+DoubleToStr(int_to_d,2)+"%)";
                                }
                              descript=txtkk;
                              ObjectSetText(nameObj,txtkk+PPWithBars,ExtSizeTxt,"Arial", colorPPattern);
                              if (ExtPPWithBars==6) PPWithBars="";
                             }
                          }
                        else
                          // процент восстановления (не Песавенто и 0.886)
                          {
                           if (ExtHidden==1 || ExtHidden==4)
                             {
                              nameObj="_" + ExtComplekt + "phtxt" + Time[numHighPrim] + "_" + Time[numHighLast];

                              ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(HighPrim+HighLast)/2);

                              descript=DoubleToStr(kk,3);
                              if (ExtDeltaType==3)
                                {
                                 ObjectSetText(nameObj,""+DoubleToStr(kk,3)+PPWithBars,ExtSizeTxt,"Arial",colorPPattern);
                                }
                              else
                                {
                                 ObjectSetText(nameObj,""+DoubleToStr(kk,2)+PPWithBars,ExtSizeTxt,"Arial",colorPPattern);
                                }
                             }
                          }

                        if ((ExtHidden==2 && k2<0) || ExtHidden!=2)
                          {
                           nameObj="_" + ExtComplekt + "ph" + Time[numHighPrim] + "_" + Time[numHighLast];
                           ObjectCreate(nameObj,OBJ_TREND,0,Time[numHighLast],HighLast,Time[numHighPrim],HighPrim);

                           if (descript_b) ObjectSetText(nameObj,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" PPesavento "+"Line High "+descript);
                           ObjectSet(nameObj,OBJPROP_RAY,false);
                           ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                           ObjectSet(nameObj,OBJPROP_COLOR,ExtLine_);
                           ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
                          }
                        if (ExtFiboZigZag) k=countBarEnd;
                       }
                    }
                 }
               else 
                 {
                  if (ZigZagHighLow) HighPrim=High[k]; else HighPrim=zzH[k];
                  numHighPrim=k;
                 }
              }
            // Переход на следующий экстремум
            if (k>countBarEnd) 
              {
               k=numHighPrim+1; countHigh1--; countFr--;

               numLowPrim=0; numLowLast=0;
               numHighPrim=0; numHighLast=0;

               LowPrim=0.0; LowLast=0.0;
               HighPrim=0.0; HighLast=0.0;
   
               Angle=-100;
              }
           }
//-----------1 Отрисовка максимумов. Конец.

//-----------2 Отрисовка минимумов. Начало.
//+-------------------------------------------------------------------------+
//| Вывод соединяющих линий и чисел Песавенто и 0.886 для минимумов ZigZag-a
//| Отрисовка идет от нулевого бара
//+-------------------------------------------------------------------------+

         numLowPrim=0; numLowLast=0;
         numHighPrim=0; numHighLast=0;

         LowPrim=0.0; LowLast=0.0;
         HighPrim=0.0; HighLast=0.0;
   
         Angle=-100;

         if (flagFrNew && !flagGartley) countFr=1;
         else countFr=ExtFractal;
         flagFrNew=false;
         flagGartley=false;

         for (k=0; (k<Bars-1 && countLow1>0 && countFr>0); k++)
           {
            if (zzH[k]>HighPrim && LowPrim>0)
              {
               if (ZigZagHighLow) HighPrim=High[k]; else HighPrim=zzH[k];
               numHighPrim=k;
              }

            if (zzL[k]>0.0 && zzL[k]==zz[k]) 
              {
               if (LowPrim>0) 
                 {

                  if (ZigZagHighLow) LowLast=Low[k]; else LowLast=zzL[k];
                  numLowLast=k;

                  // вывод соединяющих линий и процентов восстановления(чисел Песавенто)
                  HL=HighPrim-LowLast;
                  kj=(LowPrim-LowLast)*1000/(numLowLast-numLowPrim);
                  if (HL>0 && (Angle<=kj || Angle==-100))  // Проверка угла наклона линии
                    {
                     Angle=kj;

                     HLp=HighPrim-LowPrim;
                     k1=MathCeil((numLowPrim+numLowLast)/2);
                     kj=HLp/HL;

                     if (ExtPPWithBars==0) PPWithBars="";
                     else if (ExtPPWithBars==1) PPWithBars=" ("+(numLowLast-numLowPrim)+")";
                     else if (ExtPPWithBars==2) PPWithBars=" ("+(numLowLast-numHighPrim)+"-"+(numHighPrim-numLowPrim)+")";
                     else if (ExtPPWithBars==3)
                       {
                        int_to_d1=(numHighPrim-numLowPrim);
                        int_to_d2=(numLowLast-numHighPrim);
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==4)
                       {
                        int_to_d1=(Time[numHighPrim]-Time[numLowPrim]);
                        int_to_d2=(Time[numLowLast]-Time[numHighPrim]);
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==5)
                       {
                        int_to_d1=(numHighPrim-numLowPrim)*(High[numHighPrim]-Low[numLowPrim]);
                        int_to_d2=(numLowLast-numHighPrim)*(High[numHighPrim]-Low[numLowLast]);
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==7)
                       {
                        int_to_d1=((High[numHighPrim]-Low[numLowLast])/Point)/(numLowLast-numHighPrim);
                        int_to_d2=((High[numHighPrim]-Low[numLowPrim])/Point)/(numHighPrim-numLowPrim);
                        PPWithBars=" ("+DoubleToStr(int_to_d1,3)+"/"+DoubleToStr(int_to_d2,3)+")";
                       }
                     else if (ExtPPWithBars==8)
                       {
                        int_to_d1=MathSqrt((numHighPrim-numLowPrim)*(numHighPrim-numLowPrim) + ((High[numHighPrim]-Low[numLowPrim])/Point)*((High[numHighPrim]-Low[numLowPrim])/Point));
                        int_to_d2=MathSqrt((numLowLast-numHighPrim)*(numLowLast-numHighPrim) + ((High[numHighPrim]-Low[numLowLast])/Point)*((High[numHighPrim]-Low[numLowLast])/Point));
                        int_to_d=int_to_d1/int_to_d2;
                        PPWithBars=" ("+DoubleToStr(int_to_d,2)+")";
                       }
                     else if (ExtPPWithBars==9)
                       {
                        int_to_d1=100*High[numHighPrim]/Low[numLowLast]-100;
                        int_to_d2=100-100*Low[numLowPrim]/High[numHighPrim];
                        PPWithBars=" ("+DoubleToStr(int_to_d1,1)+"/"+DoubleToStr(int_to_d2,1)+")";
                       }

// ExtPPWithBars=6 Вычисляется количство пунктов и процент отклонения от ретресмента "Песавенто"

                     ExtLine_=ExtLine;
                     if ( kj>0.1 && kj<9.36)
                       {
                        // Создание текстового объекта (числа Песавенто). % восстановления между минимумами
                        kk=kj;
                        k2=1;
                        Pesavento_patterns();
                        if (k2<0)
                        // процент восстановления числа Песавенто и 0.886
                          {
                           ExtLine_=ExtLine886;
                           if (ExtHidden!=4)                  
                             {
                              nameObj="_" + ExtComplekt + "pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];
                              ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(LowPrim+LowLast)/2);

                              if (ExtPPWithBars==6)
                                {
                                 int_to_d=MathAbs((kk-kj)/kk)*100;
                                 PPWithBars=" ("+DoubleToStr((HighPrim-(HighPrim-LowLast)*kk-LowPrim)/Point,0)+"/"+DoubleToStr(int_to_d,2)+"%)";
                                }
                              descript=txtkk;
                              ObjectSetText(nameObj,txtkk+PPWithBars,ExtSizeTxt,"Arial", colorPPattern);
                              if (ExtPPWithBars==6) PPWithBars="";
                             }
                          }
                        else 
                          // процент восстановления (не Песавенто и 0.886)
                          { 
                           if (ExtHidden==1 || ExtHidden==4)
                             {
                              nameObj="_" + ExtComplekt + "pltxt" + Time[numLowPrim] + "_" + Time[numLowLast];

                              ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(LowPrim+LowLast)/2);
      
                              descript=DoubleToStr(kk,3);
                              if (ExtDeltaType==3)
                                {
                                 ObjectSetText(nameObj,""+DoubleToStr(kk,3)+PPWithBars,ExtSizeTxt,"Arial",colorPPattern);
                                }
                              else
                                {
                                 ObjectSetText(nameObj,""+DoubleToStr(kk,2)+PPWithBars,ExtSizeTxt,"Arial",colorPPattern);
                                }
                             }
                           }

                         if ((ExtHidden==2 && k2<0) || ExtHidden!=2)
                           {
                            nameObj="_" + ExtComplekt + "pl" + Time[numLowPrim] + "_" + Time[numLowLast];

                            ObjectCreate(nameObj,OBJ_TREND,0,Time[numLowLast],LowLast,Time[numLowPrim],LowPrim);

                            if (descript_b) ObjectSetText(nameObj,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" PPesavento "+"Line Low "+descript);
                            ObjectSet(nameObj,OBJPROP_RAY,false);
                            ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                            ObjectSet(nameObj,OBJPROP_COLOR,ExtLine_);
                            ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
                           }
                         if (ExtFiboZigZag) k=countBarEnd;
                        }
                     }
                 }
               else
                 {
                  numLowPrim=k; 
                  if (ZigZagHighLow) LowPrim=Low[k]; else LowPrim=zzL[k];
                 }
              }
            // Переход на следующий экстремум
            if (k>countBarEnd) 
              {
               k=numLowPrim+1; countLow1--; countFr--;

               numLowPrim=0; numLowLast=0;
               numHighPrim=0; numHighLast=0;

               LowPrim=0.0; LowLast=0.0;
               HighPrim=0.0; HighLast=0.0;
  
               Angle=-100;
              }
           }

//-----------2 Отрисовка минимумов. Конец.

        }
//-----------------------------------------
// Блок вывода соединительных линий. Конец.
//-----------------------------------------   

//======================
//======================
//======================
     } // Разрешение на вывод оснастки. Конец.

   if (mAP)
     {
      if (mAPs || mAPd)
        {
         metkaAP(true);  // Создание меток в вилах Эндрюса
        }
      else if (mTime<iTime(NULL,Period(),0))
        {
         if (_ExtPitchforkStatic>0) {mAPs=true; delete_objects6();}
         if (ExtPitchforkDinamic>0) {mAPd=true; delete_objects7();}
         if (mAPs || mAPd) metkaAP(true);  // корректировка положения меток в вилах Эндрюса
         mTime=iTime(NULL,Period(),0);
        }
      else   // Регулировка цвета меток в вилах Эндрюса
        {
         metkaAP(false);
        }
     }
return;
// КОНЕЦ
  } // start

//----------------------------------------------------
//  Подпрограммы и функции
//----------------------------------------------------

//--------------------------------------------------------
// Подсчет количества экстремумов. Минимумов и максимумов. Начало.
//--------------------------------------------------------
void countFractal()
  {
   int shift;
   countLow1=0;
   countHigh1=0;
   if (flagFrNew && !flagGartley)
     {
      for(shift=0; shift<=numBar; shift++)
        {
         if (zzL[shift]>0.0) {countLow1++;}
         if (zzH[shift]>0.0) {countHigh1++;}    
        }

      numBar=0;  
      counted_bars=Bars-4;
     }
   else
     {
      if (flagGartley)  {counted_bars=0;}
      for(shift=0; shift<=countBarEnd; shift++)
        {
         if (zzL[shift]>0.0) {countLow1++;}
         if (zzH[shift]>0.0) {countHigh1++;}
        }
     }
  }
//--------------------------------------------------------
// Подсчет количества экстремумов. Минимумов и максимумов. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Формирование матрицы. Начало.
//
// Матрица используется для поиска исчезнувших экстремумов.
// Это инструмент компенсации непредвиденных закидонов стандартного ZigZag-a.
//
// Также выводятся статические и динамические фибы и вееры Фибоначчи,
// вилы Эндрюса...
//------------------------------------------------------
void matriza()
  {
   if (afrm && ExtHidden<5)
     {
      afrm=false;
      int shift,k,m;
      double kl=0,kh=0;

      if (ExtMaxBar>0) cbi=ExtMaxBar; else cbi=Bars;

      k=0; m=0;
      for (shift=0; shift<cbi && k<10; shift++)
        {
         if (zz[shift]>0)
           {
            afrx[k]=zz[shift];
            afr[k]=Time[shift];
            if (zz[shift]==zzL[shift])
              {
               kl=zzL[shift];
               if (ZigZagHighLow) afrl[k]=Low[shift]; 
               else
                 {
                  if (k==0) afrl[k]=Low[shift]; else  afrl[k]=zzL[shift];
                 }
               afrh[k]=0.0;
              }
            if (zz[shift]==zzH[shift])
              {
               kh=zzH[shift];
               if (ZigZagHighLow) afrh[k]=High[shift]; 
               else
                 {
                  if (k==0) afrh[k]=High[shift]; else afrh[k]=zzH[shift];
                 }
               afrl[k]=0.0;
              }
            k++;

            if (infoMerrillPattern)
              {
               if (m<6)
                 {
                  if (m<5)
                    {
                     mPeak0[m][0]=zz[shift];
                    }
                  if (m>0)
                    {
                     mPeak1[m-1][0]=zz[shift];
                    }
                  m++;
                 }
              }
           }
        }

      if (infoMerrillPattern)
        {
         ArraySort(mPeak1,5,0,MODE_ASCEND);
         ArraySort(mPeak0,5,0,MODE_ASCEND);
        }

      if (PeakDet && chHL_PeakDet_or_vts)
        {
         // kl - min; kh - max
         for (k=shift; k>0; k--)
           {
            if (zzH[k]>0) {kh=zzH[k];}
            if (zzL[k]>0) {kl=zzL[k];}

            if (kl>0) lam[k]=kl;
            if (kh>0) ham[k]=kh;
           }
        }

      // Вывод Fibo Time вне вил Эндрюса
      if (ExtFiboTimeNum>2) fiboTimeX(); // должно вызываться раньше вызова статических вил Эндрюса

      // Вывод вил Эндрюса
      if (ExtPitchforkStatic>0)
        {
         if (ExtCustomStaticAP)
           {
            screenPitchforkS();
           }
         else
           {
            if (newRay && mPitch[2]>0) screenPitchforkS();
            if (ExtPitchforkCandle)
              {
               if (iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)==0) screenPitchforkS();
              }
            else
              {
               if (mPitch[2]==0) screenPitchforkS();
              }
           }
        }
      if (ExtPitchforkDinamic>0) screenPitchforkD();

      // Вывод каналлов.
      if (ExtChannelsNum>1 || DinamicChannels>0) Channels();

      // Вывод статических и динамических фиб.
      if (ExtFiboStatic)
        {
         if (newRay && mFibo[1]>0) screenFiboS();
         if (mFibo[1]==0) screenFiboS();
        }
      if (ExtFiboDinamic) screenFiboD();

      // Расширения Фибоначчи
      if (ExtFiboExpansion>0)
        {
         if (newRay && mExpansion[2]>0) FiboExpansion();
         if (mExpansion[2]==0) FiboExpansion();
        }

      // Вывод фибовееров
      if (ExtFiboFanNum>0 && ExtFiboFanColor>0)
        {
         if (newRay && mFan[1]>0) screenFiboFan();
         if (mFan[1]==0) screenFiboFan();
        }
      if (ExtFiboFanDinamic) screenFiboFanD();

      // Вывод Versum Levels
      if (ExtVLStaticColor>0)
        {
         if (newRay && mVL[2]>0 && ExtVLStaticNum>0) VLS();
         if (mVL[2]==0) VLS();
        }
      if (ExtVLDinamicColor>0) VLD();

      // Вывод PivotZZ динамические
      if (ExtPivotZZ1Num==1 && ExtPivotZZ1Color>0) PivotZZ(ExtPivotZZ1Color, ExtPivotZZ1Num, 1);
      if (ExtPivotZZ2Num==1 && ExtPivotZZ2Color>0) PivotZZ(ExtPivotZZ2Color, ExtPivotZZ2Num, 2);

      // Вывод PivotZZ статические
      if (newRay && ExtPivotZZ1Num>1 && ExtPivotZZ1Color>0) PivotZZ(ExtPivotZZ1Color, ExtPivotZZ1Num, 1);
      if (newRay && ExtPivotZZ2Num>1 && ExtPivotZZ2Color>0) PivotZZ(ExtPivotZZ2Color, ExtPivotZZ2Num, 2);

      // Вывод фибодуг
      if (ExtArcDinamicNum>0) screenFiboArcD();
      if (newRay && ExtArcStaticNum>0) screenFiboArcS();

      // Вывод спирали
      if (newRay && ExtSpiralNum>0) GoldenSpiral(afr[mSpiral[0]],afrx[mSpiral[0]],afr[mSpiral[1]],afrx[mSpiral[1]]);

      // Поиск паттернов Gartley
      if (ExtGartleyOnOff)
        {
         switch (ExtIndicator)
           {
            case 0     : {_Gartley("ExtIndicator=0_" + minBars+"/"+ExtDeviation+"/"+ExtBackstep,0);break;}
            case 1     : {_Gartley("ExtIndicator=1_" + minSize+"/"+minPercent,0);break;}
            case 2     : {_Gartley("ExtIndicator=2_" + minBars+"/"+minSize,0);break;}
            case 3     : {_Gartley("ExtIndicator=3_" + minBars,0);break;}
            case 4     : {_Gartley("ExtIndicator=4_" + minSize,0);break;}
            case 5     : {_Gartley("ExtIndicator=5_" + minBars,0);break;}
            case 6     : {_Gartley("ExtIndicator=6_" + minBars+"/"+ExtDeviation+"/"+ExtBackstep,0);break;}
            case 7     : {_Gartley("ExtIndicator=7_" + minBars,0);break;}
            case 8     : {_Gartley("ExtIndicator=8_" + minBars+"/"+ExtDeviation,0);break;}
            case 10    : {_Gartley("ExtIndicator=10_" + minBars,0);break;}
            case 12    : {_Gartley("ExtIndicator=12_" + minBars,0);break;}
            case 13    : {_Gartley("ExtIndicator=13_" + minBars+"/"+minSize,0);break;}
            case 14    : {_Gartley("ExtIndicator=14_" + minBars,0);break;}
           }

         if (vPatOnOff==1 && vPatNew==0)
           {
            vPatNew=1;
            if (ExtSendMail) _SendMail("There was a pattern","on  " + Symbol() + " " + Period() + " pattern " + vBullBear + " " + vNamePattern);
           }
         else if (vPatOnOff==0 && vPatNew==1) {vPatNew=0; FlagForD=true;}
        }
      
      ExtSave=false;
     }
   if (newRay && ExtNumberPeak) NumberPeak();
   newRay=false;
  }
//--------------------------------------------------------
// Формирование матрицы. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод номеров переломов зигзагов. Начало
//--------------------------------------------------------
void NumberPeak()
  {
   int n=0,i,endNumber;
   string txt;
   if (ExtNumberPeak10) endNumber=iBarShift(Symbol(),Period(),afr[9]); else endNumber=Bars-minBars;
   
   delete_objects_number();

   for (i=iBarShift(Symbol(),Period(),afr[0])+1;i<endNumber;i++)
     {
      if (zz[i]>0)
        {
         n++;
         if (ExtNumberPeakLow)
           {
            if (zzL[i]>0)
              {
               txt=DoubleToStr(n,0);
               nameObj="NumberPeak" + "_" + ExtComplekt + "_" + n;
               ObjectCreate(nameObj,OBJ_TEXT,0,Time[i],zz[i]);
               ObjectSetText(nameObj,txt,ExtNumberPeakFontSize,"Arial",ExtNumberPeakColor);
              }
           }
         else
           {
            txt=DoubleToStr(n,0);
            nameObj="NumberPeak" + "_" + ExtComplekt + "_" + n;
            ObjectCreate(nameObj,OBJ_TEXT,0,Time[i],zz[i]);
            ObjectSetText(nameObj,txt,ExtNumberPeakFontSize,"Arial",ExtNumberPeakColor);
           }
        }
     }
   }
//--------------------------------------------------------
// Вывод номеров переломов зигзагов. Конец
//--------------------------------------------------------

//--------------------------------------------------------
// Каналы. Начало.
//--------------------------------------------------------
void Channels()
  {
   int    i,j,k,m,n,nul,peakLeft,peakRight,peakBase;
   double tangens, sdvigH, sdvigL, sdvigH_, sdvigL_, cenaLTLeft, cenaLTRight, cenaLCLeft, cenaLCRight, wrcenaL, wrcenaR;
   datetime timeLTLeft, timeLTRight, timeLCLeft, timeLCRight;
   int    baseExtremum; // номер перелома зигзага (бар), от которого строится трендовая
   bool   fTrend=false; // =true - Bull проводим трендовую по минимумам, =false - Bear проводим трендовую по максимумам
   bool   dinamic=false;

   if (ExtChannelsNum==0 && DinamicChannels>0) dinamic=true;

//int o;
   k=0;
   for (i=0;i<=9;i++) {if (mChannels[i]>=0) k++;}

   // Каналы с линией тренда, первая точка которой на переломе зигзага, 
   // вторая точка построена по касательной к рынку на участке, охватываемом каналом. Начало.
   if (ExtTypeChannels==1)
     {
      if (dinamic) nul=DinamicChannels;
      else nul=1;

      for (i=1;i<k;i++)
        {
         sdvigH=0; sdvigL=0; sdvigH_=0; sdvigL_=0;

         peakLeft=iBarShift(Symbol(),Period(),afr[mChannels[i-1]],true);
         if (peakLeft<0) continue;
         peakRight=iBarShift(Symbol(),Period(),afr[mChannels[i]],true);
         if (peakRight<0) continue;
         if (peakLeft==peakRight) continue;
         if (afrx[mChannels[i-1]]<afrx[mChannels[i]]) fTrend=true; else fTrend=false;

         j=mChannels[i-1]-mChannels[i];
         if (j==1)
           {
            if (afrx[mChannels[i-1]]<afrx[mChannels[i]]) fTrend=true; else fTrend=false;
            baseExtremum=mChannels[i-1];
           }
         else if (j==2)
           {
            if (afrx[mChannels[i-1]]<afrx[mChannels[i]])
              { 
               fTrend=true;
               if (afrx[mChannels[i-1]]<afrx[mChannels[i-1]-1]) baseExtremum=mChannels[i-1]; else baseExtremum=mChannels[i-1]-1;
              }
            else
              {
               fTrend=false;
               if (afrx[mChannels[i-1]]<afrx[mChannels[i-1]-1]) baseExtremum=mChannels[i-1]-1; else baseExtremum=mChannels[i-1];
              }
           }

         peakBase=iBarShift(Symbol(),Period(),afr[baseExtremum]);
         tangens=(afrx[mChannels[i]]-afrx[baseExtremum])/(peakBase-peakRight);

         for (j=peakBase;j>=peakRight;j--) // вычисляем tangens
           {
            if (fTrend)
              {
               if (afrx[baseExtremum] + tangens*(peakBase-j)-Low[j]>0) tangens=(Low[j]-afrx[baseExtremum])/(peakBase-j);
              }
            else
              {
               if (High[j] - (afrx[baseExtremum] + tangens*(peakBase-j))>0) tangens=(High[j]-afrx[baseExtremum])/(peakBase-j);
              }
           }

         for (j=peakLeft;j>=peakRight;j--) // вычисляем сдвиги
           {
            if (fTrend)
              {
               sdvigH_=High[j] - (afrx[baseExtremum] + tangens*(peakBase-j));
               if (sdvigH_>sdvigH) {sdvigH=sdvigH_; cenaLCRight=High[j]+tangens*(j-peakRight);}
              }
            else
              {
               sdvigL_=afrx[baseExtremum] + tangens*(peakBase-j)-Low[j];
               if (sdvigL_>sdvigL) {sdvigL=sdvigL_; cenaLCRight=Low[j]+tangens*(j-peakRight);}
              }
           }
         timeLCRight=afr[mChannels[i]];

         if (ExtTypeLineChannels==0)
           {
            while (j>0)
              {
               if (fTrend)
                 {
                  if (afrx[baseExtremum] + tangens*(peakBase-j)-Low[j]>sdvigL) break;
                 }
               else
                 {
                  if (High[j] - (afrx[baseExtremum] + tangens*(peakBase-j))>sdvigH) break;
                 }
               j--;
              }
           }

         if (j<0) j=0;

         nameObj="LTChannel" + i + ExtComplekt+"_";
         if (ExtSave)
           {
            if (i!=DinamicChannels) nameObj=nameObj + save;
           }
         ObjectDelete(nameObj);

         if (fTrend)
           {
            timeLTLeft=afr[mChannels[i-1]];  cenaLTLeft=afrx[baseExtremum]-tangens*(peakLeft-peakBase);
            timeLTRight=Time[j]; cenaLTRight=afrx[baseExtremum] + tangens*(peakBase-j)-sdvigL;
           }
         else
           {
            timeLTLeft=afr[mChannels[i-1]]; cenaLTLeft=afrx[baseExtremum]-tangens*(peakLeft-peakBase);
            timeLTRight=Time[j]; cenaLTRight=afrx[baseExtremum] + tangens*(peakBase-j)+sdvigH;
           }

         if (ExtTypeLineChannels==1 || ExtTypeLineChannels==3)
           {
            n=j;
            wrcenaR=cenaLTRight;
            if (fTrend)
              {
               while (cenaLTRight<=afrx[mChannels[i]] && n>0) {n--; cenaLTRight=wrcenaR+tangens*(j-n);}
              }
            else
              {
               while (cenaLTRight>=afrx[mChannels[i]] && n>0) {n--; cenaLTRight=wrcenaR+tangens*(j-n);}
              }
            timeLTRight=Time[n];
            timeLTLeft=afr[baseExtremum];  cenaLTLeft=afrx[baseExtremum];
           }

         ObjectCreate(nameObj,OBJ_TREND,0,timeLTLeft,cenaLTLeft,timeLTRight,cenaLTRight);
         if (ExtTypeLineChannels<2) ObjectSet(nameObj,OBJPROP_RAY,ExtRay);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtLTColor);
         ObjectSet(nameObj,OBJPROP_STYLE,ExtLTChannelsStyle);
         ObjectSet(nameObj,OBJPROP_WIDTH,ExtLTChannelsWidth);
         
         nameObj="LCChannel" + i + ExtComplekt+"_";
         if (ExtSave)
           {
            if (i!=DinamicChannels) nameObj=nameObj + save;
           }
         ObjectDelete(nameObj);

         if (fTrend)
           {
            cenaLCLeft=afrx[baseExtremum]+sdvigH-tangens*(peakLeft-peakBase);
           }
         else
           {
            cenaLCLeft=afrx[baseExtremum]-sdvigL-tangens*(peakLeft-peakBase);
           }
         timeLCLeft=afr[mChannels[i-1]];

         if (ExtTypeLineChannels==1 || ExtTypeLineChannels==3)
           {
            m=peakLeft;
            wrcenaL=cenaLCLeft;
            n=peakRight;
            wrcenaR=cenaLCRight;
            if (fTrend)
              {
               while (cenaLCLeft>=afrx[baseExtremum] && m<=Bars) {m++; cenaLCLeft=wrcenaL-tangens*(m-peakLeft);}
               while (cenaLCRight>=afrx[mChannels[i]] && n<=peakLeft) {n++; cenaLCRight=wrcenaR-tangens*(n-peakRight);}
              }
            else
              {
               while (cenaLCLeft<=afrx[baseExtremum] && m<=Bars) {m++; cenaLCLeft=wrcenaL-tangens*(m-peakLeft);}
               while (cenaLCRight<=afrx[mChannels[i]] && n<=peakLeft) {n++; cenaLCRight=wrcenaR-tangens*(n-peakRight);}
              }
            timeLCLeft=Time[m];
            cenaLCRight=wrcenaR-tangens*(n-1-peakRight);
            timeLCRight=Time[n-1];
           }

         ObjectCreate(nameObj,OBJ_TREND,0,timeLCLeft,cenaLCLeft,timeLCRight,cenaLCRight);
         if (ExtTypeLineChannels<2) ObjectSet(nameObj,OBJPROP_RAY,ExtRay);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtLCColor);
         ObjectSet(nameObj,OBJPROP_STYLE,ExtLCChannelsStyle);
         ObjectSet(nameObj,OBJPROP_WIDTH,ExtLCChannelsWidth);

         if (dinamic) break;
        }
     }
   // Каналы с линией тренда, первая точка которой на переломе зигзага, 
   // вторая точка построена по касательной к рынку на участке, охватываемом каналом. Конец.

   // Каналы, параллельные лучу зигзага. Начало.
   if (ExtTypeChannels==2)
     {
      if (dinamic) nul=DinamicChannels;
      else nul=1;

      for (i=1;i<k;i++)
        {
         sdvigH=0; sdvigL=0; sdvigH_=0; sdvigL_=0;

         peakLeft=iBarShift(Symbol(),Period(),afr[mChannels[i-1]],true);
         if (peakLeft<0) continue;
         peakRight=iBarShift(Symbol(),Period(),afr[mChannels[i]],true);

         if (peakRight<0) continue;
         if (peakLeft==peakRight) continue;
         if (afrx[mChannels[i-1]]<afrx[mChannels[i]]) fTrend=true; else fTrend=false;

         tangens=(afrx[mChannels[i]]-afrx[mChannels[i-1]])/(peakLeft-peakRight);

         for (j=peakLeft;j>=peakRight;j--) // вычисляем сдвиги
           {
            sdvigH_=High[j] - (afrx[mChannels[i-1]] + tangens*(peakLeft-j));
            sdvigL_=afrx[mChannels[i-1]] + tangens*(peakLeft-j)-Low[j];
            if (sdvigH_>sdvigH) sdvigH=sdvigH_;
            if (sdvigL_>sdvigL) sdvigL=sdvigL_;
           }

         if (ExtTypeLineChannels==0)
           {
            while (j>=0)
              {
               if (fTrend)
                 {
                  if (afrx[mChannels[i-1]] + tangens*(peakLeft-j)-Low[j]>sdvigL) break;
                 }
               else
                 {
                  if (High[j] - (afrx[mChannels[i-1]] + tangens*(peakLeft-j))>sdvigH) break;
                 }
               j--;
              }
           }

         if (j<0) j=0;

         nameObj="LTChannel" + i + ExtComplekt+"_";
         if (ExtSave)
           {
            if (i!=DinamicChannels) nameObj=nameObj + save;
           }
         ObjectDelete(nameObj);
         if (fTrend)
           {
            timeLTLeft=afr[mChannels[i-1]];  cenaLTLeft=afrx[mChannels[i-1]]-sdvigL;
            timeLTRight=Time[j]; cenaLTRight=afrx[mChannels[i-1]] + tangens*(peakLeft-j)-sdvigL;
           }
         else
           {
            timeLTLeft=afr[mChannels[i-1]]; cenaLTLeft=afrx[mChannels[i-1]]+sdvigH;
            timeLTRight=Time[j]; cenaLTRight=afrx[mChannels[i-1]] + tangens*(peakLeft-j)+sdvigH;
           }

         if (ExtTypeLineChannels==1 || ExtTypeLineChannels==3)
           {
            if (fTrend)
              {
               m=peakLeft;
               wrcenaL=cenaLTLeft;
               while (cenaLTLeft<afrx[mChannels[i-1]] && m>=peakRight) {m--; cenaLTLeft=wrcenaL+tangens*(peakLeft-m);}
               timeLTLeft=Time[m+1];  cenaLTLeft=wrcenaL+tangens*(peakLeft-m-1);

               n=peakRight;
               wrcenaR=cenaLTRight;
               while (cenaLTRight<afrx[mChannels[i]] && n>0) {n--; cenaLTRight=wrcenaL+tangens*(peakLeft-n);}
               timeLTRight=Time[n];
              }
            else
              {
               m=peakLeft;
               wrcenaL=cenaLTLeft;
               while (cenaLTLeft>=afrx[mChannels[i-1]] && m>=peakRight) {m--; cenaLTLeft=wrcenaL+tangens*(peakLeft-m);}
               timeLTLeft=Time[m+1];  cenaLTLeft=wrcenaL+tangens*(peakLeft-m-1);

               n=peakRight;
               wrcenaR=cenaLTRight;
               while (cenaLTRight>afrx[mChannels[i]] && n>0) {n--; cenaLTRight=wrcenaL+tangens*(peakLeft-n);}
               timeLTRight=Time[n];
              }
            }

         ObjectCreate(nameObj,OBJ_TREND,0,timeLTLeft,cenaLTLeft,timeLTRight,cenaLTRight);
         if (ExtTypeLineChannels<2) ObjectSet(nameObj,OBJPROP_RAY,false);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtLTColor);
         ObjectSet(nameObj,OBJPROP_STYLE,ExtLTChannelsStyle);
         ObjectSet(nameObj,OBJPROP_WIDTH,ExtLTChannelsWidth);
         
         nameObj="LCChannel" + i + ExtComplekt+"_";
         if (ExtSave)
           {
            if (i!=DinamicChannels) nameObj=nameObj + save;
           }
         ObjectDelete(nameObj);
         if (fTrend)
           {
            timeLCLeft=afr[mChannels[i-1]]; cenaLCLeft=afrx[mChannels[i-1]]+sdvigH;
            timeLCRight=afr[mChannels[i]]; cenaLCRight=afrx[mChannels[i]]+sdvigH;
           }
         else
           {
            timeLCLeft=afr[mChannels[i-1]]; cenaLCLeft=afrx[mChannels[i-1]]-sdvigL;
            timeLCRight=afr[mChannels[i]]; cenaLCRight=afrx[mChannels[i]]-sdvigL;
           }

         if (ExtTypeLineChannels==1 || ExtTypeLineChannels==3)
           {
            if (fTrend)
              {
               m=peakLeft;
               wrcenaL=cenaLCLeft;
               while (cenaLCLeft>afrx[mChannels[i-1]] && m<Bars) {m++; cenaLCLeft=wrcenaL-tangens*(m-peakLeft);}
               timeLCLeft=Time[m];
 
               n=peakRight;
               wrcenaR=cenaLCRight;
               while (cenaLCRight>afrx[mChannels[i]] && n<peakLeft) {n++; cenaLCRight=wrcenaR-tangens*(n-peakRight);}
               timeLCRight=Time[n-1]; cenaLCRight=wrcenaR-tangens*(n-1-peakRight);
              }
            else
              {
               m=peakLeft;
               wrcenaL=cenaLCLeft;
               while (cenaLCLeft<=afrx[mChannels[i-1]] && m<=Bars) {m++; cenaLCLeft=wrcenaL-tangens*(m-peakLeft);}
               timeLCLeft=Time[m];

               n=peakRight;
               wrcenaR=cenaLCRight;
               while (cenaLCRight<=afrx[mChannels[i]] && n<=peakLeft) {n++; cenaLCRight=wrcenaR-tangens*(n-peakRight);}
               timeLCRight=Time[n-1]; cenaLCRight=wrcenaR-tangens*(n-1-peakRight);
              }
            }

         ObjectCreate(nameObj,OBJ_TREND,0,timeLCLeft,cenaLCLeft,timeLCRight,cenaLCRight);
         if (ExtTypeLineChannels<2) ObjectSet(nameObj,OBJPROP_RAY,false);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtLCColor);
         ObjectSet(nameObj,OBJPROP_STYLE,ExtLCChannelsStyle);
         ObjectSet(nameObj,OBJPROP_WIDTH,ExtLCChannelsWidth);

         if (dinamic) break;
        }
     }
   // Каналы, параллельные лучу зигзага. Конец.

   ExtChannelsNum=0;
  }
//--------------------------------------------------------
// Каналы. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод Pivot ZigZag. Начало.
//--------------------------------------------------------
void PivotZZ(int PivotZZColor, int PivotZZNum, int LinePivotZZ)
  {
   int peak1, peak2, shift;
   double tangens, cena, val;
   peak1=iBarShift(Symbol(),Period(),afr[PivotZZNum-1]);
   peak2=iBarShift(Symbol(),Period(),afr[PivotZZNum]);

   nameObj="LinePivotZZ" + LinePivotZZ + ExtComplekt+"_";
   if (ExtSave)
     {
      nameObj=nameObj + save;
     }
   ObjectDelete(nameObj);
   if (peak1>1)
     {
      cena=(zz[peak2]+zz[peak1]+Close[peak1-1])/3;

      tangens=(zz[peak2]-zz[peak1])/(peak2-peak1);
      val=zz[peak1];
      for (shift=peak1; shift<peak2; shift++)
        {
         val=val+tangens;
         if (zz[peak2]>zz[peak1])
           {
            if (val>cena) break;
           }
         else
           {
            if (val<cena) break;
           }
        }

      ObjectCreate(nameObj,OBJ_TREND,0,Time[shift+1],cena,Time[0]+5*Period()*60,cena);
      ObjectSet(nameObj,OBJPROP_COLOR,PivotZZColor);
      ObjectSet(nameObj,OBJPROP_STYLE,ExtPivotZZStyle);
      ObjectSet(nameObj,OBJPROP_WIDTH,ExtPivotZZWidth);
     }
  }
//--------------------------------------------------------
// Вывод Pivot ZigZag. Конецо.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод Versum Levels статических. Начало.
//--------------------------------------------------------
void VLS()
  {
   VL(mVL[0],mVL[1],mVL[2],ExtVLStaticColor,"VLS");
  }
//--------------------------------------------------------
// Вывод Versum Levels статических. Конецо.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод Versum Levels динамических. Начало.
//--------------------------------------------------------
void VLD()
  {
   VL(2,1,0,ExtVLDinamicColor,"VLD");
  }
//--------------------------------------------------------
// Вывод Versum Levels динамических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Versum Levels. Начало.
//--------------------------------------------------------
void VL(int na,int nb,int nc,color color_line,string vl)
  {
   double line_pesavento[7]={0.236, 0.382, 0.447, 0.5, 0.618, 0.786, 0.886}, line_fibo[7]={0.236, 0.382, 0.455, 0.5, 0.545, 0.618, 0.764};
   int c_bar1, c_bar2, i;
   double H_L, mediana, tangens, cena;

   c_bar1=iBarShift(Symbol(),Period(),afr[na])-iBarShift(Symbol(),Period(),afr[nb]); // количество бар в отрезке AB
   c_bar2=iBarShift(Symbol(),Period(),afr[nb])-iBarShift(Symbol(),Period(),afr[nc]); // количество бар в отрезке ВС
   if (afrl[na]>0)
    {
     H_L=afrh[nb]-afrl[nc]; // высота отрезка ВС

     for (i=0; i<7; i++)
       {
        if (ExtFiboType==1)
          {
           mediana=line_pesavento[i]*H_L+afrl[nc];
           tangens=(mediana-afrl[na])/(c_bar1+(1-line_pesavento[i])*c_bar2);
           cena=c_bar2*line_pesavento[i]*tangens+mediana;
           nameObj=vl+i+" " + ExtComplekt+"_";
           ObjectDelete(nameObj);
           ObjectCreate(nameObj,OBJ_TREND,0,afr[na],afrl[na],afr[nc],cena);
           ObjectSetText(nameObj,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" "+vl+" "+DoubleToStr(line_pesavento[i]*100,1)+"");
          }
        else
          {
           mediana=line_fibo[i]*H_L+afrl[nc];
           tangens=(mediana-afrl[na])/(c_bar1+(1-line_fibo[i])*c_bar2);
           cena=c_bar2*line_fibo[i]*tangens+mediana;
           nameObj=vl+i+" " + ExtComplekt+"_";
           ObjectDelete(nameObj);
           ObjectCreate(nameObj,OBJ_TREND,0,afr[na],afrl[na],afr[nc],cena);
           ObjectSetText(nameObj,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" "+vl+" "+DoubleToStr(line_fibo[i]*100,1)+"");
          }
        ObjectSet(nameObj,OBJPROP_COLOR,color_line);
        ObjectSet(nameObj,OBJPROP_STYLE,ExtVLStyle);
        ObjectSet(nameObj,OBJPROP_WIDTH,ExtVLWidth);
       }
    }
   else
    {
     H_L=afrh[nc]-afrl[nb]; // высота отрезка ВС

     for (i=0; i<7; i++)
       {
        if (ExtFiboType==1)
          {
           mediana=afrh[nc]-line_pesavento[i]*H_L;
           tangens=(afrh[na]-mediana)/(c_bar1+(1-line_pesavento[i])*c_bar2);
           cena=mediana-c_bar2*line_pesavento[i]*tangens;
           nameObj=vl+i+" " + ExtComplekt+"_";
           ObjectDelete(nameObj);
           ObjectCreate(nameObj,OBJ_TREND,0,afr[na],afrh[na],afr[nc],cena);
           ObjectSetText(nameObj,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" "+vl+" "+DoubleToStr(line_pesavento[i]*100,1)+"");
          }
        else
          {
           mediana=afrh[nc]-line_fibo[i]*H_L;
           tangens=(afrh[na]-mediana)/(c_bar1+(1-line_fibo[i])*c_bar2);
           cena=mediana-c_bar2*line_fibo[i]*tangens;
           nameObj=vl+i+" " + ExtComplekt+"_";
           ObjectDelete(nameObj);
           ObjectCreate(nameObj,OBJ_TREND,0,afr[na],afrh[na],afr[nc],cena);
           ObjectSetText(nameObj,"ZUP"+ExtComplekt+" zz"+ExtIndicator+" "+vl+" "+DoubleToStr(line_fibo[i]*100,1)+"");
          }
        ObjectSet(nameObj,OBJPROP_COLOR,color_line);
        ObjectSet(nameObj,OBJPROP_STYLE,ExtVLStyle);
        ObjectSet(nameObj,OBJPROP_WIDTH,ExtVLWidth);
       }
    }
  }
//--------------------------------------------------------
// Versum Levels. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод вил Эндрюса статических. Начало.
//--------------------------------------------------------
void screenPitchforkS()
  {
   int i, i_APm=0, count_APm=0;
   double a1,b1,c1,ab1,bc1,ab2,bc2,tangens,n1,cl1,ch1,cena,wr,wr1,wr2;
   datetime ta1,tb1,tc1,tab2,tbc2,tcl1,tch1,twr1,twr2;
   int    a0,b0,c0;
   int    pitch_time[]={0,0,0}; 
   double pitch_cena[]={0,0,0};
   double TLine, m618=phi-1, m382=2-phi;
   bool   moveAP=false;
   string txt="";

   if (ExtCustomStaticAP)
     {
      if (ObjectFind(nameCheckLabel)==0)
        {
         // Проверка положения сигнальной метки APm
         if (ObjectGet(nameCheckLabel,OBJPROP_XDISTANCE)!=vX || ObjectGet(nameCheckLabel,OBJPROP_YDISTANCE)!=vY)
           {
            if (ObjectFind(nameCheckLabel_hidden)==0)
              {
               i_APm=StrToInteger(StringSubstr(ObjectDescription(nameCheckLabel_hidden),0,1));
               count_APm=StrToInteger(StringSubstr(ObjectDescription(nameCheckLabel_hidden),2));
               count_APm--;

               if (count_APm<1) txt=""+i_APm+"_"+i_APm; else txt=""+i_APm+"_"+count_APm;
               ObjectSetText(nameCheckLabel_hidden,txt);
              }

            if (count_APm<1)
              {
               ObjectDelete(nameCheckLabel);
               ObjectCreate(nameCheckLabel,OBJ_LABEL,0,0,0);

               ObjectSetText(nameCheckLabel,"APm");
               ObjectSet(nameCheckLabel, OBJPROP_FONTSIZE, 10);
               ObjectSet(nameCheckLabel, OBJPROP_COLOR, Red);

               ObjectSet(nameCheckLabel, OBJPROP_CORNER, 1);
               ObjectSet(nameCheckLabel, OBJPROP_XDISTANCE, vX);
               ObjectSet(nameCheckLabel, OBJPROP_YDISTANCE, vY);
              }

           if (ObjectFind("pitchforkS" + ExtComplekt+"_")==0) {moveAP=true; nameObj="pitchforkS" + ExtComplekt+"_";}
           if (ObjectFind("pitchforkS" + ExtComplekt+"_APm_")==0) {moveAP=true; nameObj="pitchforkS" + ExtComplekt+"_APm_";}
          }
        else
          {
           if (ObjectFind("pitchforkS" + ExtComplekt+"_APm_")==0) return;
          }
        }
      else
        {
//         if (ObjectFind("pitchforkS" + ExtComplekt+"_")==0 || ObjectFind("pitchforkS" + ExtComplekt+"_APm_")==0) // несколько комплектов ZUP???
           {
         ObjectCreate(nameCheckLabel,OBJ_LABEL,0,0,0);

         ObjectSetText(nameCheckLabel,"APm");
         ObjectSet(nameCheckLabel, OBJPROP_FONTSIZE, 10);
         ObjectSet(nameCheckLabel, OBJPROP_COLOR, Red);

         ObjectSet(nameCheckLabel, OBJPROP_CORNER, 1);
         ObjectSet(nameCheckLabel, OBJPROP_XDISTANCE, vX);
         ObjectSet(nameCheckLabel, OBJPROP_YDISTANCE, vY);
           }
        }
     }

   if (moveAP)
     {
      mPitchCena[0]=ObjectGet(nameObj,OBJPROP_PRICE1);
      mPitchCena[1]=ObjectGet(nameObj,OBJPROP_PRICE2);
      mPitchCena[2]=ObjectGet(nameObj,OBJPROP_PRICE3);
      mPitchTime[0]=ObjectGet(nameObj,OBJPROP_TIME1);
      mPitchTime[1]=ObjectGet(nameObj,OBJPROP_TIME2);
      mPitchTime[2]=ObjectGet(nameObj,OBJPROP_TIME3);
     }
   else
     {
      if (ExtPitchforkCandle)
        {
         if (iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)==0)
           {
            if (ExtPitchfork_1_HighLow)
              {
               mPitchCena[2]=High[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)];
              }
            else
              {
               mPitchCena[2]=Low[iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)];
              }
           }
        }

      if (ExtPitchforkCandle)
        {
         cena=mPitchCena[0];
         if (ExtPitchfork_1_HighLow)
           {
            if (ExtCM_0_1A_2B_Static==1)
              {
               cena=mPitchCena[0]-(mPitchCena[0]-mPitchCena[1])*ExtCM_FiboStatic;
              }
            else if (ExtCM_0_1A_2B_Static==4)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza4(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static==5)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza5(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static>1)
              {
               if (ExtCM_0_1A_2B_Static==2) mPitchTime[0]=mPitchTime[1];
               cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*ExtCM_FiboStatic;
              }
           }
         else
           {
            if (ExtCM_0_1A_2B_Static==1)
              {
               cena=mPitchCena[0]+(mPitchCena[1]-mPitchCena[0])*ExtCM_FiboStatic;
              }
            else if (ExtCM_0_1A_2B_Static==4)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza4(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static==5)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza5(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static>1)
              {
               if (ExtCM_0_1A_2B_Static==2) mPitchTime[0]=mPitchTime[1];
               cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*ExtCM_FiboStatic;
              }
           }
        }
      else
        {
         mPitchTime[0]=afr[mPitch[0]]; mPitchTime[1]=afr[mPitch[1]]; mPitchTime[2]=afr[mPitch[2]];

         if (afrl[mPitch[0]]>0)
           {
            cena=afrl[mPitch[0]]; 
            mPitchCena[1]=afrh[mPitch[1]]; mPitchCena[2]=afrl[mPitch[2]];
            if (ExtCM_0_1A_2B_Static==1)
              {
               cena=mPitchCena[0]+(mPitchCena[1]-mPitchCena[0])*ExtCM_FiboStatic;
              }
            else if (ExtCM_0_1A_2B_Static==4)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza4(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static==5)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza5(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static>1)
              {
               if (ExtCM_0_1A_2B_Static==2) mPitchTime[0]=mPitchTime[1];
               cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*ExtCM_FiboStatic;
              }
           }
         else
           {
            cena=afrh[mPitch[0]];
            mPitchCena[1]=afrl[mPitch[1]]; mPitchCena[2]=afrh[mPitch[2]];
            if (ExtCM_0_1A_2B_Static==1)
              {
               cena=mPitchCena[0]-(mPitchCena[0]-mPitchCena[1])*ExtCM_FiboStatic;
              }
            else if (ExtCM_0_1A_2B_Static==4)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza4(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static==5)
              {
               mPitchTimeSave=mPitchTime[0];
               mPitchTime[0]=mPitchTime[1];
               if (maxGipotenuza5(mPitchTime,mPitchCena))
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m618;
                 }
               else
                 {
                  cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m382;
                 }
              }
            else if (ExtCM_0_1A_2B_Static>1)
              {
               if (ExtCM_0_1A_2B_Static==2) mPitchTime[0]=mPitchTime[1];
               cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*ExtCM_FiboStatic;
              }
           }
        }

      mPitchCena[0]=cena;
     }

   if (ExtFiboFanStatic) {ExtFiboFanStatic=false; screenFiboFanS();}

   coordinaty_1_2_mediany_AP(mPitchCena[0], mPitchCena[1], mPitchCena[2], mPitchTime[0], mPitchTime[1], mPitchTime[2], tab2, tbc2, ab1, bc1, ExtPitchforkStatic, ExtPitchforkStaticCustom);

   pitch_time[0]=tab2;pitch_cena[0]=ab1;

   // 50% медиана 
   if (ExtPitchforkStatic==2)
     {
      nameObj="pmedianaS" + ExtComplekt+"_";

      if (ExtSave)
        {
         if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (mPitch[2]>0)
              {
               nameObj=nameObj + save;
              }
           }
        }
  
      ObjectDelete(nameObj);
      ObjectCreate(nameObj,OBJ_TREND,0,tab2,ab1,tbc2,bc1);
      ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
      ObjectSet(nameObj,OBJPROP_COLOR,ExtLinePitchforkS);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

      if (ExtSLMStatic)
        {
         b0=iBarShift(Symbol(),Period(),mPitchTime[1]);
         c0=iBarShift(Symbol(),Period(),mPitchTime[2]);

         // смещение slm
         wr=(ObjectGetValueByShift(nameObj,c0)-mPitchCena[2])*(1-2*m382);

         //номер бара точки 1
         a0=c0-(c0-b0)*m382-1;
         // время точки 1
         twr1=iTime(Symbol(),Period(),a0);
         // цена точки 1
         wr1=ObjectGetValueByShift(nameObj,a0)-wr;
         // координаты точки 2
         wr2=ObjectGetValueByShift(nameObj,0)-wr;
         twr2=iTime(Symbol(),Period(),0);

         nameObj="SLM382S" + ExtComplekt+"_";
         if (ExtSave)
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
           }
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_TREND,0,twr1,wr1,twr2,wr2);
         ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtSLMStaticColor);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

         //номер бара точки 1
         a0=c0-(c0-b0)*m618-1;
         // время точки 1
         twr1=iTime(Symbol(),Period(),a0);
         // цена точки 1
         nameObj="pmedianaS" + ExtComplekt+"_";
         wr1=ObjectGetValueByShift(nameObj,a0)+wr;
         // координаты точки 2
         wr2=ObjectGetValueByShift(nameObj,0)+wr;
         twr2=iTime(Symbol(),Period(),0);

         nameObj="SLM618S" + ExtComplekt+"_";
         if (ExtSave)
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
           }
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_TREND,0,twr1,wr1,twr2,wr2);
         ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtSLMStaticColor);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
        }

      if (ExtFSLShiffLinesStatic)
        {
         c0=iBarShift(Symbol(),Period(),mPitchTime[1]);

         // время точки 1
         twr1=mPitchTime[1];
         // цена точки 1
         wr1=mPitchCena[1];
         // координаты точки 2
         nameObj="pmedianaS" + ExtComplekt+"_";
         wr2=ObjectGetValueByShift(nameObj,0)-ObjectGetValueByShift(nameObj,c0)+mPitchCena[1];
         twr2=iTime(Symbol(),Period(),0);

         nameObj="FSL Shiff Lines S" + ExtComplekt+"_";
         if (ExtSave)
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
           }
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_TREND,0,twr1,wr1,twr2,wr2);
         ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtFSLShiffLinesStaticColor);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
        }

      nameObj="1-2pmedianaS" + ExtComplekt+"_";

      if (ExtSave)
        {
         if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (mPitch[2]>0)
              {
               nameObj=nameObj + save;
              }
           }
        }
      ObjectDelete(nameObj);
      ObjectCreate(nameObj,OBJ_TEXT,0,tab2,ab1+3*Point);
      ObjectSetText(nameObj,"     1/2 ML",9,"Arial", ExtLinePitchforkS);
     }   

   if (ExtCustomStaticAP) nameObj="pitchforkS" + ExtComplekt+"_APm_"; else nameObj="pitchforkS" + ExtComplekt+"_";
   if (ExtSave)
     {
      if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
        {
         nameObj=nameObj + save;
        }
      else
        {
         if (mPitch[2]>0)
           {
            nameObj=nameObj + save;
           }
        }
     }

   if (ExtPitchforkStatic!=4)
     {
      pitch_time[0]=mPitchTime[0];pitch_cena[0]=mPitchCena[0];
      if (ExtPitchforkStatic==3) pitch_cena[0]=ab1;
     }
   pitch_time[1]=mPitchTime[1];pitch_cena[1]=mPitchCena[1];
   pitch_time[2]=mPitchTime[2];pitch_cena[2]=mPitchCena[2];

   // Вывод меток в вилах Эндрюса
   mAPs=false;
   if (ObjectFind(nameObj)>=0)
     {
      if (mAP)
        {
         if (ObjectGet(nameObj,OBJPROP_TIME1)!=pitch_time[0] || ObjectGet(nameObj,OBJPROP_PRICE1)!=pitch_cena[0] ||
             ObjectGet(nameObj,OBJPROP_TIME2)!=pitch_time[1] || ObjectGet(nameObj,OBJPROP_PRICE2)!=pitch_cena[1] ||
             ObjectGet(nameObj,OBJPROP_TIME3)!=pitch_time[2] || ObjectGet(nameObj,OBJPROP_PRICE3)!=pitch_cena[2] ||
              ExtCustomStaticAP)   {mAPs=true; RZs=-1;}
        } 

      ObjectDelete(nameObj);
     }
   else if (mAP) {mAPs=true; RZs=-1;}
   delete_objects6();
     
   ObjectCreate(nameObj,OBJ_PITCHFORK,0,pitch_time[0],pitch_cena[0],pitch_time[1],pitch_cena[1],pitch_time[2],pitch_cena[2]);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtPitchforkStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtPitchforkWidth);
   ObjectSet(nameObj,OBJPROP_COLOR,ExtLinePitchforkS);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   if (ExtMasterPitchfork==2)
     {
      nameObjAPMaster="Master_"+nameObj;
      ObjectDelete(nameObjAPMaster);
      ObjectCreate(nameObjAPMaster,OBJ_PITCHFORK,0,pitch_time[0],pitch_cena[0],pitch_time[1],pitch_cena[1],pitch_time[2],pitch_cena[2]);
      ObjectSet(nameObjAPMaster,OBJPROP_STYLE,ExtPitchforkStyle);
      ObjectSet(nameObjAPMaster,OBJPROP_WIDTH,ExtPitchforkWidth);
      ObjectSet(nameObjAPMaster,OBJPROP_COLOR,CLR_NONE);
      ObjectSet(nameObjAPMaster,OBJPROP_BACK,true);
     }

   if (ExtFiboFanMedianaStaticColor>0)
     {
      coordinaty_mediany_AP(pitch_cena[0], pitch_cena[1], pitch_cena[2], pitch_time[0], pitch_time[1], pitch_time[2], tb1, b1);      

      nameObj="FanMedianaStatic" + ExtComplekt+"_";
/*
      if (ExtSave)
        {
         if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (mPitch[2]>0)
              {
               nameObj=nameObj + save;
              }
           }
        }
*/
      ObjectDelete(nameObj);

      ObjectSet(nameObj,OBJPROP_COLOR,CLR_NONE);
      ObjectCreate(nameObj,OBJ_FIBOFAN,0,pitch_time[0],pitch_cena[0],tb1,b1);
      ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DASH);
      ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboFanMedianaStaticColor);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

      if (ExtFiboType==0)
        {
         screenFibo_st();
        }
      else if (ExtFiboType==1)
        {
         screenFibo_Pesavento();
        }
      else if (ExtFiboType==2)
        {
         ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi);
         for (i=0;i<Sizefi;i++)
           {
            ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi[i]);
            ObjectSetFiboDescription(nameObj, i, fitxt100[i]); 
           }
        }
     }
//-------------------------------------------------------

   if (ExtUTL)
     {
      nameObj="UTL" + ExtComplekt+"_";
      if (ExtSave)
        {
         if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (mPitch[2]>0)
              {
               nameObj=nameObj + save;
              }
           }
        }

      ObjectDelete(nameObj);
      if (pitch_cena[1]>pitch_cena[2])
        {
         ObjectCreate(nameObj,OBJ_TREND,0,pitch_time[0],pitch_cena[0],pitch_time[1],pitch_cena[1]);
        }
      else
        {
         ObjectCreate(nameObj,OBJ_TREND,0,pitch_time[0],pitch_cena[0],pitch_time[2],pitch_cena[2]);
        }
      ObjectSet(nameObj,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSet(nameObj,OBJPROP_COLOR,ExtLinePitchforkS);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
     }

   if (ExtPivotZoneStaticColor>0 && ExtPitchforkStatic<4) PivotZone(pitch_time, pitch_cena, ExtPivotZoneStaticColor, "PivotZoneS");

   if (ExtLTL)
     {
      nameObj="LTL" + ExtComplekt+"_";
      if (ExtSave)
        {
         if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (mPitch[2]>0)
              {
               nameObj=nameObj + save;
              }
           }
        }

      ObjectDelete(nameObj);
      if (pitch_cena[1]>pitch_cena[2])
        {
         ObjectCreate(nameObj,OBJ_TREND,0,pitch_time[0],pitch_cena[0],pitch_time[2],pitch_cena[2]);
        }
      else
        {
         ObjectCreate(nameObj,OBJ_TREND,0,pitch_time[0],pitch_cena[0],pitch_time[1],pitch_cena[1]);
        }
      ObjectSet(nameObj,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSet(nameObj,OBJPROP_COLOR,ExtLinePitchforkS);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
     }
//-------------------------------------------------------

   if (ExtUWL || ExtLWL)
     {
      n1=iBarShift(Symbol(),Period(),pitch_time[0])-(iBarShift(Symbol(),Period(),pitch_time[1])+iBarShift(Symbol(),Period(),pitch_time[2]))/2.0;
      ta1=pitch_time[0];
      tb1=Time[0];
      a1=pitch_cena[0];
      tangens=(pitch_cena[0]-(pitch_cena[1]+pitch_cena[2])/2.0)/n1;
      b1=pitch_cena[0]-tangens*iBarShift(Symbol(),Period(),pitch_time[0]);

      ML_RL400(tangens, pitch_cena, pitch_time, tb1, b1, false);

      if (pitch_cena[1]>pitch_cena[2])
        {
         if (ExtUWL)
           {
            ch1=pitch_cena[1];
            tch1=pitch_time[1];
           }
         if (ExtLWL)
           {
            cl1=pitch_cena[2];
            tcl1=pitch_time[2];
           }
        }
      else
        {
         if (ExtUWL)
           {
            ch1=pitch_cena[2];
            tch1=pitch_time[2];
           }
         if (ExtLWL)
           {
            cl1=pitch_cena[1];
            tcl1=pitch_time[1];
           }
        }

      if (ExtUWL)
        {
         nameObj="UWL" + ExtComplekt+"_";
         if (ExtSave)
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
           }
  
         ObjectDelete(nameObj);

         ObjectCreate(nameObj,OBJ_FIBOCHANNEL,0,ta1,a1,tb1,b1,tch1,ch1);
         ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtLinePitchforkS);
         ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DOT);
         ObjectSet(nameObj,OBJPROP_RAY,ExtLongWL);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
         ObjectSet(nameObj,OBJPROP_COLOR,CLR_NONE);

         UWL_LWL (ExtVisibleUWL,nameObj,"UWL ",ExtFiboFreeUWL);
        }

      if (ExtLWL)
        {
         nameObj="LWL" + ExtComplekt+"_";
         if (ExtSave)
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
           }

         ObjectDelete(nameObj);

         ObjectCreate(nameObj,OBJ_FIBOCHANNEL,0,ta1,a1,tb1,b1,tcl1,cl1);
         ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtLinePitchforkS);
         ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DOT);
         ObjectSet(nameObj,OBJPROP_RAY,ExtLongWL);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
         ObjectSet(nameObj,OBJPROP_COLOR,CLR_NONE);

         UWL_LWL (ExtVisibleLWL,nameObj,"LWL ",ExtFiboFreeLWL);
        }

     }

//-------------------------------------------------------

   if (ExtPitchforkStaticColor>0)
     {

      n1=iBarShift(Symbol(),Period(),pitch_time[0])-(iBarShift(Symbol(),Period(),pitch_time[1])+iBarShift(Symbol(),Period(),pitch_time[2]))/2.0;
   
      TLine=pitch_cena[1]-iBarShift(Symbol(),Period(),pitch_time[1])*(pitch_cena[0]-(pitch_cena[2]+pitch_cena[1])/2)/n1;

      nameObj="CL" + ExtComplekt+"_";
/*
      if (ExtSave)
        {
         if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (mPitch[2]>0)
              {
               nameObj=nameObj + save;
              }
           }
        }
*/
      ObjectDelete(nameObj);

      ObjectCreate(nameObj,OBJ_CHANNEL,0,pitch_time[1],pitch_cena[1],Time[0],TLine,pitch_time[2],pitch_cena[2]);
      ObjectSet(nameObj, OBJPROP_BACK, true);
      ObjectSet(nameObj, OBJPROP_COLOR, ExtPitchforkStaticColor); 
     }
//-------------------------------------------------------
   if (ExtISLChannelStaticColor>0)
     {
      channelISL(pitch_cena[0], pitch_cena[1], pitch_cena[2], pitch_time[0], pitch_time[1], pitch_time[2], 0);
     }
//-------------------------------------------------------

   if (ExtISLStatic)
     {
      _ISL("ISL_S", pitch_time, pitch_cena, ExtLinePitchforkS, ExtISLStyleStatic, 0, "");
     }

//-------------------------------------------------------

   if (ExtRLStatic)
     {
      _RL("RLineS", pitch_time, pitch_cena, ExtLinePitchforkS, ExtRLStyleStatic, ExtVisibleRLStatic, 0);
     }
//-------------------------------------------------------

   if (ExtRedZoneStatic)
     {
      _RZ("RZS", ExtRZStaticValue, ExtRZStaticColor, pitch_time, pitch_cena);
     }
//--------------------------------------------------------
   // Временные зоны Фибо в составе статических вил Эндрюса
   fiboTimeX ();

   if (ExtCustomStaticAP)
     {
      if (mAPs || mAPd) metkaAP(true);  // Создание меток в вилах Эндрюса

      i_APm=0;
      for (i=ObjectsTotal()-1; i>=0; i--)
       {
         txt=ObjectName(i);
         // подсчет колическтва вил с меткой APm
         if (ObjectType(txt)==OBJ_PITCHFORK)
           {
            if (StringFind(txt,"_APm",0)>0) i_APm++;
           }
        }

      ObjectDelete(nameCheckLabel_hidden);
      if (i_APm>1)
        {
         count_APm=StrToInteger(StringSubstr(ObjectDescription(nameCheckLabel_hidden),2));
         if (count_APm<1) txt=""+i_APm+"_"+i_APm; else txt=""+i_APm+"_"+count_APm;

         ObjectCreate(nameCheckLabel_hidden,OBJ_TEXT,0,0,0);

         ObjectSetText(nameCheckLabel_hidden,txt);
         ObjectSet(nameCheckLabel_hidden, OBJPROP_COLOR, CLR_NONE);
         ObjectSet(nameCheckLabel_hidden, OBJPROP_BACK, true);
        }
    }
  }
//--------------------------------------------------------
// Вывод вил Эндрюса статических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод ценовых меток (metkaAP) в вилах Эндрюса. Начало.
//--------------------------------------------------------
/*
//========================================================
Вывод информации в файл
extern int    mPeriodWriteToFile       = 240;
extern bool   mWriteToFile             = true;

Стандарт вывода информации: 

Название файла eurusd_1440_0.csv - в файле содержится информация, полученная с таймфрейма 1440 минут (D1) для индикатора ExtComplekt=0

Внутри файла информация представлена в виде:
 
Режим вывода потенциальных целевых зон; Название метки; режим вывода метки; цена левой метки; цена метки на нулевом баре; цена правой метки; значание цены закрытия нулевого бара в момент снятия информацции; наименование вил (статические или динамические); цена первой точки привязки вил; цена второй точки привязки вил; цена третьей точки привязки вил;


Название метки:
1 - mSSL;
2 – mSLM382;
3 - m1_2Mediana;
4 – mSLM618;
5 - mISL382;
6 - mMediana;
7 - mISL618;
8 - mFSL;
9 - mFSLShiffLines;
10 - mCriticalPoints - это значение помещается в позиции: цена левой метки; и цена правой метки; 
11 - mUTL
12 - mLTL
13 – mUWL
14 - mLWL

Номера таймфреймов - для записи в название файла:
m1 - 1
m5 - 5
m15 - 15
m30 - 30
h1 - 60
h4 - 240
d1 - 1440
w1 - 10080
mn - 43200
и так далее.

наименование вил (статические или динамические):
статические - 0
динамические - 1 
//========================================================
Определение типа выводимых меток

mSelectVariantsPRZ
 = 0 - выводятся Метки "внутри" текущих (одиночных) вил
 > 0 - выводятся Метки при пересечении текущих (базовых) вил с внешними вилами
 = 1 - метки пересечения SSL
 = 2 - метки пересечения медианы
 = 3 - метки пересечения FSL
 = 4 - зона пересечения канала медианы
 = 5 - зона пересечения канала вил 
 = 6 - метки пересечения 1/2 медианы
 = 7 - зона пересечения канала 1/2 медианы
 = 8 - зона пересечения канала линий Шиффа
 = 9 - метки пересечения UTL

mTypeBasiclAP - выбор типа базовых вил
 = 0 - статические вилы из текущего комплекта
 = 1 - динамические вилы из текущего комплекта

mTypeExternalAP - выбор типа внешних вил 
 = 0 - динамические или статические вилы текущего комплекта (противоположные базовым)
 = 1 - сохраненные вилы из текущего комплекта
 = 2 - любые вилы из текущего комплекта
 = 3 - статические вилы из других комплектов ZUP с текущего графика
 = 4 - динамические вилы из других комплектов ZUP с текущего графика
 = 5 - любые вилы из других комплектов ZUP с текущего графика
 = 6 - вилы с текущего графика, выведенные вручную, не с помощью ZUP
 = 7 - любые внешние вилы

mExternalHandAP - задание прорисовки инструментов вил, выведенных вручную, при задании вывода меток при пересечении с данными вилами
 = 0 - вывод меток только при пересечении с медианой и SSL/FSL данных вил
 = 1 - прорисовка линий инструментов вил, с которыми задается вывод меток
 = 2 - вывод только меток без прорисовки самих инструментов внешних вил

Система наименований меток

Метки "внутри" текущих (одиночных) вил

prefics="m#"+ExtComplekt+"_"+"s ";
prefics="m#"+ExtComplekt+"_"+"d ";


метки у точек привязки вил Эндрюса
"point 1 AP" 
"point 2 AP" 
"point 3 AP"

метки при пересечении 50%-й медианы с ISL 38.2 и начальной сигнальной линией
"50% Mediana x SSL"
"50% Mediana x ISL 38.2"

метки при пересечении нулевого бара 50%-й медианой вил Эндрюса
"50% Mediana x 0-bar"
"50% Mediana left 0-bar" 
"50% Mediana right 0-bar"

метки на SLM382
"SLM 38.2 x 0-bar"
"SLM 38.2 left 0-bar"
"SLM 38.2 right 0-bar"
"Shift SLM 38.2 Zones"
"SLM 38.2 Zones"

метки на SLM618
"SLM 61.8 x 0-bar"
"SLM 61.8 left 0-bar"
"SLM 61.8 right 0-bar"
"Shift SLM 61.8 Zones"
"SLM 61.8 Zones"

метки при пересечении нулевого бара линией SSL
"SSL x 0-bar"
"SSL left 0-bar"
"SSL right 0-bar"
"Shift SSL Zones"
"SSL Zones"

метки при пересечении нулевого бара линией FSL
"FSL x 0-bar"
"FSL left 0-bar"
"FSL right 0-bar"
"Shift FSL Zones"
"FSL Zones"

метки при пересечении нулевого бара медианой вил Эндрюса
"Mediana x 0-bar"
"Mediana left 0-bar"
"Mediana right 0-bar"
"Shift Mediana Zones"
"Mediana Zones"

метки при пересечении нулевого бара линией ISL 38.2
"ISL 38.2 x 0-bar"
"ISL 38.2 left 0-bar"
"ISL 38.2 right 0-bar"
"Shift ISL 38.2 Zones"
"ISL 38.2 Zones"

метки при пересечении нулевого бара линией ISL 61.8
"ISL 61.8 x 0-bar"
"ISL 61.8 left 0-bar"
"ISL 61.8 right 0-bar"
"Shift ISL 61.8 Zones"
"ISL 61.8 Zones"

метки при пересечении нулевого бара предупреждающими линиями LWL и/или UWL статичеких вил Эндрюса
ObjectGetFiboDescription(nameObj,k), где nameObj="LWL" + ExtComplekt+"_";
ObjectGetFiboDescription(nameObj,k)+" left 0-bar"
ObjectGetFiboDescription(nameObj,k)+" right 0-bar"
ObjectGetFiboDescription(nameObj,k)+" Shift Zones"
ObjectGetFiboDescription(nameObj,k)+" Zones"

ObjectGetFiboDescription(nameObj,k), где nameObj="UWL" + ExtComplekt+"_";
ObjectGetFiboDescription(nameObj,k)+" left 0-bar"
ObjectGetFiboDescription(nameObj,k)+" right 0-bar"
ObjectGetFiboDescription(nameObj,k)+" Shift Zones"
ObjectGetFiboDescription(nameObj,k)+" Zones"

метки при пересечении нулевого бара контрольными линиями LTL и/или UTL статичеких вил Эндрюса
"LTL x 0-bar"
"LTL left 0-bar" 
"LTL right 0-bar" 
"Shift LTL Zones"
"LTL Zones"

"UTL x 0-bar"
"UTL left 0-bar"
"UTL right 0-bar"
"Shift UTL Zones"
"UTL Zones"

Метки между текущими вилами и другими вилами, присутствующими на графике

в префикс добавляется 
+"_"+"s ""+ExtComplekt - для статических внешних вил
+"_"+"d ""+ExtComplekt - для динамических внешних вил
+"_"+"s ""+ExtComplekt - для сохраненных внешних вил  -  + save


prefics="m#"+ExtComplekt+"_"+"s";
prefics="m#"+ExtComplekt+"_"+"d";

*/
void metkaAP(bool create)
  {
   int    pitch_time[]={0,0,0}; 
   double pitch_cena[]={0,0,0};
   int i,j,j1,k,m,n, a1,b1,c1,m12, x, symb;
   string prefics, str05median, strSLM382, strSLM618, nameFibo;
   string arrName[];    // массив для хранения наименований вил Эндрюса
   double tangensAP=0, tangensRL=0, tangens05median=0, wr, tangensUTL, tangensLTL, tangensUWL, tangensLWL, arrRL[], tangens;
   color  mclr;
   double cena1, cena2, cenaRL, X, Y, Z, W, cenaUWL, cenaLWL, h=0, delta, rl1, rl2, hAP, bazaAP, ret, retISL, xISL=0, xret=0; // m382=2-phi, m618=phi-1;
   double hAP1_2mediana;
   datetime time1, time2;
   bool   updn;
   // переменные для формирования файла CSV
   string file="\\Price Label\\";
   string tmp="", str1, str2, str3;
   int handle=-1, st_din;
   bool writetofile=false;
//  mSelectVariantsPRZ ExtMasterPitchfork SlavePitchfork

   if (create)
     {
      // открываем файл для записи меток
      if (mWriteToFile)
        {
         if (mPeriod<TimeCurrent())
           {
            tmp="_";
            if (ExtMasterPitchfork>0)
              {
               tmp="_0_";
              }
            else
              {
               if (SlavePitchfork) tmp="_"+StringSubstr(""+ExtComplekt,StringLen(""+ExtComplekt)-1)+"_";
               else
                 {
                  j=ObjectsTotal();
                  for (n=0; n<j; n++)
                    {
                     if (ObjectType(ObjectName(n))==OBJ_PITCHFORK)
                       {
                        if (StringFind(ObjectName(n),"Master_",0)>=0)
                         {
                          SlavePitchfork = true;
                          tmp="_"+StringSubstr(""+ExtComplekt,StringLen(""+ExtComplekt)-1)+"_";
                          break;
                         }
                       }
                    }
                 }
              }

            writetofile=true;
            if (ExtIndicator==6 && GrossPeriod==Period()) file=file+Symbol()+"_"+GrossPeriod+tmp+ExtComplekt+".csv";
            else file=file+Symbol()+"_"+Period()+tmp+ExtComplekt+".csv";
            handle=FileOpen(file,FILE_CSV|FILE_WRITE,';');
           }
        }
     }

   if (mSelectVariantsPRZ==0)
     {
      if (create)
        {
         for (i=0;i<2;i++)
           {
            nameObj="";
            if (i==0 && mAPs)
              {
               if (ExtCustomStaticAP) nameObj="pitchforkS" + ExtComplekt+"_APm_"; else nameObj="pitchforkS" + ExtComplekt+"_";
               RLtoArray (arrRL, "RLineS"+ ExtComplekt+"_");
               j1=ArraySize(arrRL);
               mAPs=false;
               st_din=0;
               prefics="m#"+ExtComplekt+"_"+"s ";
               str05median="pmedianaS";
               strSLM382="SLM382S";
               strSLM618="SLM618S";
              }
            else if (i==1 && mAPd)
              {
               RLtoArray (arrRL, "RLineD"+ ExtComplekt+"_");
               j1=ArraySize(arrRL);
               nameObj="pitchforkD" + ExtComplekt+"_"; 
               mAPd=false;
               st_din=1;
               prefics="m#"+ExtComplekt+"_"+"d ";
               str05median="pmedianaD";
               strSLM382="SLM382D";
               strSLM618="SLM618D";
              }

            if (StringLen(nameObj)==0) continue;

            // определяем время и цену точек, к которым привязаны вилы Эндрюса
            pitch_time[0]=ObjectGet(nameObj,OBJPROP_TIME1); pitch_cena[0]=ObjectGet(nameObj,OBJPROP_PRICE1);
            pitch_time[1]=ObjectGet(nameObj,OBJPROP_TIME2); pitch_cena[1]=ObjectGet(nameObj,OBJPROP_PRICE2);
            pitch_time[2]=ObjectGet(nameObj,OBJPROP_TIME3); pitch_cena[2]=ObjectGet(nameObj,OBJPROP_PRICE3);
            // определяем номера баров, к которым привязаны вилы Эндрюса
            a1=iBarShift(NULL,Period(),pitch_time[0],false);
            b1=iBarShift(NULL,Period(),pitch_time[1],false);
            c1=iBarShift(NULL,Period(),pitch_time[2],false);
            // определяем тангенсы (наклон линий)
            // допускаем, что не используются вилы, у которых 2 и 3 точки привязки находятся на одном баре (b!=с).
            if (b1-c1==0) continue;
            // тангенс угла наклона линий реакции вил Эндрюса
            tangensRL=(pitch_cena[2]-pitch_cena[1])/(b1-c1);
            // тангенс угла наклона 1/2 медианы вил Эндрюса
            if (ObjectFind(str05median+ExtComplekt+"_")>=0) tangens05median=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
            // тангенс угла наклона вил Эндрюса
            if ((a1-(c1+b1)/2.0)!=0) tangensAP=((pitch_cena[2]+pitch_cena[1])/2-pitch_cena[0])/(a1-(c1+b1)/2.0);
            // определяем расстояние по вертикали от SSL до FSL - база по высоте вил Эндрюса
            hAP=pitch_cena[1]+(b1-c1)*tangensAP-pitch_cena[2];
            // определяем базу для вычисления линий реакции RL - база по времени
            bazaAP=a1-(b1+c1)/2.0;

            // определяем пересечение ISL и RL в точке текущей цены рынка
            if (((mSSL>4 || m1_2Mediana>4 || mISL382>4 || mMediana>4 || mISL618>4 || mFSL>4 || mSLM>4 || mFSLShiffLines>4 || mUTL>4 || mLTL>4 || mUWL>4 || mLWL>4) && i==0) ||
                ((mSSL_d>4 || m1_2Mediana_d>4 || mISL382_d>4 || mMediana_d>4 || mISL618_d>4 || mFSL_d>4 || mSLM_d>4 || mFSLShiffLines_d>4) && i==1))
              {
               xISL=(hAP-(pitch_cena[1]+tangensAP*b1-iClose(NULL,Period(),0)))/hAP; // условная линия ISL
               xret=(c1+(b1-c1)*xISL)/bazaAP;  // условная линия RL
              }
            // создание меток

            // создание меток у точек привязки вил Эндрюса
            if (mPivotPoints)
              {
               nameObj=prefics+"point 1 AP";
               ObjectCreate(nameObj,OBJ_ARROW,0,pitch_time[0],pitch_cena[0]);
               ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
               ObjectSet(nameObj,OBJPROP_BACK,mBack);
               if (!mPivotPointsChangeColor)
                 {
                  if (pitch_cena[0]<pitch_cena[1] || pitch_cena[1]>pitch_cena[2]) updn=true; else updn=false;
                  if (updn) ObjectSet(nameObj,OBJPROP_COLOR, mColorDN); else ObjectSet(nameObj,OBJPROP_COLOR, mColorUP);
                 }

               nameObj=prefics+"point 2 AP";
               ObjectCreate(nameObj,OBJ_ARROW,0,pitch_time[1],pitch_cena[1]);
               ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
               ObjectSet(nameObj,OBJPROP_BACK,mBack);
               if (!mPivotPointsChangeColor)
                 {
                  if (updn) ObjectSet(nameObj,OBJPROP_COLOR, mColorUP); else ObjectSet(nameObj,OBJPROP_COLOR, mColorDN);
                 }

               nameObj=prefics+"point 3 AP";
               ObjectCreate(nameObj,OBJ_ARROW,0,pitch_time[2],pitch_cena[2]);
               ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
               ObjectSet(nameObj,OBJPROP_BACK,mBack);
               if (!mPivotPointsChangeColor)
                 {
                  if (updn) ObjectSet(nameObj,OBJPROP_COLOR, mColorDN); else ObjectSet(nameObj,OBJPROP_COLOR, mColorUP);
                 }
              }

            nameObj=str05median+ExtComplekt+"_";
            if (ExtPitchforkStatic==2 || ExtPitchforkDinamic==2 || ObjectFind(nameObj)>=0)
              {
               // создание метки при пересечении 50%-й медианы с ISL 38.2 и начальной сигнальной линией
               if ((mCriticalPoints && i==0) || (mCriticalPoints_d && i==1))
                 {
//                  nameObj=str05median+ExtComplekt+"_";
                  if (ObjectFind(nameObj)>=0)
                    {
                     // количество баров от третьей точки привязки вил Эндрюса до точки пересечения 50%-й медианы с начальной сигнальной линией
                     X=(pitch_cena[2]-ObjectGetValueByShift(nameObj,c1))/(tangens05median-tangensAP); x=X; if (x<X) x++;
                     cena1=pitch_cena[2]+X*tangensAP;
                     if (x<=c1) {time1=iTime(NULL,Period(),c1-x); symb=SYMBOL_LEFTPRICE;} else {time1=iTime(NULL,Period(),0)+(x-c1)*60*Period(); symb=SYMBOL_RIGHTPRICE;}
                     nameObj=prefics+"50% Mediana x SSL";
                     ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                     ObjectSet(nameObj,OBJPROP_ARROWCODE,symb);
                     ObjectSet(nameObj,OBJPROP_BACK,mBack);

                     // вычисляем расстояние до красной зоны
                     if ((i==0 && RZs<0) || (i==1 && RZd<0))
                       {
                        if (pitch_cena[1]>pitch_cena[2])
                          {
                           for (k=b1-1;k>=c1;k--)
                             {
                              delta=iHigh(NULL,Period(),k)-(pitch_cena[1]+(b1-k)*tangensRL);
                              if (delta>h) h=delta;
                             }
                          }
                        else
                          {
                           for (k=b1-1;k>=c1;k--)
                             {
                              delta=(pitch_cena[1]+(b1-k)*tangensRL)-iLow(NULL,Period(),k);
                              if (delta>h) h=delta;
                             }
                          }
                        if (i==0) RZs=h; else RZd=h;
                       }
                     else
                       {
                        if (i==0) h=RZs; else h=RZd;
                       }

                     nameObj=str05median+ExtComplekt+"_";
                     // количество баров от третьей точки привязки вил Эндрюса до точки пересечения 50%-й медианы с начальной сигнальной линией
                     cena2=ObjectGetValueByShift(nameObj,b1);
                     X=(pitch_cena[0]-cena2+(a1-b1)*tangensAP-(phi-1.5)*(pitch_cena[1]+(b1-c1)*tangensAP-pitch_cena[2]))/(tangens05median-tangensAP);
                     x=X;
                     cena2=cena2+X*tangens05median;
                     if (x<=b1) {time1=iTime(NULL,Period(),b1-x); symb=SYMBOL_LEFTPRICE;}
                     else {if (x<X) x++; time1=iTime(NULL,Period(),0)+(x-b1)*60*Period(); symb=SYMBOL_RIGHTPRICE;}
                     if (MathAbs(pitch_cena[1]+x*tangensRL-cena1)>h)
                       {
                        nameObj=prefics+"50% Mediana x ISL 38.2";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena2);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,symb);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                       }
                     else cena2=0;

                     if (writetofile)
                       {
                        FileSeek(handle, 0, SEEK_END);
                        FileWrite(handle, 0, 10, 1, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                       }
                    }
                 }

               // создание метки при пересечении нулевого бара 50%-й медианой вил Эндрюса
               if ((m1_2Mediana>0 && i==0) || (m1_2Mediana_d>0 && i==1))
                 {
                  nameObj=str05median+ExtComplekt+"_";
                  if (ObjectFind(nameObj)>=0)
                    {
                     cena1=ObjectGetValueByShift(nameObj,0);
                     nameObj=prefics+"50% Mediana x 0-bar";
                     if ((m1_2Mediana==1 && i==0) || (m1_2Mediana_d==1 && i==1))
                       {
                        ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                        if (writetofile)
                          {
                           FileSeek(handle, 0, SEEK_END);
                           if (i==0) FileWrite(handle, 0, 3, m1_2Mediana, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                            DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                           else  FileWrite(handle, 0, 3, m1_2Mediana_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                            DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                          }
                       }
                     else //if ((m1_2Mediana>1 && i==0) || (m1_2Mediana_d>1 && i==1))
                       {
                        retISL=(cena1 -(pitch_cena[2]+c1*tangensAP))/hAP;
                        if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; else ret=(cena1-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                        if (m1_2Mediana>4 && xISL>retISL) ret=xret;

                        rl1=0; rl2=0;
                        for (m=0;m<j1;m++)
                          {
                           if (arrRL[m]>=ret)
                             {
                              rl2=arrRL[m];
                              break;
                             }
                           else
                             {
                              rl1=arrRL[m];
                             }
                          }

                        if (rl2>0)
                          {
                           nameObj=str05median+ExtComplekt+"_";
                           cenaRL=pitch_cena[1]+bazaAP*rl1*(tangensAP-tangensRL);
                           wr=ObjectGetValueByShift(nameObj,b1);
                           X=(cenaRL-wr)/(tangens05median-tangensRL);
                           x=X;
                           if (tangensAP!=0) cena1=wr+X*tangens05median; else cena1=cenaRL+X*tangensRL;
                           if (x<=b1) time1=iTime(NULL,Period(),b1-x); else time1=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                           cenaRL=pitch_cena[1]+bazaAP*rl2*(tangensAP-tangensRL);
                           X=(cenaRL-wr)/(tangens05median-tangensRL);
                           x=X; if (x<X) x++;
                           if (tangensAP!=0) cena2=wr+X*tangens05median; else cena2=cenaRL+X*tangensRL;
                           if (x<=b1) time2=iTime(NULL,Period(),b1-x); else time2=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              if (i==0) FileWrite(handle, 0, 3, m1_2Mediana, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                              else  FileWrite(handle, 0, 3, m1_2Mediana_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }

                           if (((m1_2Mediana==2 || m1_2Mediana==4 || m1_2Mediana==5 || m1_2Mediana==7 || m1_2Mediana==9) && i==0)
                            || ((m1_2Mediana_d==2 || m1_2Mediana_d==4 || m1_2Mediana_d==5 || m1_2Mediana_d==7 || m1_2Mediana_d==9) && i==1))
                             {
                              nameObj=prefics+"50% Mediana left 0-bar";
                              ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                              ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                              ObjectSet(nameObj,OBJPROP_BACK,mBack);

                              nameObj=prefics+"50% Mediana right 0-bar";
                              ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                              ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                              ObjectSet(nameObj,OBJPROP_BACK,mBack);
                             }

                           if ((m1_2Mediana>7 && i==0) || (m1_2Mediana_d>7 && i==1))
                             {
                              nameObj=prefics+"50% Mediana line Zones";
                              ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                              ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                              ObjectSet(nameObj,OBJPROP_RAY,false); 
                              ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                             }
                           else if (((m1_2Mediana>2 && m1_2Mediana!=5) && i==0) || ((m1_2Mediana_d>2 && m1_2Mediana_d!=5) && i==1))
                             {
                              if (((m1_2Mediana>5) && i==0) || ((m1_2Mediana_d>5) && i==1)) nameObj=prefics+"Shift 50% Mediana Zones"; else nameObj=prefics+"50% Mediana Zones";
                              ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                              ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                             }
                          }
                       }
                    }
                 }

               // метки на SLM
               if (ExtSLMStatic || ExtSLMDinamic)
                 {
                  if ((mSLM>0 && i==0) || (mSLM_d>0 && i==1))
                    {
                     // создание меток на SLM382
                     nameObj=strSLM382+ExtComplekt+"_";
                     if (ObjectFind(nameObj)>=0)
                       {
                        cena1=ObjectGetValueByShift(nameObj,0);
                        nameObj=prefics+"SLM 38.2 x 0-bar";
                        if ((mSLM==1 && i==0) || (mSLM_d==1 && i==1))
                          {
                           ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                           ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                           ObjectSet(nameObj,OBJPROP_BACK,mBack);
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              if (i==0) FileWrite(handle, 0, 2, mSLM, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                              else  FileWrite(handle, 0, 2, mSLM_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }
                          }
                        else if ((mSLM>1 && i==0) || (mSLM_d>1 && i==1))
                          {
                           retISL=(cena1 -(pitch_cena[2]+c1*tangensAP))/hAP;
                           if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; 
                           else ret=(cena1-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                           if ((mSLM>4 || mSLM_d>4) && xISL>retISL) ret=xret;

                           rl1=0; rl2=0;
                           for (m=0;m<j1;m++)
                             {
                              if (arrRL[m]>=ret)
                                {
                                 rl2=arrRL[m];
                                 break;
                                }
                              else
                                {
                                 rl1=arrRL[m];
                                }
                             }

                           if (rl2>0)
                             {
                              nameObj=strSLM382+ExtComplekt+"_";
                              cenaRL=pitch_cena[1]+bazaAP*rl1*(tangensAP-tangensRL);
                              wr=ObjectGetValueByShift(nameObj,c1)-tangens05median*(b1-c1);
                              X=(cenaRL-wr)/(tangens05median-tangensRL);
                              x=X;
                              if (tangensAP!=0) cena1=wr+X*tangens05median; else cena1=cenaRL+X*tangensRL;
                              if (x<=b1) time1=iTime(NULL,Period(),b1-x); else time1=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                              cenaRL=pitch_cena[1]+bazaAP*rl2*(tangensAP-tangensRL);
                              X=(cenaRL-wr)/(tangens05median-tangensRL);
                              x=X; if (x<X) x++;
                              if (tangensAP!=0) cena2=wr+X*tangens05median; else cena2=cenaRL+X*tangensRL;
                              if (x<=b1) time2=iTime(NULL,Period(),b1-x); else time2=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                              if (writetofile)
                                {
                                 FileSeek(handle, 0, SEEK_END);
                                 if (i==0) FileWrite(handle, 0, 2, mSLM, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                   DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                 else  FileWrite(handle, 0, 2, mSLM_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                   DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                }

                              if (((mSLM==2 || mSLM==4 || mSLM==5 || mSLM==7 || mSLM==9) && i==0)
                               || ((mSLM_d==2 || mSLM_d==4 || mSLM_d==5 || mSLM_d==7 || mSLM_d==9) && i==1))
                                {
                                 nameObj=prefics+"SLM 38.2 left 0-bar";
                                 ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                                 ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBack);

                                 nameObj=prefics+"SLM 38.2 right 0-bar";
                                 ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBack);
                                }

                              if ((mSLM>7 && i==0) || (mSLM_d>7 && i==1))
                                {
                                 nameObj=prefics+"SLM 38.2 line Zones";
                                 ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                                 ObjectSet(nameObj,OBJPROP_RAY,false); 
                                 ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                                }
                              else if (((mSLM>2 && mSLM!=5) && i==0) || ((mSLM_d>2 && mSLM_d!=5) && i==1))
                                {
                                 if (((mSLM>5) && i==0) || ((mSLM_d>5) && i==1)) nameObj=prefics+"Shift SLM 38.2 Zones"; else nameObj=prefics+"SLM 38.2 Zones";
                                 ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                                }
                             }
                          }
                       }

                     // создание меток на SLM618
                     nameObj=strSLM618+ExtComplekt+"_";
                     if (ObjectFind(nameObj)>=0)
                       {
                        cena1=ObjectGetValueByShift(nameObj,0);
                        nameObj=prefics+"SLM 61.8 x 0-bar";
                        if ((mSLM==1 && i==0) || (mSLM_d==1 && i==1))
                          {
                           ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                           ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                           ObjectSet(nameObj,OBJPROP_BACK,mBack);
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              if (i==0) FileWrite(handle, 0, 4, mSLM, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                              else  FileWrite(handle, 0, 4, mSLM_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }
                          }
                        else if ((mSLM>1 && i==0) || (mSLM_d>1 && i==1))
                          {
                           retISL=(cena1 -(pitch_cena[2]+c1*tangensAP))/hAP;
                           if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; 
                           else ret=(cena1-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                           if ((mSLM>4 || mSLM_d>4) && xISL>retISL) ret=xret;

                           rl1=0; rl2=0;
                           for (m=0;m<j1;m++)
                             {
                              if (arrRL[m]>=ret)
                                {
                                 rl2=arrRL[m];
                                 break;
                                }
                              else
                                {
                                 rl1=arrRL[m];
                                }
                             }

                           if (rl2>0)
                             {
                              nameObj=strSLM618+ExtComplekt+"_";
                              cenaRL=pitch_cena[1]+bazaAP*rl1*(tangensAP-tangensRL);
                              wr=ObjectGetValueByShift(nameObj,c1)-tangens05median*(b1-c1);
                              X=(cenaRL-wr)/(tangens05median-tangensRL);
                              x=X;
                              if (tangensAP!=0) cena1=wr+X*tangens05median; else cena1=cenaRL+X*tangensRL;
                              if (x<=b1) time1=iTime(NULL,Period(),b1-x); else time1=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                              cenaRL=pitch_cena[1]+bazaAP*rl2*(tangensAP-tangensRL);
                              X=(cenaRL-wr)/(tangens05median-tangensRL);
                              x=X; if (x<X) x++;
                              if (tangensAP!=0) cena2=wr+X*tangens05median; else cena2=cenaRL+X*tangensRL;
                              if (x<=b1) time2=iTime(NULL,Period(),b1-x); else time2=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                              if (writetofile)
                                {
                                 FileSeek(handle, 0, SEEK_END);
                                 if (i==0) FileWrite(handle, 0, 4, mSLM, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                   DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                 else  FileWrite(handle, 0, 4, mSLM_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                   DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                }

                              if (((mSLM==2 || mSLM==4 || mSLM==5 || mSLM==7 || mSLM==9) && i==0)
                               || ((mSLM_d==2 || mSLM_d==4 || mSLM_d==5 || mSLM_d==7 || mSLM_d==9) && i==1))
                                {
                                 nameObj=prefics+"SLM 61.8 left 0-bar";
                                 ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                                 ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBack);

                                 nameObj=prefics+"SLM 61.8 right 0-bar";
                                 ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBack);
                                }

                              if ((mSLM>7 && i==0) || (mSLM_d>7 && i==1))
                                {
                                 nameObj=prefics+"SLM 61.8 line Zones";
                                 ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                                 ObjectSet(nameObj,OBJPROP_RAY,false); 
                                 ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                                }
                              else if (((mSLM>2 && mSLM!=5) && i==0) || ((mSLM_d>2 && mSLM_d!=5) && i==1))
                                {
                                 if (((mSLM>5) && i==0) || ((mSLM_d>5) && i==1)) nameObj=prefics+"Shift SLM 61.8 Zones"; else nameObj=prefics+"SLM 61.8 Zones";
                                 ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                                }
                             }
                          }
                       }
                    }
                 }

               // создание меток на FSL Shiff Lines
               if (ExtFSLShiffLinesStatic || ExtFSLShiffLinesDinamic)
                 {
                  if ((mFSLShiffLines>0 && i==0) || (mFSLShiffLines_d>0 && i==1))
                    {
                     if (i==0) nameObj="FSL Shiff Lines S" + ExtComplekt+"_"; else nameObj="FSL Shiff Lines D" + ExtComplekt+"_";
                     if (ObjectFind(nameObj)>=0)
                       {
                        cena1=ObjectGetValueByShift(nameObj,0);
                        nameObj=prefics+"FSL Shiff Lines x 0-bar";
                        if ((mFSLShiffLines==1 && i==0) || (mFSLShiffLines_d==1 && i==1))
                          {
                           ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                           ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                           ObjectSet(nameObj,OBJPROP_BACK,mBack);
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              if (i==0) FileWrite(handle, 0, 9, mFSLShiffLines, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                              else  FileWrite(handle, 0, 9, mFSLShiffLines_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }
                          }
                        else if ((mFSLShiffLines>1 && i==0) || (mFSLShiffLines_d>1 && i==1))
                          {
                           retISL=(cena1 -(pitch_cena[2]+c1*tangensAP))/hAP;
                           if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; 
                           else ret=(cena1-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                           if (((mFSLShiffLines>4 && i==0) || (mFSLShiffLines_d>4 && i==1)) && xISL>retISL) ret=xret;

                           rl1=0; rl2=0;
                           for (m=0;m<j1;m++)
                             {
                              if (arrRL[m]>=ret)
                                {
                                 rl2=arrRL[m];
                                 break;
                                }
                              else
                                {
                                 rl1=arrRL[m];
                                }
                             }
                           if (rl2>0)
                             {
                              if (i==0) nameObj="FSL Shiff Lines S" + ExtComplekt+"_"; else nameObj="FSL Shiff Lines D" + ExtComplekt+"_";
                              cenaRL=pitch_cena[1]+bazaAP*rl1*(tangensAP-tangensRL);
                              wr=ObjectGetValueByShift(nameObj,c1)-tangens05median*(b1-c1);
                              X=(cenaRL-wr)/(tangens05median-tangensRL);
                              x=X;
                              if (tangensAP!=0) cena1=wr+X*tangens05median; else cena1=cenaRL+X*tangensRL;
                              if (x<=b1) time1=iTime(NULL,Period(),b1-x); else time1=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                              cenaRL=pitch_cena[1]+bazaAP*rl2*(tangensAP-tangensRL);
                              X=(cenaRL-wr)/(tangens05median-tangensRL);
                              x=X; if (x<X) x++;
                              if (tangensAP!=0) cena2=wr+X*tangens05median; else cena2=cenaRL+X*tangensRL;
                              if (x<=b1) time2=iTime(NULL,Period(),b1-x); else time2=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                              if (writetofile)
                                {
                                 FileSeek(handle, 0, SEEK_END);
                                 if (i==0) FileWrite(handle, 0, 9, mFSLShiffLines, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                   DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                 else  FileWrite(handle, 0, 9, mFSLShiffLines_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                   DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                }

                              if (((mFSLShiffLines==2 || mFSLShiffLines==4 || mFSLShiffLines==5 || mFSLShiffLines==7 || mFSLShiffLines==9) &&i==0) ||
                                   ((mFSLShiffLines_d==2 || mFSLShiffLines_d==4 || mFSLShiffLines_d==5 || mFSLShiffLines_d==7 || mFSLShiffLines_d==9) && i==1))
                                {
                                 nameObj=prefics+"FSL Shiff Lines left 0-bar";
                                 ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                                 ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBack);

                                 nameObj=prefics+"FSL Shiff Lines right 0-bar";
                                 ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBack);
                                }

                              if ((mFSLShiffLines>7 && i==0) || (mFSLShiffLines_d>7 && i==1))
                                {
                                 nameObj=prefics+"FSL Shiff Lines line Zones";
                                 ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                                 ObjectSet(nameObj,OBJPROP_RAY,false); 
                                 ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                                }
                              else if (((mFSLShiffLines>2 && mFSLShiffLines!=5) && i==0) || ((mFSLShiffLines_d>2 && mFSLShiffLines_d!=5) && i==1))
                                {
                                 if ((mFSLShiffLines>5 && i==0) || (mFSLShiffLines_d>5 && i==1)) nameObj=prefics+"Shift FSL Shiff Lines Zones"; else nameObj=prefics+"FSL Shiff Lines Zones";
                                 ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                                 ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                                }
                             }
                          }
                       }
                    }
                 }
              }

            // создание меток при пересечении линиями нулевого бара

            // создание метки при пересечении нулевого бара линией SSL
            if ((mSSL>0 && i==0) || (mSSL_d>0 && i==1))
              {
               nameObj=prefics+"SSL x 0-bar";
               cena1=pitch_cena[2]+c1*tangensAP;
               if ((mSSL==1 && i==0) || (mSSL_d==1 && i==1))
                 {
                  ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                  ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                  ObjectSet(nameObj,OBJPROP_BACK,mBack);
                  if (writetofile)
                    {
                     FileSeek(handle, 0, SEEK_END);
                     if (i==0) FileWrite(handle, 0, 1, mSSL, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                     else  FileWrite(handle, 0, 1, mSSL_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                    }
                 }
               else if ((mSSL>1 && i==0) || (mSSL_d>1 && i==1))
                 {
                  if (((mSSL<5 || (xISL<=0 && mSSL>4)) && i==0) || ((mSSL_d<5 || (xISL<=0 && mSSL_d>4)) && i==1))
                    {
                     if (tangensAP==0) ret=c1/bazaAP; else ret=(cena1-pitch_cena[2])/(tangensAP*bazaAP);
                    }
                  else ret=xret;

                  rl1=0; rl2=0;
                  for (m=0;m<j1;m++)
                    {
                     if (arrRL[m]>=ret)
                       {
                        rl2=arrRL[m];
                        break;
                       }
                     else
                       {
                        rl1=arrRL[m];
                       }
                    }

                  if (rl2>0)
                    {
                     X=bazaAP*rl1; x=X;
                     cena1=pitch_cena[2]+X*tangensAP;
                     if (x<=c1) time1=iTime(NULL,Period(),c1-x); else time1=iTime(NULL,Period(),0)+(x-c1)*Period()*60;
                     X=bazaAP*rl2; x=X; if (x<X) x++;
                     cena2=pitch_cena[2]+X*tangensAP;
                     if (x<=c1) time2=iTime(NULL,Period(),c1-x); else time2=iTime(NULL,Period(),0)+(x-c1)*Period()*60;
                     if (writetofile)
                       {
                        FileSeek(handle, 0, SEEK_END);
                        if (i==0) FileWrite(handle, 0, 1, mSSL, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                        else  FileWrite(handle, 0, 1, mSSL_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                       }

                     if (((mSSL==2 || mSSL==4 || mSSL==5 || mSSL==7 || mSSL==9) && i==0)
                      || ((mSSL_d==2 || mSSL_d==4 || mSSL_d==5 || mSSL_d==7 || mSSL_d==9) && i==1))
                       {
                        nameObj=prefics+"SSL left 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);

                        nameObj=prefics+"SSL right 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                       }

                     if ((mSSL>7 && i==0) || (mSSL_d>7 && i==1))
                       {
                        nameObj=prefics+"SSL line Zones";
                        ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                        ObjectSet(nameObj,OBJPROP_RAY,false); 
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                       }
                     else if (((mSSL>2 && mSSL!=5) && i==0) || ((mSSL_d>2 && mSSL_d!=5) && i==1))
                       {
                        if (((mSSL>5) && i==0) || ((mSSL_d>5) && i==1)) nameObj=prefics+"Shift SSL Zones"; else nameObj=prefics+"SSL Zones";
                        ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                       }
                    }
                 }
              }

            // создание метки при пересечении нулевого бара линией FSL
            if ((mFSL>0 && i==0) || (mFSL_d>0 && i==1))
              {
               nameObj=prefics+"FSL x 0-bar";
               cena1=pitch_cena[1]+b1*tangensAP;
               if ((mFSL==1 && i==0) || (mFSL_d==1 && i==1))
                 {
                  ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                  ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                  ObjectSet(nameObj,OBJPROP_BACK,mBack);
                  if (writetofile)
                    {
                     FileSeek(handle, 0, SEEK_END);
                     if (i==0) FileWrite(handle, 0, 8, mFSL, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                     else  FileWrite(handle, 0, 8, mFSL_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                    }
                 }
               else if ((mFSL>1 && i==0) || (mFSL_d>1 && i==1))
                 {
                  if (((mFSL<5 || (xISL<=1 && mFSL>4)) && i==0) || ((mFSL_d<5 || (xISL<=1 && mFSL_d>4)) && i==1))
                    {
                     if (tangensAP==0) ret=b1/bazaAP; else ret=(cena1-pitch_cena[1])/(tangensAP*bazaAP);
                    }
                  else ret=xret;

                  rl1=0; rl2=0;
                  for (m=0;m<j1;m++)
                    {
                     if (arrRL[m]>=ret)
                       {
                        rl2=arrRL[m];
                        break;
                       }
                     else
                       {
                        rl1=arrRL[m];
                       }
                    }

                  if (rl2>0)
                    {
                     X=bazaAP*rl1; x=X;
                     cena1=pitch_cena[1]+X*tangensAP;
                     if (x<=b1) time1=iTime(NULL,Period(),b1-x); else time1=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                     X=bazaAP*rl2; x=X; if (x<X) x++;
                     cena2=pitch_cena[1]+X*tangensAP;
                     if (x<=b1) time2=iTime(NULL,Period(),b1-x); else time2=iTime(NULL,Period(),0)+(x-b1)*Period()*60;
                     if (writetofile)
                       {
                        FileSeek(handle, 0, SEEK_END);
                        if (i==0) FileWrite(handle, 0, 8, mFSL, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                        else  FileWrite(handle, 0, 8, mFSL_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                       }

                     if (((mFSL==2 || mFSL==4 || mFSL==5 || mFSL==7 || mFSL==9) && i==0)
                      || ((mFSL_d==2 || mFSL_d==4 || mFSL_d==5 || mFSL_d==7 || mFSL_d==9) && i==1))
                       {
                        nameObj=prefics+"FSL left 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);

                        nameObj=prefics+"FSL right 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                       }

                     if ((mFSL>7 && i==0) || (mFSL_d>7 && i==1))
                       {
                        nameObj=prefics+"FSL line Zones";
                        ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                        ObjectSet(nameObj,OBJPROP_RAY,false); 
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                       }
                     else if (((mFSL>2 && mFSL!=5) && i==0) || ((mFSL_d>2 && mFSL_d!=5) && i==1))
                       {
                        if (((mFSL>5) && i==0) || ((mFSL_d>5) && i==1)) nameObj=prefics+"Shift FSL Zones"; else nameObj=prefics+"FSL Zones";
                        ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                       }
                    }
                 }
              }

            // создание метки при пересечении нулевого бара медианой вил Эндрюса
            if ((mMediana>0 && i==0) || (mMediana_d>0 && i==1))
              {
               nameObj=prefics+"Mediana x 0-bar";
               cena1=pitch_cena[0]+a1*tangensAP;
               if ((mMediana==1 && i==0) || (mMediana_d==1 && i==1))
                 {
                  ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                  ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                  ObjectSet(nameObj,OBJPROP_BACK,mBack);
                  if (writetofile)
                    {
                     FileSeek(handle, 0, SEEK_END);
                     if (i==0) FileWrite(handle, 0, 6, mMediana, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                     else  FileWrite(handle, 0, 6, mMediana_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                    }
                 }
               else if ((mMediana>1 && i==0) || (mMediana_d>1 && i==1))
                 {
                  if (((mMediana<5 || (xISL<=0.5 && mMediana>4)) && i==0) || ((mMediana_d<5 || (xISL<=0.5 && mMediana_d>4)) && i==1))
                    {
                     if (tangensAP==0) ret=a1/bazaAP-1; else ret=(cena1-pitch_cena[0])/(tangensAP*bazaAP)-1;
                    }
                  else ret=xret;

                  rl1=0; rl2=0;
                  for (m=0;m<j1;m++)
                    {
                     if (arrRL[m]>=ret)
                       {
                        rl2=arrRL[m];
                        break;
                       }
                     else
                       {
                        rl1=arrRL[m];
                       }
                    }

                  if (rl2>0)
                    {
                     X=bazaAP*(rl1+1); x=X;
                     cena1=pitch_cena[0]+X*tangensAP;
                     if (x<=a1) time1=iTime(NULL,Period(),a1-x); else time1=iTime(NULL,Period(),0)+(x-a1)*Period()*60;
                     X=bazaAP*(rl2+1); x=X; if (x<X) x++;
                     cena2=pitch_cena[0]+X*tangensAP;
                     if (x<=a1) time2=iTime(NULL,Period(),a1-x); else time2=iTime(NULL,Period(),0)+(x-a1)*Period()*60;
                     if (writetofile)
                       {
                        FileSeek(handle, 0, SEEK_END);
                        if (i==0) FileWrite(handle, 0, 6, mMediana, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                        else  FileWrite(handle, 0, 6, mMediana_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                       }

                     if (((mMediana==2 || mMediana==4 || mMediana==6 || mMediana==7 || mMediana==9) && i==0)
                      || ((mMediana_d==2 || mMediana_d==4 || mMediana_d==6 || mMediana_d==7 || mMediana_d==9) && i==1))
                       {
                        nameObj=prefics+"Mediana left 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);

                        nameObj=prefics+"Mediana right 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                       }

                     if ((mMediana>7 && i==0) || (mMediana_d>7 && i==1))
                       {
                        nameObj=prefics+"Mediana line Zones";
                        ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                        ObjectSet(nameObj,OBJPROP_RAY,false); 
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                       }
                     else if (((mMediana>2 && mMediana!=5) && i==0) || ((mMediana_d>2 && mMediana_d!=5) && i==1))
                       {
                        if (((mMediana>5) && i==0) || ((mMediana_d>5) && i==1)) nameObj=prefics+"Shift Mediana Zones"; else nameObj=prefics+"Mediana Zones";
                        ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                       }
                    }
                 }
              }

            // создание метки при пересечении нулевого бара линией ISL 38.2
            if ((mISL382>0 && i==0) || (mISL382_d>0 && i==1))
              {
               nameObj=prefics+"ISL 38.2 x 0-bar";
               cena1=pitch_cena[2]+c1*tangensAP+hAP*(2-phi);
               if ((mISL382==1 && i==0) || (mISL382_d==1 && i==1))
                 {
                  ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                  ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                  ObjectSet(nameObj,OBJPROP_BACK,mBack);
                  if (writetofile)
                    {
                     FileSeek(handle, 0, SEEK_END);
                     if (i==0) FileWrite(handle, 0, 5, mISL382, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                     else  FileWrite(handle, 0, 5, mISL382_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                    }
                 }
               else if ((mISL382>1 && i==0) || (mISL382_d>1 && i==1))
                 {
                  if (((mISL382<5 || (xISL<=(2-phi) && mISL382>4)) && i==0) || ((mISL382_d<5 || (xISL<=(2-phi) && mISL382_d>4)) && i==1))
                    {
                     if (tangensAP==0) ret=(c1+(2-phi)*(b1-c1))/bazaAP; else ret=(cena1-pitch_cena[2]-(2-phi)*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);
                    }
                  else ret=xret;

                  rl1=0; rl2=0;
                  for (m=0;m<j1;m++)
                    {
                     if (arrRL[m]>=ret)
                       {
                        rl2=arrRL[m];
                        break;
                       }
                     else
                       {
                        rl1=arrRL[m];
                       }
                    }

                  if (rl2>0)
                    {
                     X=bazaAP*rl1; x=X;
                     cena1=pitch_cena[2]+X*tangensAP+(2-phi)*(hAP-(b1-c1)*tangensAP);
                     if (x<=b1-(b1-c1)*(phi-1)) time1=iTime(NULL,Period(),b1-(b1-c1)*(phi-1)-x); else time1=iTime(NULL,Period(),0)+(x-b1+(b1-c1)*(phi-1))*Period()*60;
                     X=bazaAP*rl2; x=X; if (x<X) x++;
                     cena2=pitch_cena[2]+X*tangensAP+(2-phi)*(hAP-(b1-c1)*tangensAP);
                     if (x<=b1-(b1-c1)*(phi-1)) time2=iTime(NULL,Period(),b1-(b1-c1)*(phi-1)-x); else time2=iTime(NULL,Period(),0)+(x-b1+(b1-c1)*(phi-1))*Period()*60;
                     if (writetofile)
                       {
                        FileSeek(handle, 0, SEEK_END);
                        if (i==0) FileWrite(handle, 0, 5, mISL382, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                        else  FileWrite(handle, 0, 5, mISL382_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                       }

                     if (((mISL382==2 || mISL382==4 || mISL382==5 || mISL382==7 || mISL382==9) && i==0)
                      || ((mISL382_d==2 || mISL382_d==4 || mISL382_d==5 || mISL382_d==7 || mISL382_d==9) && i==1))
                       {
                        nameObj=prefics+"ISL 38.2 left 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);

                        nameObj=prefics+"ISL 38.2 right 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                       }

                     if ((mISL382>7 && i==0) || (mISL382_d>7 && i==1))
                       {
                        nameObj=prefics+"ISL 38.2 line Zones";
                        ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                        ObjectSet(nameObj,OBJPROP_RAY,false); 
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                       }
                     else if (((mISL382>2 && mISL382!=5) && i==0) || ((mISL382_d>2 && mISL382_d!=5) && i==1))
                       {
                        if (((mISL382>5) && i==0) || ((mISL382_d>5) && i==1)) nameObj=prefics+"Shift ISL 38.2 Zones"; else nameObj=prefics+"ISL 38.2 Zones";
                        ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                       }
                    }
                 }
              }

            // создание метки при пересечении нулевого бара линией ISL 61.8
            if ((mISL618>0 && i==0) || (mISL618_d>0 && i==1))
              {
               nameObj=prefics+"ISL 61.8 x 0-bar";
               cena1=pitch_cena[2]+c1*tangensAP+hAP*(phi-1);
               if ((mISL618==1 && i==0) || (mISL618_d==1 && i==1))
                 {
                  ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                  ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                  ObjectSet(nameObj,OBJPROP_BACK,mBack);
                  if (writetofile)
                    {
                     FileSeek(handle, 0, SEEK_END);
                     if (i==0) FileWrite(handle, 0, 7, mISL618, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                     else  FileWrite(handle, 0, 7, mISL618_d, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                      DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                    }
                 }
               else if ((mISL618>1 && i==0) || (mISL618_d>1 && i==1))
                 {
                  if (((mISL618<5 || (xISL<=(phi-1) && mISL618>4)) && i==0) || ((mISL618_d<5 || (xISL<=(phi-1) && mISL618_d>4)) && i==1))
                    {
                     if (tangensAP==0) ret=(c1+(phi-1)*(b1-c1))/bazaAP; else ret=(cena1-pitch_cena[2]-(phi-1)*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);
                    }
                  else ret=xret;

                  rl1=0; rl2=0;
                  for (m=0;m<j1;m++)
                    {
                     if (arrRL[m]>=ret)
                       {
                        rl2=arrRL[m];
                        break;
                       }
                     else
                       {
                        rl1=arrRL[m];
                       }
                    }

                  if (rl2>0)
                    {
                     X=bazaAP*rl1; x=X;
                     cena1=pitch_cena[2]+X*tangensAP+(phi-1)*(hAP-(b1-c1)*tangensAP);
                     if (x<=b1-(b1-c1)*(2-phi)) time1=iTime(NULL,Period(),b1-(b1-c1)*(2-phi)-x); else time1=iTime(NULL,Period(),0)+(x-b1+(b1-c1)*(2-phi))*Period()*60;
                     X=bazaAP*rl2; x=X; if (x<X) x++;
                     cena2=pitch_cena[2]+X*tangensAP+(phi-1)*(hAP-(b1-c1)*tangensAP);
                     if (x<=b1-(b1-c1)*(2-phi)) time2=iTime(NULL,Period(),b1-(b1-c1)*(2-phi)-x); else time2=iTime(NULL,Period(),0)+(x-b1+(b1-c1)*(2-phi))*Period()*60;
                     if (writetofile)
                       {
                        FileSeek(handle, 0, SEEK_END);
                        if (i==0) FileWrite(handle, 0, 7, mISL618, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                        else  FileWrite(handle, 0, 7, mISL618_d, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                         DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                       }

                     if (((mISL618==2 || mISL618==4 || mISL618==5 || mISL618==7 || mISL618==9) && i==0)
                      || ((mISL618_d==2 || mISL618_d==4 || mISL618_d==5 || mISL618_d==7 || mISL618_d==9) && i==1))
                       {
                        nameObj=prefics+"ISL 61.8 left 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);

                        nameObj=prefics+"ISL 61.8 right 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                       }

                     if ((mISL618>7 && i==0) || (mISL618_d>7 && i==1))
                       {
                        nameObj=prefics+"ISL 61.8 line Zones";
                        ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                        ObjectSet(nameObj,OBJPROP_RAY,false); 
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                       }
                     else if (((mISL618>2 && mISL618!=5) && i==0) || ((mISL618_d>2 && mISL618_d!=5) && i==1))
                       {
                        if (((mISL618>5) && i==0) || ((mISL618_d>5) && i==1)) nameObj=prefics+"Shift ISL 61.8 Zones"; else nameObj=prefics+"ISL 61.8 Zones";
                        ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                        ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                       }
                    }
                 }
              }

            // создание метки при пересечении нулевого бара предупреждающими линиями LWL и/или UWL статичеких вил Эндрюса
            if (((mUWL>0 && ExtUWL>0) || (mLWL>0 && ExtLWL>0)) && i==0)
              {
               if (pitch_cena[1]>pitch_cena[2])
                 {
                  tangensUWL=(pitch_cena[1]-pitch_cena[0])/(a1-b1);
                  tangensLWL=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
                  cenaUWL=pitch_cena[1];
                  cenaLWL=pitch_cena[2];
                 }
               else
                 {
                  tangensUWL=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
                  tangensLWL=(pitch_cena[1]-pitch_cena[0])/(a1-b1);
                  cenaUWL=pitch_cena[2];
                  cenaLWL=pitch_cena[1];
                 }

               if (ExtUWL)
                 {
                  nameObj="UWL" + ExtComplekt+"_";
                  if (ObjectFind(nameObj)>=0)
                    {
                     // максимальное и минимальное значение цены метки
                     if (pitch_cena[1]>pitch_cena[2])
                       {
                        X=pitch_cena[1]+b1*tangensUWL;
                        Y=pitch_cena[1]+b1*tangensAP;
                       }
                     else
                       {
                        X=pitch_cena[2]+c1*tangensUWL; 
                        Y=pitch_cena[2]+c1*tangensAP;
                       }

                     x=ObjectGet(nameObj,OBJPROP_FIBOLEVELS);
                     for (k=0;k<x;k++)
                       {
                        Z=Y+MathAbs(hAP)*ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k)/2;
                        if (mUWL==1)
                          {
                           if (Z<=X)
                             {
                              nameFibo=prefics+"UWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3);
                              ObjectCreate(nameFibo,OBJ_ARROW,0,iTime(NULL,Period(),0),Z);
                              ObjectSet(nameFibo,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBack);
                              if (writetofile)
                                {
                                 FileSeek(handle, 0, SEEK_END);
                                 FileWrite(handle, 0, 13, mUWL, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                  DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                }
                             }
                           else
                             {
                              break;
                             }
                          }
                        else //if (mUWL>1)
                          {
                           retISL=(Z -(pitch_cena[2]+c1*tangensAP))/hAP;
                           if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; else ret=(Z-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                           if (mUWL>4 && xISL>retISL) ret=xret;

                           rl1=0; rl2=0;
                           for (m=0;m<j1;m++)
                             {
                              if (arrRL[m]>=ret)
                                {
                                 rl2=arrRL[m];
                                 break;
                                }
                              else
                                {
                                 rl1=arrRL[m];
                                }
                             }

                           W=bazaAP*rl2; // x=X; if (x<X) x++;
                           cena2=pitch_cena[2]+W*tangensAP+retISL*(hAP-(b1-c1)*tangensAP);
                           if ((cenaUWL+tangensUWL*W)<cena2) continue;
                           if (W<=c1+(b1-c1)*retISL) time2=iTime(NULL,Period(),c1+(b1-c1)*retISL-W); else time2=iTime(NULL,Period(),0)+(W-c1-(b1-c1)*retISL)*Period()*60;

                           W=bazaAP*rl1;
                           cena1=pitch_cena[2]+W*tangensAP+retISL*(hAP-(b1-c1)*tangensAP);
                           if (W<=c1+(b1-c1)*retISL) time1=iTime(NULL,Period(),c1+(b1-c1)*retISL-W); else time1=iTime(NULL,Period(),0)+(W-c1-(b1-c1)*retISL)*Period()*60;
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              FileWrite(handle, 0, 13, mUWL, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }

                           if (mUWL==2 || mUWL==4 || mUWL==5 || mUWL==7 || mUWL==9)
                             {
                              nameFibo=prefics+"UWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" left 0-bar";
                              ObjectCreate(nameFibo,OBJ_ARROW,0,time1,cena1);
                              ObjectSet(nameFibo,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBack);

                              nameFibo=prefics+"UWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" right 0-bar";
                              ObjectCreate(nameFibo,OBJ_ARROW,0,time2,cena2);
                              ObjectSet(nameFibo,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBack);
                             }

                           if (mUWL>7)
                             {
                              nameFibo=prefics+"UWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" line Zones";
                              ObjectCreate(nameFibo,OBJ_TREND,0,time1,cena1,time2,cena2);
                              ObjectSet(nameFibo,OBJPROP_WIDTH,mLineZonesWidth); 
                              ObjectSet(nameFibo,OBJPROP_RAY,false); 
                              ObjectSet(nameFibo,OBJPROP_BACK,mBackZones); 
                             }
                           else if (mUWL>2 && mUWL!=5)
                             {
                              if (mUWL>5) nameFibo=prefics+"UWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" Shift Zones"; 
                              else nameFibo=prefics+" "+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" Zones";
                              ObjectCreate(nameFibo,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBackZones);
                             }
                          }
                       }
                    }
                 }

               if (ExtLWL)
                 {
                  nameObj="LWL" + ExtComplekt+"_";
                  if (ObjectFind(nameObj)>=0)
                    {
                     // максимальное и минимальное значение цены метки
                     if (pitch_cena[1]>pitch_cena[2])
                       {
                        Y=pitch_cena[2]+c1*tangensAP;
                        X=pitch_cena[2]+c1*tangensLWL;
                       }
                     else
                       {
                        Y=pitch_cena[1]+b1*tangensAP;
                        X=pitch_cena[1]+b1*tangensLWL;
                      }

                     x=ObjectGet(nameObj,OBJPROP_FIBOLEVELS);
                     for (k=0;k<x;k++)
                       {
                        Z=Y-MathAbs(hAP)*ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k)/2;
                        if (mLWL==1)
                          {
                           if (Z>=X)
                             {
                              nameFibo=prefics+"LWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3);
                              ObjectCreate(nameFibo,OBJ_ARROW,0,iTime(NULL,Period(),0),Z);
                              ObjectSet(nameFibo,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBack);
                              if (writetofile)
                                {
                                 FileSeek(handle, 0, SEEK_END);
                                 FileWrite(handle, 0, 14, mLWL, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                                  DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                                }
                             }
                           else
                             {
                              break;
                             }
                          }
                        else //if (mLWL>1)
                          {
                           retISL=(Z -(pitch_cena[2]+c1*tangensAP))/hAP;
                           if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; else ret=(Z-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                           if (mLWL>4 && xISL>retISL) ret=xret;

                           rl1=0; rl2=0;
                           for (m=0;m<j1;m++)
                             {
                              if (arrRL[m]>=ret)
                                {
                                 rl2=arrRL[m];
                                 break;
                                }
                              else
                                {
                                 rl1=arrRL[m];
                                }
                             }

                           W=bazaAP*rl2; // x=X; if (x<X) x++;
                           cena2=pitch_cena[2]+W*tangensAP+retISL*(hAP-(b1-c1)*tangensAP);
                           if ((cenaLWL+tangensLWL*W)>cena2) continue;
                           if (W<=c1+(b1-c1)*retISL) time2=iTime(NULL,Period(),c1+(b1-c1)*retISL-W); else time2=iTime(NULL,Period(),0)+(W-c1-(b1-c1)*retISL)*Period()*60;

                           W=bazaAP*rl1;
                           cena1=pitch_cena[2]+W*tangensAP+retISL*(hAP-(b1-c1)*tangensAP);
                           if (W<=c1+(b1-c1)*retISL) time1=iTime(NULL,Period(),c1+(b1-c1)*retISL-W); else time1=iTime(NULL,Period(),0)+(W-c1-(b1-c1)*retISL)*Period()*60;
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              FileWrite(handle, 0, 14, mLWL, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }

                           if (mLWL==2 || mLWL==4 || mLWL==5 || mLWL==7 || mLWL==9)
                             {
                              nameFibo=prefics+"LWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" left 0-bar";
                              ObjectCreate(nameFibo,OBJ_ARROW,0,time1,cena1);
                              ObjectSet(nameFibo,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBack);

                              nameFibo=prefics+"LWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" right 0-bar";
                              ObjectCreate(nameFibo,OBJ_ARROW,0,time2,cena2);
                              ObjectSet(nameFibo,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBack);
                             }

                           if (mLWL>7)
                             {
                              nameFibo=prefics+"LWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" line Zones";
                              ObjectCreate(nameFibo,OBJ_TREND,0,time1,cena1,time2,cena2);
                              ObjectSet(nameFibo,OBJPROP_WIDTH,mLineZonesWidth); 
                              ObjectSet(nameFibo,OBJPROP_RAY,false); 
                              ObjectSet(nameFibo,OBJPROP_BACK,mBackZones); 
                             }
                           else if (mLWL>2 && mLWL!=5)
                             {
                              if (mLWL>5) nameFibo=prefics+"LWL"+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" Shift Zones"; 
                              else nameFibo=prefics+" "+DoubleToStr(ObjectGet(nameObj,OBJPROP_FIRSTLEVEL+k),3)+" Zones";
                              ObjectCreate(nameFibo,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                              ObjectSet(nameFibo,OBJPROP_BACK,mBackZones);
                             }
                          }
                       }
                    }
                 }
              }

            // создание метки при пересечении нулевого бара контрольными линиями LTL и/или UTL статичеких вил Эндрюса
            if (((ExtUTL>0 && mUTL>0) || (ExtLTL>0 && mLTL>0)) && i==0)
              {
               if (ExtUTL)
                 {
                  nameObj="UTL" + ExtComplekt+"_";
                  if (ObjectFind(nameObj)>=0)
                    {
                     cena1=ObjectGetValueByShift(nameObj,0);
                     if (mUTL==1)
                       {
                        nameObj=prefics+"UTL x 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                        if (writetofile)
                          {
                           FileSeek(handle, 0, SEEK_END);
                           FileWrite(handle, 0, 11, mUTL, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                            DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                          }
                       }
                     else if (mUTL>1)
                       {
                        retISL=(cena1 -(pitch_cena[2]+c1*tangensAP))/hAP;
                        if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; else ret=(cena1-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                        if (mUTL>4 && xISL>retISL) ret=xret;

                        rl1=0; rl2=0;
                        for (m=0;m<j1;m++)
                          {
                           if (arrRL[m]>=ret)
                             {
                              rl2=arrRL[m];
                              break;
                             }
                           else
                             {
                              rl1=arrRL[m];
                             }
                          }

                        if (rl2>0)
                          {
                           if (pitch_cena[1]>pitch_cena[2])
                             {
                              tangensUTL=(pitch_cena[1]-pitch_cena[0])/(a1-b1);
                              X=pitch_cena[1];
                             }
                           else
                             {
                              tangensUTL=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
                              X=pitch_cena[2];
                             }

                           cena1=X+bazaAP*rl1*tangensUTL*(tangensRL-tangensAP)/(tangensRL-tangensUTL);
                           x=ObjectGetShiftByValue(nameObj, cena1);
                           if (x>0) time1=iTime(Symbol(),Period(),x); else time1=iTime(Symbol(),Period(),0)-x*Period()*60;

                           cena2=X+bazaAP*rl2*tangensUTL*(tangensRL-tangensAP)/(tangensRL-tangensUTL);
                           x=ObjectGetShiftByValue(nameObj, cena2);
                           if (x>0) time2=iTime(Symbol(),Period(),x); else time2=iTime(Symbol(),Period(),0)-x*Period()*60;
                           if (writetofile)
                             {
                              FileSeek(handle, 0, SEEK_END);
                              FileWrite(handle, 0, 11, mUTL, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                               DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                             }

                           if (mUTL==2 || mUTL==4 || mUTL==5 || mUTL==7 || mUTL==9)
                             {
                              nameObj=prefics+"UTL left 0-bar";
                              ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                              ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                              ObjectSet(nameObj,OBJPROP_BACK,mBack);

                              nameObj=prefics+"UTL right 0-bar";
                              ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                              ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                              ObjectSet(nameObj,OBJPROP_BACK,mBack);
                             }

                           if (mUTL>7)
                             {
                              nameObj=prefics+"UTL line Zones";
                              ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                              ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                              ObjectSet(nameObj,OBJPROP_RAY,false); 
                              ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                             }
                           else if (mUTL>2 && mUTL!=5)
                             {
                              if (mUTL>5) nameObj=prefics+"Shift UTL Zones"; else nameObj=prefics+"UTL Zones";
                              ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                              ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                             }
                          }
                       }
                    }
                 }

               if (ExtLTL)
                 {
                  nameObj="LTL" + ExtComplekt+"_";
                  if (ObjectFind(nameObj)>=0)
                    {
                     cena1=ObjectGetValueByShift(nameObj,0);
                     if (mLTL==1)
                       {
                        nameObj=prefics+"LTL x 0-bar";
                        ObjectCreate(nameObj,OBJ_ARROW,0,iTime(NULL,Period(),0),cena1);
                        ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                        ObjectSet(nameObj,OBJPROP_BACK,mBack);
                        if (writetofile)
                          {
                           FileSeek(handle, 0, SEEK_END);
                           FileWrite(handle, 0, 12, mLTL, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                            DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                          }
                       }
                     else if (mLTL>1)
                       {
                        retISL=(cena1 -(pitch_cena[2]+c1*tangensAP))/hAP;
                        if (tangensAP==0) ret=(c1+retISL*(b1-c1))/bazaAP; else ret=(cena1-pitch_cena[2]-retISL*(hAP-(b1-c1)*tangensAP))/(tangensAP*bazaAP);

                        if (mLTL>4 && xISL>retISL) ret=xret;

                        rl1=0; rl2=0;
                        for (m=0;m<j1;m++)
                          {
                           if (arrRL[m]>=ret)
                             {
                              rl2=arrRL[m];
                              break;
                             }
                           else
                             {
                              rl1=arrRL[m];
                             }
                          }

                        if (rl2>0)
                          {
                           if (pitch_cena[2]>pitch_cena[1])
                             {
                              tangensLTL=(pitch_cena[1]-pitch_cena[0])/(a1-b1);
                              X=pitch_cena[1];
                             }
                           else
                             {
                              tangensLTL=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
                              X=pitch_cena[2];
                             }
                          }

                        cena1=X+bazaAP*rl1*tangensLTL*(tangensRL-tangensAP)/(tangensRL-tangensLTL);
                        x=ObjectGetShiftByValue(nameObj, cena1);
                        if (x>0) time1=iTime(Symbol(),Period(),x); else time1=iTime(Symbol(),Period(),0)-x*Period()*60;

                        cena2=X+bazaAP*rl2*tangensLTL*(tangensRL-tangensAP)/(tangensRL-tangensLTL);
                        x=ObjectGetShiftByValue(nameObj, cena2);
                        if (x>0) time2=iTime(Symbol(),Period(),x); else time2=iTime(Symbol(),Period(),0)-x*Period()*60;
                        if (writetofile)
                          {
                           FileSeek(handle, 0, SEEK_END);
                           FileWrite(handle, 0, 12, mLTL, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
                            DoubleToStr(pitch_cena[0], Digits), DoubleToStr(pitch_cena[1], Digits), DoubleToStr(pitch_cena[2], Digits));
                          }

                        if (mLTL==2 || mLTL==4 || mLTL==5 || mLTL==7 || mLTL==9)
                          {
                           nameObj=prefics+"LTL left 0-bar";
                           ObjectCreate(nameObj,OBJ_ARROW,0,time1,cena1);
                           ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
                           ObjectSet(nameObj,OBJPROP_BACK,mBack);

                           nameObj=prefics+"LTL right 0-bar";
                           ObjectCreate(nameObj,OBJ_ARROW,0,time2,cena2);
                           ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
                           ObjectSet(nameObj,OBJPROP_BACK,mBack);
                          }

                        if (mLTL>7)
                          {
                           nameObj=prefics+"LTL line Zones";
                           ObjectCreate(nameObj,OBJ_TREND,0,time1,cena1,time2,cena2);
                           ObjectSet(nameObj,OBJPROP_WIDTH,mLineZonesWidth); 
                           ObjectSet(nameObj,OBJPROP_RAY,false); 
                           ObjectSet(nameObj,OBJPROP_BACK,mBackZones); 
                          }
                        else if (mLTL>2 && mLTL!=5)
                          {
                           if (mLTL>5) nameObj=prefics+"Shift LTL Zones"; else nameObj=prefics+"LTL Zones";
                           ObjectCreate(nameObj,OBJ_RECTANGLE,0,time1,cena1,time2,cena2);
                           ObjectSet(nameObj,OBJPROP_BACK,mBackZones);
                          }
                       }
                    }
                 }
              }
           }
        }
     }
   else if(mSelectVariantsPRZ>0)
     {

      if (create)
        {
         checkAP (arrName);
//for(k=0;k<ArraySize(arrName);k++) Print(arrName[k]);
         if (ArraySize(arrName)==0) return;

         mAPs=false;
         mAPd=false;
         nameObj="";
         if (mTypeBasiclAP==0 && ExtPitchforkStatic==2)
           {
            if (ExtCustomStaticAP) nameObj="pitchforkS" + ExtComplekt+"_APm_"; else nameObj="pitchforkS" + ExtComplekt+"_";
            prefics="m#"+ExtComplekt+"_"+"s ";        //основа префикса
            str05median="pmedianaS";
           }
         else if (mTypeBasiclAP==1 && ExtPitchforkDinamic==2)
           {
            nameObj="pitchforkD" + ExtComplekt+"_"; 
            prefics="m#"+ExtComplekt+"_"+"d ";
            str05median="pmedianaD";
           }

         if (StringLen(nameObj)==0) return;

         // определяем время и цену точек, к которым привязаны базовые вилы Эндрюса
         pitch_time[0]=ObjectGet(nameObj,OBJPROP_TIME1); pitch_cena[0]=ObjectGet(nameObj,OBJPROP_PRICE1);
         pitch_time[1]=ObjectGet(nameObj,OBJPROP_TIME2); pitch_cena[1]=ObjectGet(nameObj,OBJPROP_PRICE2);
         pitch_time[2]=ObjectGet(nameObj,OBJPROP_TIME3); pitch_cena[2]=ObjectGet(nameObj,OBJPROP_PRICE3);
         
         str1=DoubleToStr(pitch_cena[0], Digits); str2=DoubleToStr(pitch_cena[1], Digits); str3=DoubleToStr(pitch_cena[2], Digits);
         // определяем номера баров, к которым привязаны базовые вилы Эндрюса
         a1=iBarShift(NULL,Period(),pitch_time[0],false);
         b1=iBarShift(NULL,Period(),pitch_time[1],false);
         c1=iBarShift(NULL,Period(),pitch_time[2],false);
         // тангенс угла наклона вил Эндрюса
         if ((a1-(c1+b1)/2.0)!=0) tangensAP=((pitch_cena[2]+pitch_cena[1])/2-pitch_cena[0])/(a1-(c1+b1)/2.0);
         // определяем расстояние по вертикали от SSL до FSL - база по высоте вил Эндрюса
         hAP=pitch_cena[1]+(b1-c1)*tangensAP-pitch_cena[2];

         // создание меток у точек привязки вил Эндрюса
         if (mPivotPoints)
           {
            nameObj=prefics+"point 1 AP";
            ObjectCreate(nameObj,OBJ_ARROW,0,pitch_time[0],pitch_cena[0]);
            ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
            ObjectSet(nameObj,OBJPROP_BACK,mBack);
            if (!mPivotPointsChangeColor)
              {
               if (pitch_cena[0]<pitch_cena[1] || pitch_cena[1]>pitch_cena[2]) updn=true; else updn=false;
               if (updn) ObjectSet(nameObj,OBJPROP_COLOR, mColorDN); else ObjectSet(nameObj,OBJPROP_COLOR, mColorUP);
              }

            nameObj=prefics+"point 2 AP";
            ObjectCreate(nameObj,OBJ_ARROW,0,pitch_time[1],pitch_cena[1]);
            ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
            ObjectSet(nameObj,OBJPROP_BACK,mBack);
            if (!mPivotPointsChangeColor)
              {
               if (updn) ObjectSet(nameObj,OBJPROP_COLOR, mColorUP); else ObjectSet(nameObj,OBJPROP_COLOR, mColorDN);
              }

            nameObj=prefics+"point 3 AP";
            ObjectCreate(nameObj,OBJ_ARROW,0,pitch_time[2],pitch_cena[2]);
            ObjectSet(nameObj,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
            ObjectSet(nameObj,OBJPROP_BACK,mBack);
            if (!mPivotPointsChangeColor)
              {
               if (updn) ObjectSet(nameObj,OBJPROP_COLOR, mColorDN); else ObjectSet(nameObj,OBJPROP_COLOR, mColorUP);
              }
           }
/*
mSelectVariantsPRZ
 = 1 - метки пересечения SSL
 = 2 - метки пересечения медианы
 = 3 - метки пересечения FSL
 = 4 - зона пересечения канала медианы
 = 5 - зона пересечения канала вил 
 = 6 - метки пересечения 1/2 медианы
 = 7 - зона пересечения канала 1/2 медианы
 = 8 - зона пересечения канала линий Шиффа
 = 9 - метки пересечения UTL
*/
         if (mSelectVariantsPRZ<6)
           {
            if (mSelectVariantsPRZ==1)       // метки пересечения SSL
              {
               externalAP (c1, pitch_cena[2], 0, 0, tangensAP, prefics+"SSL x ", "", "", arrName, handle, str1 , str2, str3);
              }
            else if (mSelectVariantsPRZ==2)  // метки пересечения медианы
              {
               externalAP (a1, pitch_cena[0], 0, 0, tangensAP, prefics+"Mediana x ", "", "", arrName, handle, str1 , str2, str3);
              }
            else if (mSelectVariantsPRZ==3) // метки пересечения FSL
              {
               externalAP (b1, pitch_cena[1], 0, 0, tangensAP, prefics+"FSL x ", "", "", arrName, handle, str1 , str2, str3);
              }
            else if (mSelectVariantsPRZ==4) // зона пересечения канала медианы
              {
               externalAP (b1, pitch_cena[1]-hAP*(2-phi), b1, pitch_cena[1]-hAP*(phi-1), tangensAP, prefics+"ISL 38.2 x ", prefics+"ISL 61.8 x ", prefics+"channal Mediana x ", arrName, handle, str1 , str2, str3);
              }
            else if (mSelectVariantsPRZ==5) // зона пересечения канала вил
              {
               externalAP (b1, pitch_cena[1], c1, pitch_cena[2], tangensAP, prefics+"SSL x ", prefics+"FSL x ", prefics+"channal AP x ", arrName, handle, str1 , str2, str3);
              }
           }
         else if (mSelectVariantsPRZ>5 && mSelectVariantsPRZ<9)
           {
            // тангенс угла наклона 1/2 медианы вил Эндрюса
            tangens05median=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
            // определяем расстояние по вертикали от SSL до FSL - база по высоте вил линий Шиффа
            hAP1_2mediana=pitch_cena[1]-(pitch_cena[2]-tangens05median*(b1-c1));
            cena2=pitch_cena[1]-hAP1_2mediana/2;

            if (mSelectVariantsPRZ==6)       // метки пересечения 1/2 медианы
              {
               externalAP (b1, cena2, 0, 0, tangens05median, prefics+"50% Mediana x ", "", "", arrName, handle, str1 , str2, str3);
              }
            else if (mSelectVariantsPRZ==7)  // зона пересечения канала 1/2 медианы
              {
               externalAP (b1, pitch_cena[1]-hAP1_2mediana*(phi-1), b1, pitch_cena[1]-hAP1_2mediana*(2-phi), tangens05median, prefics+"SLM 38.2 x ", prefics+"SLM 61.8 x ", prefics+"channal 50% Mediana x ", arrName, handle, str1 , str2, str3);
              }
            else if (mSelectVariantsPRZ==8)  // зона пересечения канала линий Шиффа
              {
               externalAP (b1, pitch_cena[1], c1, pitch_cena[2], tangens05median, prefics+"SSL Shiff Line x ", prefics+"FSL Shiff Line x ", prefics+"channal Shiff Line x ", arrName, handle, str1 , str2, str3);
              }
           }
         else if (mSelectVariantsPRZ==9)
           {
            if (ExtLTL) // метки пересечения LTL
              {
               if (pitch_cena[2]>pitch_cena[1])
                 {
                  tangensLTL=(pitch_cena[1]-pitch_cena[0])/(a1-b1);
                  externalAP (b1, pitch_cena[1], 0, 0, tangensLTL, prefics+"LTL x ", "", "", arrName, handle, str1 , str2, str3);
                 }
               else
                 {
                  tangensLTL=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
                  externalAP (c1, pitch_cena[2], 0, 0, tangensLTL, prefics+"LTL x ", "", "", arrName, handle, str1 , str2, str3);
                 }
              }

            if (ExtUTL) // метки пересечения UTL
              {
               if (pitch_cena[1]>pitch_cena[2])
                 {
                  tangensUTL=(pitch_cena[1]-pitch_cena[0])/(a1-b1);
                  externalAP (b1, pitch_cena[1], 0, 0, tangensUTL, prefics+"UTL x ", "", "", arrName, handle, str1 , str2, str3);
                 }
               else
                 {
                  tangensUTL=(pitch_cena[2]-pitch_cena[0])/(a1-c1);
                  externalAP (c1, pitch_cena[2], 0, 0, tangensUTL, prefics+"UTL x ", "", "", arrName, handle, str1 , str2, str3);
                 }
              }
           }
        }
     }

   if (create)
     {
      // закрываем файл для записи меток
      if (mWriteToFile)
        {
         writetofile=false;
         mPeriod=mPeriod+mPeriodWriteToFile*60;
         FileClose(handle);
        }
     }

   // задание цвета меток
   prefics="m#"+ExtComplekt+"_";
   for (k=ObjectsTotal()-1;k>=0;k--)
     {
      nameObj=ObjectName(k);
      if (StringFind(nameObj,prefics)>-1)
        {
         if (ObjectType(nameObj)==OBJ_ARROW)
           {
            cena1=ObjectGet(nameObj,OBJPROP_PRICE1);
            if (iClose(NULL,Period(),0)<cena1) mclr=mColorUP;
            else if (iClose(NULL,Period(),0)>cena1) mclr=mColorDN;
            else mclr=mColor;
           }
         else if (ObjectType(nameObj)==OBJ_RECTANGLE || ObjectType(nameObj)==OBJ_TREND)
           {
            cena1=ObjectGet(nameObj,OBJPROP_PRICE1);
            cena2=ObjectGet(nameObj,OBJPROP_PRICE2);
            if (iClose(NULL,Period(),0)<cena1 && iClose(NULL,Period(),0)<cena2) mclr=mColorRectangleUP;
            else if (iClose(NULL,Period(),0)>cena1 && iClose(NULL,Period(),0)>cena2) mclr=mColorRectangleDN;
            else mclr=mColor;
           }
         if (!mPivotPointsChangeColor)
           {
            if (StringFind(nameObj,prefics+"s"+" point")>-1 || StringFind(nameObj,prefics+"d"+" point")>-1) continue;
           }
         ObjectSet(nameObj,OBJPROP_COLOR,mclr);
        }
     }

   WindowRedraw();
  }
//--------------------------------------------------------
// Вывод ценовых меток (metkaAP) в вилах Эндрюса. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Подготовка параметров внешних вил 
// Начало.
//--------------------------------------------------------
/*
a1 - номер бара начала линии 1
cenaA1 - цена на линии 1 на баре a1
a2 - номер бара начала линии 2
cenaA2 - цена на линии 2 на баре a2
tangensA - тангенс угла наклона линий базовых вил
nameMetki1 - наименование метки 1
nameMetki2 - наименование метки 2
nameZones - наименование зоны
aName[] - массив с наименованиями внешних вил

Если выводится метка, то в данные правой метки и наименование зоны записываем 0 или "" для строковой переменной

int    mSSL
int    mISL382
int    mMediana
int    mISL618
int    mFSL
int    mUWL
int    mLWL

int    m1_2Mediana
int    mSLM
int    mFSLShiffLines

int    mUTL
int    mLTL

*/

void externalAP (int a1, double cenaA1, int b1, double cenaB1, double tangensA, string nameMetki1, string nameMetki2, string nameZones, string aName[], int handle, string str1 , string str2, string str3)
  {
   int      i, j, k, x, y, z , wr, znak;
//   double   cwr;
   int      a2, b2, c2;                 // номера баров привязки внешних вил
   double   cPitch[3];                  // цена в точках привязки внешних вил
   datetime tPitch[3];                  // время в точках привязки внешних вил
   color    PitchColor;                 // цвет внешних вил, построенных вручную
   double   cena1, cena2, cena3;        // цена в точках привязки инструментов вил, построенных вручную
   datetime time1, time2, time3;        // время в точках привязки инструментов вил, построенных вручную
   datetime twr;
   double   tangensAP, tangens05median; // тангенсы углов наклона внешних вил.
   double   hAP, hAP1_2mediana;         // 
   bool     typeAP;     //  = - false вилы созданы с помощью ZUP, = true - вилы созданы вручную
   string   suffics, sufficsWL, suffics_APm, sufficsWL_APm;    // идентификатор принадлежности инструментов вил одному комплекту.
   string   txt;
   string   nameObjAP;  // наименования инструментов вил, построенных вручную
   string   nameObj_;   // название ююю
   bool     canal=true; // флаг вывода меток для линии от базовых вил или от канала, образованного инструментами базовых вил
   string   str;
   double   fi;

   if (StringLen(nameZones)==0) canal=false;

   for (i=ArraySize(aName)-1;i>=0;i--)
     {
      typeAP=false;
      if (StringFind(aName[i],"Andrews Pitchfork",0)>=0) typeAP=true;
      
      if (typeAP && mExternalHandAP==1) PitchColor=ObjectGet(aName[i],OBJPROP_COLOR);

      // определяем идентификатор принадлежности инструментов вил одному комплекту.
      suffics="";
      sufficsWL="";

      if (StringFind(aName[i],"Andrews Pitchfork",0)>=0)
        {
         suffics=StringSubstr(aName[i],17);
        }
      else
        {
         j=StringFind(aName[i],"_",0);
         suffics=StringSubstr(aName[i],9);
         sufficsWL=StringSubstr(aName[i],10);
         if (StringSubstr(aName[i],9,1)=="S")
           {
            if (StringSubstr(aName[i],j+1,3)=="APm")
              {
               if (j+5<StringLen(aName[i]))
                 {
                  sufficsWL=StrToInteger(StringSubstr(aName[i],10,j-10))+"_"+StringSubstr(aName[i],j+5);
                  suffics="S"+sufficsWL;
                 }
              }
           }
        }
      suffics_APm=suffics;
      sufficsWL_APm=sufficsWL;
      if (StringFind(suffics,"_APm",0)>0)
        {
         suffics_APm=StringSubstr(suffics,0,StringFind(suffics,"APm",0));
         sufficsWL_APm=StringSubstr(sufficsWL,0,StringFind(sufficsWL,"APm",0));
        }

      // определяем время и цену точек, к которым привязаны внешние вилы Эндрюса
      tPitch[0]=ObjectGet(aName[i],OBJPROP_TIME1); cPitch[0]=ObjectGet(aName[i],OBJPROP_PRICE1);
      tPitch[1]=ObjectGet(aName[i],OBJPROP_TIME2); cPitch[1]=ObjectGet(aName[i],OBJPROP_PRICE2);
      tPitch[2]=ObjectGet(aName[i],OBJPROP_TIME3); cPitch[2]=ObjectGet(aName[i],OBJPROP_PRICE3);
      // определяем номера баров, к которым привязаны вилы Эндрюса
      if (typeAP)
        {
         twr=iTime(Symbol(),Period(),0);
         if (tPitch[0]<=twr) a2=iBarShift(NULL,Period(),tPitch[0],false); else a2=-(tPitch[0]-twr)/(Period()*60);
         if (tPitch[1]<=twr) b2=iBarShift(NULL,Period(),tPitch[1],false); else b2=-(tPitch[1]-twr)/(Period()*60);
         if (tPitch[2]<=twr) c2=iBarShift(NULL,Period(),tPitch[2],false); else c2=-(tPitch[2]-twr)/(Period()*60);
        }
      else
        {
         a2=iBarShift(NULL,Period(),tPitch[0],false);
         b2=iBarShift(NULL,Period(),tPitch[1],false);
         c2=iBarShift(NULL,Period(),tPitch[2],false);
        }

      // тангенс угла наклона вил Эндрюса
      tangensAP=0;
      if ((a2-(c2+b2)/2.0)!=0) tangensAP=((cPitch[2]+cPitch[1])/2-cPitch[0])/(a2-(c2+b2)/2.0);

      // определяем расстояние по вертикали от SSL до FSL - база по высоте вил Эндрюса
      hAP=cPitch[1]+(b2-c2)*tangensAP-cPitch[2];

      if (m1_2Mediana>0 || mSLM>0)
        {
         // тангенс угла наклона 1/2 медианы вил Эндрюса
         tangens05median=(cPitch[2]-cPitch[0])/(a2-c2);
         // определяем расстояние по вертикали от SSL до FSL - база по высоте вил линий Шиффа
         hAP1_2mediana=cPitch[1]-(cPitch[2]-tangens05median*(b2-c2));
        }

      if (mSSL>0)
        {
         txt=" SSL "+suffics;
         visual (a1, cenaA1, b1, cenaB1, tangensA, c2, cPitch[2], tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mSSL, handle, 1, str1 , str2, str3);
        }

      if (mISL382>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            _ISL("ISL_", tPitch, cPitch, PitchColor, STYLE_DASH, 2, suffics);
           }

         if ((typeAP && mExternalHandAP>0) || !typeAP)
           {
            txt=" ISL 38.2 "+suffics;
            visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1]-hAP*(phi-1), tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mISL382, handle, 5, str1 , str2, str3);
           }
        }

      if (mMediana>0)
        {
         txt=" Mediana "+suffics;
         visual (a1, cenaA1, b1, cenaB1, tangensA, a2, cPitch[0], tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mMediana, handle, 6, str1 , str2, str3);
        }

      if (mISL618>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            _ISL("ISL_", tPitch, cPitch, PitchColor, STYLE_DASH, 2, suffics);
           }

         if ((typeAP && mExternalHandAP>0) || !typeAP)
           {
            txt=" ISL 61.8 "+suffics;
            visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1]-hAP*(2-phi), tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mISL618, handle, 7, str1 , str2, str3);
           }
        }

      if (mFSL>0)
        {
         txt=" FSL "+suffics;
         visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1], tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mFSL, handle, 8, str1 , str2, str3);
        }

      if (mUWL>0 || mLWL>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            cena1=cPitch[0];
            time1=tPitch[0];
            time2=iTime(Symbol(),Period(),0);
            cena2=cPitch[0]-tangensAP*a2;

            ML_RL400(-tangensAP, cPitch, tPitch, time2, cena2, false);

            if (mUWL>0)
              {
               nameObjAP="UWL"+ ExtComplekt+"_" + suffics;
               if (cPitch[1]>cPitch[2])
                 {
                  time3=tPitch[1];
                  cena3=cPitch[1];
                 }
               else
                 {
                  time3=tPitch[2];
                  cena3=cPitch[2];
                 }

               ObjectDelete(nameObjAP);

               ObjectCreate(nameObjAP,OBJ_FIBOCHANNEL,0,time1,cena1,time2,cena2,time3,cena3);
               ObjectSet(nameObjAP,OBJPROP_LEVELCOLOR,PitchColor);
               ObjectSet(nameObjAP,OBJPROP_LEVELSTYLE,STYLE_DOT);
               ObjectSet(nameObjAP,OBJPROP_RAY,ExtLongWL);
               ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);
               ObjectSet(nameObjAP,OBJPROP_COLOR,CLR_NONE);

               UWL_LWL (ExtVisibleUWL,nameObjAP,"UWL ",ExtFiboFreeUWL);
              }

            if (mLWL>0)
              {
               nameObjAP="LWL"+ ExtComplekt+"_" + suffics;
               if (cPitch[1]>=cPitch[2])
                 {
                  time3=tPitch[2];
                  cena3=cPitch[2];
                 }
               else
                 {
                  time3=tPitch[1];
                  cena3=cPitch[1];
                 }

               ObjectDelete(nameObjAP);

               ObjectCreate(nameObjAP,OBJ_FIBOCHANNEL,0,time1,cena1,time2,cena2,time3,cena3);
               ObjectSet(nameObjAP,OBJPROP_LEVELCOLOR,PitchColor);
               ObjectSet(nameObjAP,OBJPROP_LEVELSTYLE,STYLE_DOT);
               ObjectSet(nameObjAP,OBJPROP_RAY,ExtLongWL);
               ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);
               ObjectSet(nameObjAP,OBJPROP_COLOR,CLR_NONE);

               UWL_LWL (ExtVisibleLWL,nameObjAP,"LWL ",ExtFiboFreeLWL);
              }
           }

         if (mUWL>0)
           {
            if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("UWL" + sufficsWL_APm)==0))
              {
               if (!typeAP) nameObj_="UWL" + sufficsWL_APm;
               else if (typeAP && mExternalHandAP>0) nameObj_="UWL"+ ExtComplekt+"_" + suffics;

               if (cPitch[1]>cPitch[2])
                 {
                  y=b2;
                  cena3=cPitch[1];
                 }
               else
                 {
                  y=c2;
                  cena3=cPitch[2];
                 }

               if (ObjectFind(nameObj_)>=0)
                 {
                  x=ObjectGet(nameObj_,OBJPROP_FIBOLEVELS);
                  for (k=0;k<x;k++)
                    {
                     txt=" UWL " + DoubleToStr(ObjectGet(nameObj_,OBJPROP_FIRSTLEVEL+k),3) + suffics;
                     visual (a1, cenaA1, b1, cenaB1, tangensA, y, cena3+MathAbs(hAP)*ObjectGet(nameObj_,OBJPROP_FIRSTLEVEL+k)/2,
                      tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mUWL, handle, 13, str1 , str2, str3);
                    }
                 }
               else
                 {
                  if (ExtFiboType==2)
                    {
                     x=quantityFibo (ExtFiboFreeUWL);
                     str=ExtFiboFreeUWL;
                    }
                  else
                    {
                     x=11;
                     str="0.146,0.236,0.382,0.5,0.618,0.764,0.854,1,1.618,2.0,2.618,4.236";
                    }

                  for (k=0;k<=x;k++)
                    {
                     z=StringFind(str, ",", 0);
                     fi=StrToDouble(StringTrimLeft(StringTrimRight(StringSubstr(str,0,z))));

                     txt=" UWL " + DoubleToStr(fi,3) + suffics;
                     visual (a1, cenaA1, b1, cenaB1, tangensA, y, cena3+MathAbs(hAP)*fi/2, tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mUWL, handle, 13, str1 , str2, str3);

                     if (z>=0) str=StringSubstr(str,z+1);
                    }
                 }
              }
           }

         if (mLWL>0)
           {
            if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("LWL" + sufficsWL_APm)==0))
              {
               if (!typeAP) nameObj_="LWL" + sufficsWL_APm;
               else if (typeAP && mExternalHandAP>0) nameObj_="LWL"+ ExtComplekt+"_" + suffics;

               if (cPitch[1]>cPitch[2])
                 {
                  y=c2;
                  cena3=cPitch[2];
                 }
               else
                 {
                  y=b2;
                  cena3=cPitch[1];
                 }

               if (ObjectFind(nameObj_)>=0)
                 {
                  x=ObjectGet(nameObj_,OBJPROP_FIBOLEVELS);
                  for (k=0;k<x;k++)
                    {
                     txt=" LWL " + DoubleToStr(ObjectGet(nameObj_,OBJPROP_FIRSTLEVEL+k),3) + suffics;
                     visual (a1, cenaA1, b1, cenaB1, tangensA, y, cena3-MathAbs(hAP)*ObjectGet(nameObj_,OBJPROP_FIRSTLEVEL+k)/2,
                      tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mLWL, handle, 14, str1 , str2, str3);
                    }
                 }
               else
                 {
                  if (ExtFiboType==2)
                    {
                     x=quantityFibo (ExtFiboFreeLWL);
                     str=ExtFiboFreeLWL;
                    }
                  else
                    {
                     x=11;
                     str="0.146,0.236,0.382,0.5,0.618,0.764,0.854,1,1.618,2.0,2.618,4.236";
                    }

                  for (k=0;k<=x;k++)
                    {
                     z=StringFind(str, ",", 0);
                     fi=StrToDouble(StringTrimLeft(StringTrimRight(StringSubstr(str,0,z))));

                     txt=" LWL " + DoubleToStr(fi,3) + suffics;
                     visual (a1, cenaA1, b1, cenaB1, tangensA, y, cena3-MathAbs(hAP)*fi/2, tangensAP, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mLWL, handle, 14, str1 , str2, str3);

                     if (z>=0) str=StringSubstr(str,z+1);
                    }
                 }
              }
           }
        }

      if (m1_2Mediana>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            coordinaty_1_2_mediany_AP(cPitch[0], cPitch[1], cPitch[2], tPitch[0], tPitch[1], tPitch[2], time1, time2, cena1, cena2, 2, 0);

            nameObjAP="pmediana_" + ExtComplekt+"_" + suffics;

            ObjectDelete(nameObjAP);
            ObjectCreate(nameObjAP,OBJ_TREND,0,time1,cena1,time2,cena2);
            ObjectSet(nameObjAP,OBJPROP_STYLE,STYLE_DASH);
            ObjectSet(nameObjAP,OBJPROP_COLOR,PitchColor);
            ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
           }

         if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("pmediana"+suffics_APm)==0))
           {
            txt=" 50% Mediana "+suffics;
            visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1]-hAP1_2mediana/2, tangens05median, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, m1_2Mediana, handle, 3, str1 , str2, str3);
           }
        }

      if (mSLM>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            if (a2>c2) znak=1;
            else if (a2==c2) znak=0;
            else znak=-1;

            // вывод SLM 38.2
            wr=c2+(b2-c2)*(2-phi);
            cena1=cPitch[1] + (b2-c2)*(phi-1)*tangens05median-hAP1_2mediana*(phi-1);
            if (wr>=0)
              {
               time1=iTime(Symbol(),Period(),wr);
               cena2=cena1+znak*wr*tangens05median;
               if (znak>0) time2=iTime(Symbol(),Period(),0);
               else if (znak<0) time2=iTime(Symbol(),Period(),2*wr);
              }
            else
              {
               time1=iTime(Symbol(),Period(),0)-wr*Period()*60;
               if (znak!=0) cena2=cena1+znak*10*tangens05median;
               else
                 {
                  if (tangens05median>0) cena2=cena1*1.1;
                  else cena2=cena1*0.9;
                 }
               time2=iTime(Symbol(),Period(),0)-(wr-znak*10)*Period()*60;
              }

            nameObjAP="SLM382_" + ExtComplekt+"_" + suffics;
            ObjectDelete(nameObjAP);
            ObjectCreate(nameObjAP,OBJ_TREND,0,time1,cena1,time2,cena2);
            ObjectSet(nameObjAP,OBJPROP_STYLE,STYLE_DASH);
            ObjectSet(nameObjAP,OBJPROP_COLOR,PitchColor);
            ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);

            // вывод SLM 68.8
            wr=c2+(b2-c2)*(phi-1);
            cena1=cPitch[1] + (b2-c2)*(2-phi)*tangens05median-hAP1_2mediana*(2-phi);
            if (wr>=0)
              {
               time1=iTime(Symbol(),Period(),wr);
               cena2=cena1+znak*wr*tangens05median;
               if (znak>0) time2=iTime(Symbol(),Period(),0);
               else if (znak<0) time2=iTime(Symbol(),Period(),2*wr);
              }
            else
              {
               time1=iTime(Symbol(),Period(),0)-wr*Period()*60;
               if (znak!=0) cena2=cena1+znak*10*tangens05median;
               else
                 {
                  if (tangens05median>0) cena2=cena1*1.1;
                  else cena2=cena1*0.9;
                 }
               time2=iTime(Symbol(),Period(),0)-(wr-znak*10)*Period()*60;
              }
            nameObjAP="SLM618_" + ExtComplekt+"_" + suffics;
            ObjectDelete(nameObjAP);
            ObjectCreate(nameObjAP,OBJ_TREND,0,time1,cena1,time2,cena2);
            ObjectSet(nameObjAP,OBJPROP_STYLE,STYLE_DASH);
            ObjectSet(nameObjAP,OBJPROP_COLOR,PitchColor);
            ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);
           }

         if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("SLM382"+suffics_APm)==0))
           {
            txt=" SLM 38.2 "+suffics;
            visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1]-hAP1_2mediana*(phi-1), tangens05median, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mSLM, handle, 2, str1 , str2, str3);
           }

         if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("SLM618"+suffics_APm)==0))
           {
            txt=" SLM 61.8 "+suffics;
            visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1]-hAP1_2mediana*(2-phi), tangens05median, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mSLM, handle, 4, str1 , str2, str3);
           }
        }

      if (mFSLShiffLines>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            if (a2>c2) znak=1;
            else if (a2==c2) znak=0;
            else znak=-1;

            // вывод FSL Shiff Lines
            wr=c2+b2-c2;
            cena1=cPitch[1];
            if (wr>=0)
              {
               time1=tPitch[1];
               cena2=cena1+znak*wr*tangens05median;
               if (znak>0) time2=iTime(Symbol(),Period(),0);
               else if (znak<0) time2=iTime(Symbol(),Period(),2*wr);
              }
            else
              {
               time1=iTime(Symbol(),Period(),0)-wr*Period()*60;
               if (znak!=0) cena2=cena1+znak*10*tangens05median;
               else
                 {
                  if (tangens05median>0) cena2=cena1*1.1;
                  else cena2=cena1*0.9;
                 }
               time2=iTime(Symbol(),Period(),0)-(wr-znak*10)*Period()*60;
              }

            nameObjAP="FSL Shiff Lines_" + ExtComplekt+"_" + suffics;
            ObjectDelete(nameObjAP);
            ObjectCreate(nameObjAP,OBJ_TREND,0,time1,cena1,time2,cena2);
            ObjectSet(nameObjAP,OBJPROP_STYLE,STYLE_DASH);
            ObjectSet(nameObjAP,OBJPROP_COLOR,PitchColor);
            ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);
           }

         if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("FSL Shiff Lines "+suffics_APm)==0))
           {
            txt=" FSL Shiff Lines "+suffics;
            visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1], tangens05median, nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mFSLShiffLines, handle, 9, str1 , str2, str3);
           }
        }

      if (mUTL>0 || mLTL>0)
        {
         if (typeAP && mExternalHandAP==1)
           {
            time1=tPitch[0];
            cena1=cPitch[0];
            if (mUTL>0)
              {
               nameObjAP="UTL" + ExtComplekt+"_" + suffics;
               if (cPitch[1]>cPitch[2])
                 {
                  time2=tPitch[1];
                  cena2=cPitch[1];
                 }
               else
                 {
                  time2=tPitch[2];
                  cena2=cPitch[2];
                 }
               ObjectDelete(nameObjAP);
               ObjectCreate(nameObjAP,OBJ_TREND,0,time1,cena1,time2,cena2);
               ObjectSet(nameObjAP,OBJPROP_STYLE,STYLE_DASH);
               ObjectSet(nameObjAP,OBJPROP_COLOR,PitchColor);
               ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);
              }

            if (mLTL>0)
              {
               nameObjAP="LTL" + ExtComplekt+"_" + suffics;
               if (cPitch[1]>=cPitch[2])
                 {
                  time2=tPitch[2];
                  cena2=cPitch[2];
                 }
               else
                 {
                  time2=tPitch[1];
                  cena2=cPitch[1];
                 }
               ObjectDelete(nameObjAP);
               ObjectCreate(nameObjAP,OBJ_TREND,0,time1,cena1,time2,cena2);
               ObjectSet(nameObjAP,OBJPROP_STYLE,STYLE_DASH);
               ObjectSet(nameObjAP,OBJPROP_COLOR,PitchColor);
               ObjectSet(nameObjAP,OBJPROP_BACK,ExtBack);
              }
           }

         if (mUTL>0)
           {
            if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("UTL"+sufficsWL_APm)==0))
              {
               txt=" UTL "+suffics;
               if (cPitch[1]>cPitch[2])
                 {
                  visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1], (cPitch[1]-cPitch[0])/(a2-b2), nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mUTL, handle, 11, str1 , str2, str3);
                 }
               else
                 {
                  visual (a1, cenaA1, b1, cenaB1, tangensA, c2, cPitch[2], (cPitch[2]-cPitch[0])/(a2-c2), nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mUTL, handle, 11, str1 , str2, str3);
                 }
              }
           }

         if (mLTL>0)
           {
            if ((typeAP && mExternalHandAP>0) || (!typeAP && ObjectFind("LTL"+sufficsWL_APm)==0))
              {
               txt=" LTL "+suffics;
               if (cPitch[2]>cPitch[1])
                 {
                  visual (a1, cenaA1, b1, cenaB1, tangensA, b2, cPitch[1], (cPitch[1]-cPitch[0])/(a2-b2), nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mLTL, handle, 12, str1 , str2, str3);
                 }
               else
                 {
                  visual (a1, cenaA1, b1, cenaB1, tangensA, c2, cPitch[2], (cPitch[2]-cPitch[0])/(a2-c2), nameMetki1+txt, nameMetki2+txt, nameZones+txt, canal, mLTL, handle, 12, str1 , str2, str3);
                 }
              }
           }
        }
     }
  }
//--------------------------------------------------------
// Подготовка параметров внешних вил 
// Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод ценовых меток на график.                  
// Начало.
//--------------------------------------------------------
void visual (int a1, double cenaA1, int a2, double cenaA2, double tgA, int b, double cenaB, double tgB, string m1, string m2, string Zones, bool canal, int metka, int handle, int name, string str1 , string str2, string str3)
  {
   int x, x1;
   double   cena1, cena2;
   datetime tcena1, tcena2;
   string nameObj_;
   int st_din=mTypeBasiclAP;

   x=(cenaA1-cenaB+tgA*a1-tgB*b)/(tgA-tgB);
   if (x>a1 && !mVisibleST) return;

   if (canal)
     {
      x1=(cenaA2-cenaB+tgA*a2-tgB*b)/(tgA-tgB);
      cena2=cenaA2+(a2-x1)*tgA;
      if (x1>=0) tcena2=iTime(Symbol(),Period(),x1); else tcena2=iTime(Symbol(),Period(),0)-x1*Period()*60;
     }
   cena1=cenaA1+(a1-x)*tgA;
   if (x>=0) tcena1=iTime(Symbol(),Period(),x); else tcena1=iTime(Symbol(),Period(),0)-x*Period()*60;

   if (canal)
     {
      if (handle>=0)
        {
         FileSeek(handle, 0, SEEK_END);
         FileWrite(handle, mSelectVariantsPRZ, name, metka, DoubleToStr(cena1, Digits), 0, DoubleToStr(cena2, Digits), DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
          str1, str2, str3);
        }

      if (metka==5 || metka==7 || metka==9)
        {
         nameObj_=m1;
         ObjectCreate(nameObj_,OBJ_ARROW,0,tcena1,cena1);
         if (tcena1<tcena2) ObjectSet(nameObj_,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE); else ObjectSet(nameObj_,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
         ObjectSet(nameObj_,OBJPROP_BACK,mBack);

         nameObj_=m2;
         ObjectCreate(nameObj_,OBJ_ARROW,0,tcena2,cena2);
         if (tcena1<tcena2) ObjectSet(nameObj_,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE); else ObjectSet(nameObj_,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
         ObjectSet(nameObj_,OBJPROP_BACK,mBack);
        }

      if (metka>7)
        {
         nameObj_=Zones;
         ObjectCreate(nameObj_,OBJ_TREND,0,tcena1,cena1,tcena2,cena2);
         ObjectSet(nameObj_,OBJPROP_WIDTH,mLineZonesWidth); 
         ObjectSet(nameObj_,OBJPROP_RAY,false); 
         ObjectSet(nameObj_,OBJPROP_BACK,mBackZones); 
        }
      else if (metka>5)
        {
         if (metka>5) nameObj_=Zones;
         ObjectCreate(nameObj_,OBJ_RECTANGLE,0,tcena1,cena1,tcena2,cena2);
         ObjectSet(nameObj_,OBJPROP_BACK,mBackZones);
        }
     }
   else
     {
      nameObj_=m1;
      ObjectCreate(nameObj_,OBJ_ARROW,0,tcena1,cena1);
      ObjectSet(nameObj_,OBJPROP_ARROWCODE,SYMBOL_RIGHTPRICE);
      ObjectSet(nameObj_,OBJPROP_BACK,mBack);

      if (handle>=0)
        {
         FileSeek(handle, 0, SEEK_END);
         FileWrite(handle, mSelectVariantsPRZ, name, metka, 0, DoubleToStr(cena1, Digits), 0, DoubleToStr(iClose(NULL,Period(),0), Digits), st_din,
           str1, str2, str3);
        }
     }

  }
//--------------------------------------------------------
// Вывод ценовых меток на график.                  
// Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Проверка наличия внешних вил для расчета меток пересечения вил
// и сохранение названий внешних вил в массив. 
// Начало.
//--------------------------------------------------------
void checkAP (string& aName[]) //arrName[]
  {
   int i, j, k;
   string name;
/*
mTypeExternalAP - выбор типа внешних вил 
 = 0 - динамические или статические вилы текущего комплекта (противоположные базовым)
 = 1 - сохраненные вилы из текущего комплекта
 = 2 - любые вилы из текущего комплекта
 = 3 - статические вилы из других комплектов ZUP с текущего графика
 = 4 - динамические вилы из других комплектов ZUP с текущего графика
 = 5 - любые вилы из других комплектов ZUP с текущего графика
 = 6 - вилы с текущего графика, выведенные вручную, не с помощью ZUP
 = 7 - любые внешние вилы

mTypeBasiclAP - выбор типа базовых вил
 = 0 - статические вилы из текущего комплекта
 = 1 - динамические вилы из текущего комплекта
*/
// mSelectVariantsPRZ ExtMasterPitchfork       nameObjAPMaster="Master_"+nameObj;

   j=ObjectsTotal();
   SlavePitchfork = false;
   if (ExtMasterPitchfork==0)
     {
      k=0;
      for (i=0; i<j; i++)
        {
         name=ObjectName(i);
         if (ObjectType(name)==OBJ_PITCHFORK)
           {
            if (StringFind(name,"Master_",0)>=0)
             {
              k++;
              ArrayResize(aName,k);
              aName[k-1]=StringSubstr(name,7);
              SlavePitchfork = true;
              return;
             }
           }
        }
     }

   k=0;
   if (mTypeExternalAP==0)       // динамические или статические вилы текущего комплекта (противоположные базовым)
     {
      if (mTypeBasiclAP==0)      // динамические вилы текущего комплекта
        {
         name="pitchforkD" + ExtComplekt+"_";
         if (ObjectFind(name)==0)
           {
            ArrayResize(aName,1);
            aName[0]=name;
           }
        }
      else if (mTypeBasiclAP==1) // статические вилы текущего комплекта
        {
         name="pitchforkS" + ExtComplekt+"_";
         if (ObjectFind(name)==0)
           {
            ArrayResize(aName,1);
            aName[0]=name;
           }
         else
           {
            name="pitchforkS" + ExtComplekt+"_"+"_APm_";
            if (ObjectFind(name)==0)
              {
               ArrayResize(aName,1);
               aName[0]=name;
              }
           }
        }
     }
   else if (mTypeExternalAP==1)  // сохраненные вилы из текущего комплекта
     {
      for (i=0; i<j; i++)
        {
         name=ObjectName(i);
         if (ObjectType(name)==OBJ_PITCHFORK)
           {
            if (StringFind(name,"pitchforkS" + ExtComplekt+"_",0)>=0 && StringLen(name)>StringLen("pitchforkS" + ExtComplekt+"_")+4)
             {
              k++;
              ArrayResize(aName,k);
              aName[k-1]=name;
             }
           }
        }
     }
   else if (mTypeExternalAP==2)  // любые вилы из текущего комплекта
     {
      if (mTypeBasiclAP==0)
        {
         for (i=0; i<j; i++)
           {
            name=ObjectName(i);
            if (ObjectType(name)==OBJ_PITCHFORK)
              {
               if (StringFind(name,"pitchforkS" + ExtComplekt+"_",0)>=0 && StringLen(name)>StringLen("pitchforkS" + ExtComplekt+"_")+4)
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }
              }
           }
         name="pitchforkD" + ExtComplekt+"_";
         if (ObjectFind(name)==0)
           {
            k++;
            ArrayResize(aName,k);
            aName[k-1]=name;
           }
        }
      else if (mTypeBasiclAP==1)
        {
         for (i=0; i<j; i++)
           {
            name=ObjectName(i);
            if (ObjectType(name)==OBJ_PITCHFORK)
              {
               if (StringFind(name,"pitchforkS" + ExtComplekt+"_",0)>=0)
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }
              }
           }
        }
     }
   else if (mTypeExternalAP==3)  // статические вилы из других комплектов ZUP с текущего графика
     {
      for (i=0; i<j; i++)
        {
         name=ObjectName(i);
         if (ObjectType(name)==OBJ_PITCHFORK)
           {
            if (StringFind(name,"pitchforkS" + ExtComplekt+"_",0)<0 && StringFind(name,"pitchforkS",0)>=0)
              {
               k++;
               ArrayResize(aName,k);
               aName[k-1]=name;
              }
           }
        }
     }
   else if (mTypeExternalAP==4)  // динамические вилы из других комплектов ZUP с текущего графика
     {
      for (i=0; i<j; i++)
        {
         name=ObjectName(i);
         if (ObjectType(name)==OBJ_PITCHFORK)
           {
            if (StringFind(name,"pitchforkD" + ExtComplekt+"_",0)<0 && StringFind(name,"pitchforkD",0)>=0)
              {
               k++;
               ArrayResize(aName,k);
               aName[k-1]=name;
              }
           }
        }
     }
   else if (mTypeExternalAP==5)  // любые вилы из других комплектов ZUP с текущего графика
     {
      for (i=0; i<j; i++)
        {
         name=ObjectName(i);
         if (ObjectType(name)==OBJ_PITCHFORK)
           {
            if (StringFind(name,"pitchforkD" + ExtComplekt+"_",0)<0 && StringFind(name,"pitchforkD",0)>=0)
              {
               k++;
               ArrayResize(aName,k);
               aName[k-1]=name;
              }

            if (StringFind(name,"pitchforkS" + ExtComplekt+"_",0)<0 && StringFind(name,"pitchforkS",0)>=0)
              {
               k++;
               ArrayResize(aName,k);
               aName[k-1]=name;
              }
           }
        }
     }
   else if (mTypeExternalAP==6)  // вилы с текущего графика, выведенные вручную, не с помощью ZUP
     {
      for (i=0; i<j; i++)
        {
         name=ObjectName(i);
         if (ObjectType(name)==OBJ_PITCHFORK)
           {
            if (StringFind(name,"Andrews Pitchfork",0)>=0)
              {
               k++;
               ArrayResize(aName,k);
               aName[k-1]=name;
              }
           }
        }
     }
   else if (mTypeExternalAP==7)  // любые внешние вилы
     {
      if (mTypeBasiclAP==0)
        {
         for (i=0; i<j; i++)
           {
            name=ObjectName(i);
            if (ObjectType(name)==OBJ_PITCHFORK)
              {
               if (StringFind(name,"pitchforkS",0)>=0 && (StringLen(name)>StringLen("pitchforkS" + ExtComplekt+"_")+4 || StringFind(name,"pitchforkS" + ExtComplekt+"_",0)<0))
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }

               if (StringFind(name,"pitchforkD",0)>=0)
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }

               if (StringFind(name,"Andrews Pitchfork",0)>=0)
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }
              }
           }
        }
      else if (mTypeBasiclAP==1)
        {
         for (i=0; i<j; i++)
           {
            name=ObjectName(i);
            if (ObjectType(name)==OBJ_PITCHFORK)
              {
               if (StringFind(name,"pitchforkD",0)>=0 && (StringLen(name)>StringLen("pitchforkD" + ExtComplekt+"_")+4 || StringFind(name,"pitchforkD" + ExtComplekt+"_",0)<0))
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }

               if (StringFind(name,"pitchforkS",0)>=0)
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }

               if (StringFind(name,"Andrews Pitchfork",0)>=0)
                 {
                  k++;
                  ArrayResize(aName,k);
                  aName[k-1]=name;
                 }
              }
           }
        }
     }
  }
//--------------------------------------------------------
// Проверка наличия внешних вил для расчета меток пересечения вил
// и сохранение названий внешних вил в массив. 
// Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Заполнение массива значениями RL для расчета ценовых 
// меток (metkaAP) в вилах Эндрюса. Начало.
//--------------------------------------------------------
void RLtoArray (double& aRL[], string nameRL)
  {
   int i, j, k;
   j=ObjectGet(nameRL,OBJPROP_FIBOLEVELS);
   ArrayResize(aRL,j);
   k=0;
   if (ExtFiboType==0)
     {
      if (ExtRL146)
        {
         aRL[0]=0.146;
         k=1;
        }
     }
   else if (ExtFiboType==1)
     {
      if (ExtRL146)
        {
         aRL[0]=0.146;
         aRL[1]=0.236;
         k=2;
        }
     }

   for (i=0;k<j;i++)
     {
      aRL[k]=ObjectGet(nameRL,OBJPROP_FIRSTLEVEL+i);
      k++;
     }
  }
//--------------------------------------------------------
// Заполнение массива значениями RL для расчета ценовых 
// меток (metkaAP) в вилах Эндрюса. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод UWL_LWL. Начало.
//--------------------------------------------------------
void UWL_LWL (bool visible, string nameObj_, string WL, string fiboFree)
  {
   int i,j,k;
   string str;
   double fi;

   if (ExtFiboType==2)
     {
      j=quantityFibo (fiboFree);
      str=fiboFree;
     }
   else
     {
      j=12;
      str="0.146,0.236,0.382,0.5,0.618,0.764,0.854,1,1.618,2.0,2.618,4.236";
     }

   ObjectSet(nameObj_,OBJPROP_FIBOLEVELS,j+1);
   for (i=0;i<=j;i++)
     {
      k=StringFind(str, ",", 0);
      fi=StrToDouble(StringTrimLeft(StringTrimRight(StringSubstr(str,0,k))));

      ObjectSet(nameObj_,OBJPROP_FIRSTLEVEL+i,fi);
      if (visible) ObjectSetFiboDescription(nameObj_, i, WL+DoubleToStr(fi*100,1));

      if (k>=0) str=StringSubstr(str,k+1);
     }
  }
//--------------------------------------------------------
// Вывод UWL_LWL. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// фибо-Time. Начало.
//--------------------------------------------------------
void fiboTimeX()
  {
   bool  ft1, ft2, ft3;
   color ftc1, ftc2, ftc3;

   ft1=ExtFiboTime1;
   ft2=ExtFiboTime2;
   ft3=ExtFiboTime3;
   ftc1=ExtFiboTime1C;
   ftc2=ExtFiboTime2C;
   ftc3=ExtFiboTime3C;

   if (ExtFiboTimeNum>2)
     {
      ft1=ExtFiboTime1x;
      ft2=ExtFiboTime2x;
      ft3=ExtFiboTime3x;
      ftc1=ExtFiboTime1Cx;
      ftc2=ExtFiboTime2Cx;
      ftc3=ExtFiboTime3Cx;

      int mft[]={0,0,0};
      string aa=DoubleToStr(ExtFiboTimeNum,0);
      double ftmincena;

      mft[0]=StrToInteger(StringSubstr(aa,0,1));
      mft[1]=StrToInteger(StringSubstr(aa,1,1));
      mft[2]=StrToInteger(StringSubstr(aa,2,1));
      ArraySort(mft,WHOLE_ARRAY,0,MODE_DESCEND);

      if (mft[0]<3) ExtFiboTimeNum=0;
      else
        {
         if (mft[1]==1) mft[1]++;
         if (mft[1]==0) {mft[1]=mft[0]-1; mft[2]=mft[1]-1;}
         if (mft[2]==0) mft[2]=mft[1]-1;
        }

      if (afrx[mft[0]]<afrx[mft[1]]) ftmincena=afrx[mft[0]]; else ftmincena=afrx[mft[1]];
      if (ftmincena>afrx[mft[2]]) ftmincena=afrx[mft[2]];

     }

   if (ft1)
     {
      if (ExtFiboTimeNum>2)
        {
         nameObj="fiboTime1Free" + ExtComplekt+"_";
        }
      else
        {
         nameObj="fiboTime1" + ExtComplekt+"_";
        }

      if (ExtSave)
        {
         if (ExtFiboTimeNum>2)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
            }
        }

      ObjectDelete(nameObj);

      if (ExtFiboTimeNum>2)
        {
         ObjectCreate(nameObj,OBJ_FIBOTIMES,0,afr[mft[0]],ftmincena-5*Point,afr[mft[2]],ftmincena-5*Point);
        }
      else
        {
         if (ExtPitchforkCandle)
           {
            if (!ExtPitchfork_1_HighLow)
              {
               if (mPitchCena[0]>mPitchCena[2])
                 {
                  ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[0],mPitchCena[2]-5*Point,mPitchTime[2],mPitchCena[2]-5*Point);
                 }
               else
                 {
                  ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[0],mPitchCena[0]-5*Point,mPitchTime[2],mPitchCena[0]-5*Point);
                 }
              }
            else
              {
               ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[0],mPitchCena[1]-5*Point,mPitchTime[2],mPitchCena[1]-5*Point);
              }
           }
         else
           {
            if (afrl[mPitch[0]]>0)
              {
               if (afrl[mPitch[0]]>afrl[mPitch[2]])
                 {
                  ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[0],mPitchCena[2]-5*Point,mPitchTime[2],mPitchCena[2]-5*Point);
                 }
               else
                 {
                  ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[0],mPitchCena[0]-5*Point,mPitchTime[2],mPitchCena[0]-5*Point);
                 }
              }
            else
              {
               ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[0],mPitchCena[1]-5*Point,mPitchTime[2],afrl[mPitch[1]]-5*Point);
              }
           }
         }
       

      ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ftc1);

      if (ExtFiboTimeNum>2)
        {
         fiboTime (nameObj, afr[mft[0]], afr[mft[2]]-afr[mft[0]], 0, "FT1_");
        }
      else
        {
         fiboTime (nameObj, mPitchTime[0], mPitchTime[2]-mPitchTime[0], 0, "FT1 ");
        }
     }

   if (ft2)
     {
      if (ExtFiboTimeNum>2)
        {
         nameObj="fiboTime2Free" + ExtComplekt+"_";
        }
      else
        {
         nameObj="fiboTime2" + ExtComplekt+"_";
        }

      if (ExtSave)
        {
         if (ExtFiboTimeNum>2)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
            }
        }

      ObjectDelete(nameObj);

      if (ExtFiboTimeNum>2)
        {
         ObjectCreate(nameObj,OBJ_FIBOTIMES,0,afr[mft[1]],(afrx[mft[2]]+afrx[mft[1]])/2,afr[mft[2]],(afrx[mft[2]]+afrx[mft[1]])/2);
        }
      else
        {
         ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[1],(mPitchCena[2]+mPitchCena[1])/2,mPitchTime[2],(mPitchCena[2]+mPitchCena[1])/2);
        }

      ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ftc2);

      if (ExtFiboTimeNum>2)
        {
         fiboTime (nameObj, afr[mft[1]], afr[mft[2]]-afr[mft[1]], 1, "FT2_");
        }
      else
        {
         fiboTime (nameObj, mPitchTime[1], mPitchTime[2]-mPitchTime[1], 1, "FT2 ");
        }
     }

   if (ft3)
     {
      datetime shiftTime;

      if (ExtFiboTimeNum>2)
        {
         shiftTime=afr[mft[1]]-afr[mft[0]];
         nameObj="fiboTime3Free" + ExtComplekt+"_";
        }
      else
        {
         shiftTime=mPitchTime[1]-mPitchTime[0];
         nameObj="fiboTime3" + ExtComplekt+"_";
        }

      if (ExtSave)
        {
         if (ExtFiboTimeNum>2)
           {
            nameObj=nameObj + save;
           }
         else
           {
            if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
              {
               nameObj=nameObj + save;
              }
            else
              {
               if (mPitch[2]>0)
                 {
                  nameObj=nameObj + save;
                 }
              }
            }
        }

      ObjectDelete(nameObj);

      if (ExtFiboTimeNum>2)
        {
         ObjectCreate(nameObj,OBJ_FIBOTIMES,0,afr[mft[2]]-shiftTime,(afrx[mft[2]]+afrx[mft[1]])/2-8*Point,afr[mft[2]],(afrx[mft[2]]+afrx[mft[1]])/2-8*Point);
        }
      else
        {
         ObjectCreate(nameObj,OBJ_FIBOTIMES,0,mPitchTime[2]-shiftTime,(mPitchCena[2]+mPitchCena[1])/2-8*Point,mPitchTime[2],(mPitchCena[2]+mPitchCena[1])/2-8*Point);
        }

      ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ftc3);

      if (ExtFiboTimeNum>2)
        {
         fiboTime (nameObj, afr[mft[2]]-shiftTime, shiftTime, 2, "FT3_");
        }
      else
        {
         fiboTime (nameObj, mPitchTime[2]-shiftTime, shiftTime, 2, "FT3 ");
        }
     }

  }
//--------------------------------------------------------
// фибо-Time. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// фибо-Time. Начало.
//--------------------------------------------------------
void fiboTime (string nameObj, datetime t1, datetime t2, int number, string ftx)
  {
   string str, str1;
   double fi;
   int j,k;

   int   ftvisibleDT;
   string ftvisible;
  
   if (ExtFiboTimeNum>2)
     {
      ftvisibleDT=ExtVisibleDateTimex;
      ftvisible=ExtVisibleNumberFiboTimex;
     }
   else
     {
      ftvisibleDT=ExtVisibleDateTime;
      ftvisible=ExtVisibleNumberFiboTime;
     }

   ObjectSet(nameObj,OBJPROP_COLOR,ExtObjectColor);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtObjectStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtObjectWidth);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DOT);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   if (ExtFiboType==1) // Фибы фибо-Time с числами Песавенто.
     {
      str="0.382,0.5,0.618,0.707,0.786,0.886,1.0,1.272,1.414,1.618,2.0,2.414,2.618,3.0";
     }
   else if (ExtFiboType==0) // Фибы фибо-Time со стандартными числами.
     {
      str="0.146,0.236,0.382,0.5,0.618,0.764,0.854,1.0,1.236,1.382,1.618,2.0,2.618,3.0,4.236";
     }
   else if (ExtFiboType==2) // Фибы фибо-Time с пользовательскими числами.
     {

      if (number==0)
        {
         str=ExtFiboFreeFT1;
        }
      else if (number==1)
        {
         str=ExtFiboFreeFT2;
        }
      else if (number==2)
        {
         str=ExtFiboFreeFT3;
        }

     }

   j=quantityFibo (str);
   ObjectSet(nameObj,OBJPROP_FIBOLEVELS, j+3);

   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+0,0.0);
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+1,1.0);
   if (ftvisibleDT && StringSubstr(ftvisible,number,1)=="1")
     {
      ObjectSetFiboDescription(nameObj, 0, ftx + "0" + " " + TimeToStr(t1,TIME_DATE|TIME_MINUTES));
      ObjectSetFiboDescription(nameObj, 1, ftx + "1.0" + " " + TimeToStr(t1 + t2,TIME_DATE|TIME_MINUTES));
     }
   else
     {
      ObjectSetFiboDescription(nameObj, 0, ftx + "0");
      ObjectSetFiboDescription(nameObj, 1, ftx + "1.0");
     }

   for (int i=0; i<=j; i++)
     {
      k=StringFind(str, ",", 0);
      str1=StringTrimLeft(StringTrimRight(StringSubstr(str,0,k)));
      fi=StrToDouble(str1);
      if (fi<1) str1=StringSubstr(str1,1);

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+(i+2),fi+1);
      if (ftvisibleDT && StringSubstr(ftvisible,number,1)=="1")
        {
         ObjectSetFiboDescription(nameObj, i+2, ftx + str1 + " " + TimeToStr(t1 + t2*(fi+1),TIME_DATE|TIME_MINUTES));
        }
      else
        {
         ObjectSetFiboDescription(nameObj, i+2, ftx + str1);
        }
      if (k>=0) str=StringSubstr(str,k+1);
     }

  }
//--------------------------------------------------------
// фибо-Time. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Счетчик фиб. Начало.
//--------------------------------------------------------
int quantityFibo (string sFibo)
  {
   int j=0,i,k;

   while (true)
     {
      k=StringFind(sFibo, ",",i+1);
      if (k>0) {j++; i=k;}
      else return (j);
     }
  }
//--------------------------------------------------------
// Счетчик фиб. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод вил Эндрюса динамических. Начало.
//--------------------------------------------------------
void screenPitchforkD()
  {
   int i;
   double b1,ab1,bc1,ab2,bc2,d,cena,m618=phi-1,m382=2-phi,wr,wr1,wr2;
   datetime tb1,tab2,tbc2,twr1,twr2;
   int    a0,b0,c0;
   int    pitch_time[]={0,0,0}; 
   double pitch_cena[]={0,0,0};

   mPitchTime[0]=afr[2]; mPitchTime[1]=afr[1]; mPitchTime[2]=afr[0];
   mPitchCena[0]=afrx[2]; mPitchCena[1]=afrx[1]; mPitchCena[2]=afrx[0];

   cena=afrx[2]; 

   if (afrl[2]>0)
     {
      if (ExtCM_0_1A_2B_Dinamic==1)
        {
         cena=mPitchCena[0]+(mPitchCena[1]-mPitchCena[0])*ExtCM_FiboDinamic;
        }
      else if (ExtCM_0_1A_2B_Dinamic==4)
        {
         mPitchTimeSave=mPitchTime[0];
         mPitchTime[0]=mPitchTime[1];
         if (maxGipotenuza4(mPitchTime,mPitchCena))
           {
            cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m618;
           }
         else
           {
            cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m382;
           }
        }
      else if (ExtCM_0_1A_2B_Dinamic==5)
        {
         mPitchTimeSave=mPitchTime[0];
         mPitchTime[0]=mPitchTime[1];
         if (maxGipotenuza5(mPitchTime,mPitchCena))
           {
            cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m618;
           }
         else
           {
            cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*m382;
           }
        }
      else if (ExtCM_0_1A_2B_Dinamic>1)
        {
         if (ExtCM_0_1A_2B_Dinamic==2) mPitchTime[0]=mPitchTime[1];
         cena=mPitchCena[1]-(mPitchCena[1]-mPitchCena[2])*ExtCM_FiboDinamic;
        }
     }
   else
     {
      if (ExtCM_0_1A_2B_Dinamic==1)
        {
         cena=mPitchCena[0]-(mPitchCena[0]-mPitchCena[1])*ExtCM_FiboDinamic;
        }
      else if (ExtCM_0_1A_2B_Dinamic==4)
        {
         mPitchTimeSave=mPitchTime[0];
         mPitchTime[0]=mPitchTime[1];
         if (maxGipotenuza4(mPitchTime,mPitchCena))
           {
            cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m618;
           }
         else
           {
            cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m382;
           }
        }
      else if (ExtCM_0_1A_2B_Dinamic==5)
        {
         mPitchTimeSave=mPitchTime[0];
         mPitchTime[0]=mPitchTime[1];
         if (maxGipotenuza5(mPitchTime,mPitchCena))
           {
            cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m618;
           }
         else
           {
            cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*m382;
           }
        }
      else if (ExtCM_0_1A_2B_Dinamic>1)
        {
         if (ExtCM_0_1A_2B_Dinamic==2) mPitchTime[0]=mPitchTime[1];
         cena=mPitchCena[1]+(mPitchCena[2]-mPitchCena[1])*ExtCM_FiboDinamic;
        }
     }

   mPitchCena[0]=cena;

   coordinaty_1_2_mediany_AP(mPitchCena[0], mPitchCena[1], mPitchCena[2], mPitchTime[0], mPitchTime[1], mPitchTime[2], tab2, tbc2, ab1, bc1, ExtPitchforkDinamic, ExtPitchforkDinamicCustom);
      
   pitch_time[0]=tab2;pitch_cena[0]=ab1;

   nameObj="pmedianaD" + ExtComplekt+"_";
   ObjectDelete(nameObj);
     
   if (ExtPitchforkDinamic==2)
     {
      ObjectCreate(nameObj,OBJ_TREND,0,tab2,ab1,tbc2,bc1);
      ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
      ObjectSet(nameObj,OBJPROP_COLOR,ExtLinePitchforkD);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

      if (ExtSLMDinamic)
        {
         b0=iBarShift(Symbol(),Period(),mPitchTime[1]);
         c0=iBarShift(Symbol(),Period(),mPitchTime[2]);

         // смещение slm
         wr=(ObjectGetValueByShift(nameObj,c0)-mPitchCena[2])*(1-2*m382);

         //номер бара точки 1
         a0=c0-(c0-b0)*m382-1;
         // время точки 1
         twr1=iTime(Symbol(),Period(),a0);
         // цена точки 1
         wr1=ObjectGetValueByShift(nameObj,a0)-wr;
         // координаты точки 2
         wr2=ObjectGetValueByShift(nameObj,0)-wr;
         twr2=iTime(Symbol(),Period(),0);

         nameObj="SLM382D" + ExtComplekt+"_";
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_TREND,0,twr1,wr1,twr2,wr2);
         ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtSLMDinamicColor);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

         //номер бара точки 1
         a0=c0-(c0-b0)*m618-1;
         // время точки 1
         twr1=iTime(Symbol(),Period(),a0);
         // цена точки 1
         nameObj="pmedianaD" + ExtComplekt+"_";
         wr1=ObjectGetValueByShift(nameObj,a0)+wr;
         // координаты точки 2
         wr2=ObjectGetValueByShift(nameObj,0)+wr;
         twr2=iTime(Symbol(),Period(),0);

         nameObj="SLM618D" + ExtComplekt+"_";
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_TREND,0,twr1,wr1,twr2,wr2);
         ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtSLMDinamicColor);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
        }

      if (ExtFSLShiffLinesDinamic)
        {
         c0=iBarShift(Symbol(),Period(),mPitchTime[1]);

         // время точки 1
         twr1=mPitchTime[1];
         // цена точки 1
         wr1=mPitchCena[1];
         // координаты точки 2
         nameObj="pmedianaD" + ExtComplekt+"_";
         wr2=ObjectGetValueByShift(nameObj,0)-ObjectGetValueByShift(nameObj,c0)+mPitchCena[1];
         twr2=iTime(Symbol(),Period(),0);

         nameObj="FSL Shiff Lines D" + ExtComplekt+"_";
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_TREND,0,twr1,wr1,twr2,wr2);
         ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DASH);
         ObjectSet(nameObj,OBJPROP_COLOR,ExtFSLShiffLinesDinamicColor);
         ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
        }

      nameObj="1-2pmedianaD" + ExtComplekt+"_";
      ObjectDelete(nameObj);
      ObjectCreate(nameObj,OBJ_TEXT,0,tab2,ab1+3*Point);
      ObjectSetText(nameObj,"     1/2 ML",9,"Arial", ExtLinePitchforkD);
     }

   nameObj="pitchforkD" + ExtComplekt+"_";

   if (ExtPitchforkDinamic!=4)
     {
      pitch_time[0]=mPitchTime[0];pitch_cena[0]=mPitchCena[0];
      if (ExtPitchforkDinamic==3) pitch_cena[0]=ab1;
     }
   pitch_time[1]=mPitchTime[1];pitch_cena[1]=mPitchCena[1];
   pitch_time[2]=mPitchTime[2];pitch_cena[2]=mPitchCena[2];

   // Вывод меток в вилах Эндрюса
   mAPd=false;
   if (ObjectFind(nameObj)>=0)
     {
      if (mAP)
        {
         if (ObjectGet(nameObj,OBJPROP_TIME1)!=pitch_time[0] || ObjectGet(nameObj,OBJPROP_PRICE1)!=pitch_cena[0] ||
             ObjectGet(nameObj,OBJPROP_TIME2)!=pitch_time[1] || ObjectGet(nameObj,OBJPROP_PRICE2)!=pitch_cena[1] ||
             ObjectGet(nameObj,OBJPROP_TIME3)!=pitch_time[2] || ObjectGet(nameObj,OBJPROP_PRICE3)!=pitch_cena[2])   {mAPd=true; RZd=-1;}
        } 

      ObjectDelete(nameObj);
     }
   else if (mAP) {mAPd=true; RZd=-1;}
   delete_objects7();

   ObjectCreate(nameObj,OBJ_PITCHFORK,0,pitch_time[0],pitch_cena[0],pitch_time[1],pitch_cena[1],pitch_time[2],pitch_cena[2]);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtPitchforkStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtPitchforkWidth);
   ObjectSet(nameObj,OBJPROP_COLOR,ExtLinePitchforkD);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   if (ExtMasterPitchfork==1)
     {
      nameObjAPMaster="Master_"+nameObj;
      ObjectDelete(nameObjAPMaster);
      ObjectCreate(nameObjAPMaster,OBJ_PITCHFORK,0,pitch_time[0],pitch_cena[0],pitch_time[1],pitch_cena[1],pitch_time[2],pitch_cena[2]);
      ObjectSet(nameObjAPMaster,OBJPROP_STYLE,ExtPitchforkStyle);
      ObjectSet(nameObjAPMaster,OBJPROP_WIDTH,ExtPitchforkWidth);
      ObjectSet(nameObjAPMaster,OBJPROP_COLOR,CLR_NONE);
      ObjectSet(nameObjAPMaster,OBJPROP_BACK,true);
     }

   if (ExtPivotZoneDinamicColor>0 && ExtPitchforkDinamic<4) PivotZone(pitch_time, pitch_cena, ExtPivotZoneDinamicColor, "PivotZoneD");

   if (ExtFiboFanMedianaDinamicColor>0)
     {
      coordinaty_mediany_AP(pitch_cena[0], pitch_cena[1], pitch_cena[2], pitch_time[0], pitch_time[1], pitch_time[2], tb1, b1);      

      nameObj="FanMedianaDinamic" + ExtComplekt+"_";
      ObjectDelete(nameObj);

      ObjectCreate(nameObj,OBJ_FIBOFAN,0,pitch_time[0],pitch_cena[0],tb1,b1);
      ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DASH);
      ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboFanMedianaDinamicColor);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

      if (ExtFiboType==0)
        {
         screenFibo_st();
        }
      else if (ExtFiboType==1)
        {
         screenFibo_Pesavento();
        }
      else if (ExtFiboType==2)
        {
         ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi);
         for (i=0;i<Sizefi;i++)
           {
            ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi[i]);
            ObjectSetFiboDescription(nameObj, i, fitxt100[i]); 
           }
        }
     }

//-------------------------------------------------------

   if (ExtISLChannelDinamicColor>0)
     {
      channelISL(pitch_cena[0], pitch_cena[1], pitch_cena[2], pitch_time[0], pitch_time[1], pitch_time[2], 1);
     }

//--------------------------------------------------------

   if (ExtISLDinamic)
     {
      _ISL("ISL_D", pitch_time, pitch_cena, ExtLinePitchforkD, ExtISLStyleDinamic, 1, "");
     }

//--------------------------------------------------------

   if (ExtRLDinamic)
     {
      _RL("RLineD", pitch_time, pitch_cena, ExtLinePitchforkD, ExtRLStyleDinamic, ExtVisibleRLDinamic, 1);
     }
//--------------------------------------------------------
   if (ExtRedZoneDinamic)
     {
      _RZ("RZD", ExtRZDinamicValue, ExtRZDinamicColor, pitch_time, pitch_cena);
     }
//--------------------------------------------------------

  }
//--------------------------------------------------------
// Вывод вил Эндрюса динамических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод ISL. Начало.
//--------------------------------------------------------
void _ISL(string nameISL, datetime pitch_time[], double pitch_cena[], color lineColor, int lineStyle, int StaticDinamic, string suffcs)
// StaticDinamic 0 - Static, 1 - Dinamic
  {
   int i,j,k, a, b, c, znak=1;
   string str;
   double fi,a1,b1,c1,tangens,x;
   datetime ta1,tb1,tc1;
   datetime twr;

   if (pitch_time[2]<pitch_time[1]) znak=-1;

   twr=iTime(Symbol(),Period(),0);
   if (twr>=pitch_time[0]) a=iBarShift(Symbol(),Period(),pitch_time[0]); else a=-(pitch_time[0]-twr)/(Period()*60);
   if (twr>=pitch_time[1]) b=iBarShift(Symbol(),Period(),pitch_time[1]); else b=-(pitch_time[1]-twr)/(Period()*60);
   if (twr>=pitch_time[2]) c=iBarShift(Symbol(),Period(),pitch_time[2]); else c=-(pitch_time[2]-twr)/(Period()*60);

   x=a-(b+c)/2.0;

   ta1=pitch_time[1];
   a1=pitch_cena[1];
   tangens=znak*(pitch_cena[0]-(pitch_cena[1]+pitch_cena[2])/2.0)/x;

   ML_RL400(tangens, pitch_cena, pitch_time, tb1, b1, true);

   tc1=pitch_time[2];
   c1=pitch_cena[2];

   nameObj=nameISL + ExtComplekt+"_" + suffcs;
   if (ExtSave && nameISL=="ISL_S")
     {
      if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
        {
         nameObj=nameObj + save;
        }
      else
        {
         if (mPitch[2]>0)
           {
            nameObj=nameObj + save;
           }
        }
      }

   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_FIBOCHANNEL,0,ta1,a1,tb1,b1,tc1,c1);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,lineColor);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,lineStyle);
   ObjectSet(nameObj,OBJPROP_LEVELWIDTH,ExtISLWidth);
   ObjectSet(nameObj,OBJPROP_RAY,false);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   ObjectSet(nameObj,OBJPROP_COLOR,CLR_NONE);

   if (StaticDinamic==2)
     {
      str="0.618,0.382";
     }
   else if (ExtFiboType==0)
     {
      str="0.854,0.764,0.618,0.382,0.236,0.146";
     }
   else if (ExtFiboType==1)
     {
      str="0.886,0.786,0.618,0.382,0.236,0.146";
     }
   else if (ExtFiboType==2)
     {
      if (StaticDinamic==0)
        {
         str=ExtFiboFreeISLStatic ;
        }
      else
        {
         str=ExtFiboFreeISLDinamic;
        }
     }

   j=quantityFibo (str);
   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,j+1);
   for (i=0;i<=j;i++)
     {
      k=StringFind(str, ",", 0);
      fi=StrToDouble(StringTrimLeft(StringTrimRight(StringSubstr(str,0,k))));

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,-fi);
      if (StaticDinamic==0)
        {
         if (ExtVisibleISLStatic) ObjectSetFiboDescription(nameObj, i," ISL "+DoubleToStr(fi*100,1));
        }
      else if (StaticDinamic==1)
        {
         if (ExtVisibleISLDinamic) ObjectSetFiboDescription(nameObj, i," ISL "+DoubleToStr(fi*100,1));
        }
      else
        {
         if (mVisibleISL) ObjectSetFiboDescription(nameObj, i," ISL "+DoubleToStr(fi*100,1));
        }

      if (k>=0) str=StringSubstr(str,k+1);
     }
  }
//--------------------------------------------------------
// Вывод ISL. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод RLine. Начало.
//--------------------------------------------------------
void _RL(string nameRL, datetime pitch_time[], double pitch_cena[], color lineColor, int lineStyle, bool visibleRL, int StaticDinamic)
// StaticDinamic 0 - Static, 1 - Dinamic
  {
   string str;
   double fi;
   int i,j,k,n,nbase1,nbase2,mirror1,mirror2;
   double a1,b1,c1;
   datetime ta1,tb1,tc1;
   
   n=iBarShift(Symbol(),Period(),pitch_time[0])-(iBarShift(Symbol(),Period(),pitch_time[1])+iBarShift(Symbol(),Period(),pitch_time[2]))/2.0;

   nbase1=iBarShift(Symbol(),Period(),mPitchTime[1]);
   nbase2=iBarShift(Symbol(),Period(),mPitchTime[2]);

   if (nbase1+n<=Bars)
     {
      mirror1=1;
      mirror2=0;

      ta1=Time[nbase1+n];
      tb1=Time[nbase2+n];
      tc1=mPitchTime[1];

      a1=(pitch_cena[0]-(mPitchCena[1]+mPitchCena[2])/2)+mPitchCena[1];
      b1=(pitch_cena[0]-(mPitchCena[1]+mPitchCena[2])/2)+mPitchCena[2];
      c1=mPitchCena[1];
     }
   else
     {
      mirror1=-1;
      mirror2=-1;

      ta1=mPitchTime[2];
      tb1=mPitchTime[1];
      tc1=Time[nbase2+n];

      a1=mPitchCena[2];
      b1=mPitchCena[1];
      c1=(pitch_cena[0]-(mPitchCena[1]+mPitchCena[2])/2)+mPitchCena[2];
     }

   nameObj=nameRL + ExtComplekt+"_";
   if (ExtSave && nameRL=="RLineS")
     {
      if (ExtPitchforkCandle && iBarShift(Symbol(),Period(),ExtDateTimePitchfork_3)>0)
        {
         nameObj=nameObj + save;
        }
      else
        {
         if (mPitch[2]>0)
           {
            nameObj=nameObj + save;
           }
        }
     }

   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_FIBOCHANNEL,0,ta1,a1,tb1,b1,tc1,c1);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,lineColor);

   if (ExtRLineBase) 
     {
      ObjectSet(nameObj,OBJPROP_COLOR,CLR_NONE);
     }
   else
     {
      ObjectSet(nameObj,OBJPROP_COLOR,lineColor);
     }

   if (ExtFiboType==1)
     {
      if (ExtRL146) j=16; else j=14;
      str="0.382,0.5,0.618,0.707,0.786,0.886,1,1.128,1.272,1.414,1.618,2.0,2.414,2.618,4.236,0.146,0.236";
     }
   else if (ExtFiboType==0)
     {
      if (ExtRL146) j=12; else j=11;
      str="0.236,0.382,0.5,0.618,0.764,0.854,1,1.236,1.618,2.0,2.618,4.236,0.146";
     }
   else if (ExtFiboType==2)
     {
      if (StaticDinamic==0)
        {
         j=quantityFibo (ExtFiboFreeRLStatic);
         str=ExtFiboFreeRLStatic;
        }
      else
        {
         j=quantityFibo (ExtFiboFreeRLDinamic);
         str=ExtFiboFreeRLDinamic;
        }
     }

   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,lineStyle);
   ObjectSet(nameObj,OBJPROP_RAY,false);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,j+1);
   for (i=0;i<=j;i++)
     {
      k=StringFind(str, ",", 0);
      fi=StrToDouble(StringTrimLeft(StringTrimRight(StringSubstr(str,0,k))));

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,mirror2+mirror1*fi);
      if (visibleRL) ObjectSetFiboDescription(nameObj, i, " RL "+DoubleToStr(fi*100,1));

      if (k>=0) str=StringSubstr(str,k+1);
     }
  }
//--------------------------------------------------------
// Вывод RLine. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод RedZone. Начало.
//--------------------------------------------------------
void _RZ(string nameRZ, double RZValue, color RZColor, datetime pitch_time[], double pitch_cena[])
  {
   int i,j,k,n,_nbase1,_nbase2;
   double b1,hRZ,delta,h=0,hbase,tangens23,tangensMediana,n1,nbase0,nbase1,nbase2;
   datetime tb1;

   nbase0=iBarShift(Symbol(),Period(),pitch_time[0]);
   nbase1=iBarShift(Symbol(),Period(),pitch_time[1]);
   nbase2=iBarShift(Symbol(),Period(),pitch_time[2]);
   _nbase1=iBarShift(Symbol(),Period(),pitch_time[1]);
   _nbase2=iBarShift(Symbol(),Period(),pitch_time[2]);

   tangens23=(pitch_cena[2]-pitch_cena[1])/(nbase1-nbase2);
   n1=nbase0-(nbase1+nbase2)/2;
   tangensMediana=((pitch_cena[2]+pitch_cena[1])/2-pitch_cena[0])/n1;

   hbase=pitch_cena[0]-(pitch_cena[1]-(nbase0-nbase1)*tangens23);
   hRZ=hbase*RZValue;

   if (pitch_cena[1]>pitch_cena[2])
     {
      for (i=_nbase1-1;i>=_nbase2;i--)
        {
         delta=(pitch_cena[1]+(_nbase1-i)*tangens23)-High[i];
         if (delta<h) h=delta;
        }
     }
   else
     {
      for (i=_nbase1-1;i>=_nbase2;i--)
        {
         delta=(pitch_cena[1]+(_nbase1-i)*tangens23)-Low[i];
         if (delta>h) h=delta;
        }
     }

   if (infoTF)
     {
      if (nameRZ=="RZS")
        {
         info_RZS_RL=DoubleToStr(MathAbs(100*h/hbase),1);
        }
      else if (nameRZ=="RZD")
        {
         info_RZD_RL=DoubleToStr(MathAbs(100*h/hbase),1);
        }
     }

   if (MathAbs(hRZ)<MathAbs(h)) hRZ=h;

   for (i=1;i<100;i++)
     {
      if (MathAbs(hRZ)<=MathAbs(tangens23*i)+MathAbs(tangensMediana*i)) break;
     }
   n=nbase2-i;

   if (n>=0) tb1=Time[n];
   else tb1=Time[0]+MathAbs(n)*60*Period();

   b1=pitch_cena[2]+i*tangens23-hRZ;

   nameObj=nameRZ + ExtComplekt+"_";

   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_CHANNEL,0,pitch_time[2],pitch_cena[2],tb1,b1,pitch_time[1],pitch_cena[1]);
   ObjectSet(nameObj, OBJPROP_COLOR, RZColor); 
   ObjectSet(nameObj, OBJPROP_BACK, true);
   ObjectSet(nameObj, OBJPROP_RAY, false);

  }
//--------------------------------------------------------
// Вывод RedZone. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Подпрограмма вывода канала по ISL .382 - .618. Начало.
//--------------------------------------------------------
void channelISL(double A_1, double B_2, double C_3, datetime T_1, datetime T_2, datetime T_3, int StaticDinamic)
  {
   double tangens;
   int    n1, n2, n3, nc1, nb1;
   double c1, c2, b1, b2, nc1_, nb1_;
   string nameObj;

   // номера баров, от которых строятся вилы Эндрюса
   n1=iBarShift(Symbol(),Period(),T_1);
   n2=iBarShift(Symbol(),Period(),T_2);
   n3=iBarShift(Symbol(),Period(),T_3);

   // тангенс угла наклона медианы вил Эндрюса
   tangens=((C_3 + B_2)/2 -A_1)/(n1-(n2 + n3)/2.0);
   // номера баров точек 1 (nc1) и 3 (nb1) для привязки канала, уменьшенные на n3
   nc1_=(n2-n3)*(2.0-phi);
   nb1_=(n2-n3)*(phi-1);
   nc1=nc1_;
   nb1=nb1_;

   // вычисляем цену в точках 1 и 3 для привязки канала
   c2=C_3+(B_2+(n2-n3)*tangens-C_3)*(2-phi);
   b2=C_3+(B_2+(n2-n3)*tangens-C_3)*(phi-1);
   c1=c2-tangens*nc1;
   b1=b2-tangens*nb1;

   nameObj="CISL" + ExtComplekt+"_" + StaticDinamic;
   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_CHANNEL,0,Time[nc1+n3],c1,Time[0],c2+tangens*n3,Time[nb1+n3],b1); // Time[n3],b2);
   ObjectSet(nameObj, OBJPROP_BACK, true);
   if (StaticDinamic==0)
     {
      ObjectSet(nameObj, OBJPROP_COLOR, ExtISLChannelStaticColor); 
     }
   else
     {
      ObjectSet(nameObj, OBJPROP_COLOR, ExtISLChannelDinamicColor); 
     }

  }
//--------------------------------------------------------
// Подпрограмма выводв канала по ISL .382 - .618. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Подпрограмма расчета координат 1/2 медианы вил Эндрюса. Начало.
//--------------------------------------------------------
// Передаваемые параметры цена и время трех точек вил Эндрюса
// а также ссылка на переменные - 
// tAB2, tBC2 - время баров, через которые проводится 1/2 медиана
// AB2, BC2 - ценовое значение точек, через которые проводится 1/2 медиана
// 
void coordinaty_1_2_mediany_AP(double A_1, double B_2, double C_3, datetime T_1, datetime T_2, datetime T_3, datetime& tAB2, datetime& tBC2, double& AB2, double& BC2, int type, double Custom)
  {
   double tangens;
   int    n1, n2, n3, nab2, nbc2;
   datetime twr;

   // номера баров, от которых строятся вилы Эндрюса
   twr=iTime(Symbol(),Period(),0);
   if (T_1<=twr) n1=iBarShift(Symbol(),Period(),T_1); else n1=-(T_1-twr)/(Period()*60);
   if (T_2<=twr) n2=iBarShift(Symbol(),Period(),T_2); else n2=-(T_2-twr)/(Period()*60);
   if (T_3<=twr) n3=iBarShift(Symbol(),Period(),T_3); else n3=-(T_3-twr)/(Period()*60);

   // тангенс угла наклона 1/2 медианы вил Эндрюса
   tangens=(C_3 - A_1)/(n1 - n3);
   // номера баров, через которые будет построена 1/2 медиана
   nab2=MathCeil((n1+n2)/2.0);
   nbc2=MathCeil((n2+n3)/2.0);
   
   // значения цены точек, через которые будет построена 1/2 медиана
   if (type!=3)
     {
      AB2=(A_1 + B_2)/2 - (nab2-(n1+n2)/2.0)*tangens;
     }
   else
     {
      if (type==3 && Custom<0.00000001)
        {
         AB2=(A_1 + B_2)/2;
        }
      else if (Custom>8.99999999)
        {
         AB2=(A_1 + C_3)/2;
        }
      else
        {
         AB2=B_2+(C_3-B_2)*Custom;
        }
     }
   BC2=(B_2 + C_3)/2 - (nbc2-(n2+n3)/2.0)*tangens;
   // время баров, через которые будет построена 1/2 медиана
   if (nab2>=0) tAB2=iTime(Symbol(),Period(),nab2); else tAB2=iTime(Symbol(),Period(),0)-nab2*Period()*60;
   if (nbc2>=0) tBC2=iTime(Symbol(),Period(),nbc2); else tBC2=iTime(Symbol(),Period(),0)-nbc2*Period()*60;
  }
//--------------------------------------------------------
// Подпрограмма расчета координат 1/2 медианы вил Эндрюса. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Подпрограмма расчета координаты точки на медиане вил Эндрюса. Начало.
//--------------------------------------------------------
// Передаваемые параметры цена и время трех точек вил Эндрюса
// а также ссылка на переменные - 
// tAB2, tBC2 - время баров, через которые проводится 1/2 медиана
// AB2, BC2 - ценовое значение точек, через которые проводится 1/2 медиана
// 
void coordinaty_mediany_AP(double A_1, double B_2, double C_3, datetime T_1, datetime T_2, datetime T_3, datetime& tB1, double& B1)
  {
   double tangens;
   int    n1, n2, n3, nbc2;
   
   // номера баров, от которых строятся вилы Эндрюса
   n1=iBarShift(Symbol(),Period(),T_1);
   n2=iBarShift(Symbol(),Period(),T_2);
   n3=iBarShift(Symbol(),Period(),T_3);
   
   // тангенс угла наклона медианы вил Эндрюса
   tangens=(A_1-(C_3+B_2)/2)/(n1 - (n3+n2)/2.0);
   // номер бара, через который проходит медиана
   nbc2=MathCeil((n2+n3)/2.0);

   // значения цены точки, через которую проходит медиана
   B1=(B_2 + C_3)/2 - ((n2+n3)/2.0-nbc2)*tangens;

   // время бара, через который проходит медиана
   tB1=Time[nbc2];
  }
//--------------------------------------------------------
// Подпрограмма расчета координаты точки на медиане вил Эндрюса. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Сравнение гипотенуз для ExtCM_0_1A_2B=4. Начало.
//-------------------------------------------------------
bool maxGipotenuza4(datetime pitch_time1[], double pitch_cena1[])
  {
   double k2,k3;
   datetime k4,k5;

   k2=MathAbs(pitch_cena1[0]-pitch_cena1[1])/ASBar;
   k3=MathAbs(pitch_cena1[1]-pitch_cena1[2])/ASBar;
   k4=iBarShift(NULL,GrossPeriod,mPitchTimeSave)-iBarShift(NULL,GrossPeriod,pitch_time1[1]);
   k5=iBarShift(NULL,GrossPeriod,pitch_time1[1])-iBarShift(NULL,GrossPeriod,pitch_time1[2]);

   if (k2*k2+k4*k4>k3*k3+k5*k5) return(true); else return(false);
  }
//--------------------------------------------------------
// Сравнение гипотенуз для ExtCM_0_1A_2B=4. Конец.
//-------------------------------------------------------

//--------------------------------------------------------
// Сравнение гипотенуз для ExtCM_0_1A_2B=5. Начало.
//-------------------------------------------------------
bool maxGipotenuza5(datetime pitch_time1[], double pitch_cena1[])
  {
   double k2,k3;
   datetime k4,k5;

   k2=MathAbs(pitch_cena1[0]-pitch_cena1[1])/Point;
   k3=MathAbs(pitch_cena1[1]-pitch_cena1[2])/Point;
   k4=iBarShift(NULL,GrossPeriod,mPitchTimeSave)-iBarShift(NULL,GrossPeriod,pitch_time1[1]);
   k5=iBarShift(NULL,GrossPeriod,pitch_time1[1])-iBarShift(NULL,GrossPeriod,pitch_time1[2]);

   if (k2*k2+k4*k4>k3*k3+k5*k5) return(true); else return(false);
  }
//--------------------------------------------------------
// Сравнение гипотенуз для ExtCM_0_1A_2B=5. Конец.
//-------------------------------------------------------

//--------------------------------------------------------
// Pivot Zone. Начало.
//-------------------------------------------------------
void PivotZone(datetime pitch_time1[], double pitch_cena1[], color PivotZoneColor, string name)
  {
   datetime ta1, tb1;
   double a1, b1, d, n1;
   int m, m1, m2;
  
   ta1=pitch_time1[2];
   a1=pitch_cena1[2];
   m1=iBarShift(Symbol(),Period(),pitch_time1[0])-iBarShift(Symbol(),Period(),pitch_time1[1]);
   m2=iBarShift(Symbol(),Period(),pitch_time1[1])-iBarShift(Symbol(),Period(),pitch_time1[2]);
   m=iBarShift(Symbol(),Period(),pitch_time1[2]);
   n1=iBarShift(Symbol(),Period(),pitch_time1[0])-(iBarShift(Symbol(),Period(),pitch_time1[1])+iBarShift(Symbol(),Period(),pitch_time1[2]))/2.0;
   d=(pitch_cena1[0]-(pitch_cena1[1]+pitch_cena1[2])/2.0)/n1;

   if (m1>m2)
     {
      if (m1>m)
        {
         tb1=Time[0]+(m1-m)*Period()*60;
        }
      else
        {
         tb1=Time[iBarShift(Symbol(),Period(),pitch_time1[2])-m1];
        }
      b1=pitch_cena1[0]-d*(2*m1+m2);
     }
   else
     {
      if (m2>m)
        {
         tb1=Time[0]+(m2-m)*Period()*60;
        }
      else
        {
         tb1=Time[iBarShift(Symbol(),Period(),pitch_time1[2])-m2];
        }
      b1=pitch_cena1[0]-d*(2*m2+m1);
     }

   nameObj=name + ExtComplekt+"_";
   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_RECTANGLE,0,ta1,a1,tb1,b1);
   ObjectSetText(nameObj,"PZ "+Period_tf+"  "+TimeToStr(tb1,TIME_DATE|TIME_MINUTES));
   ObjectSet(nameObj, OBJPROP_BACK, ExtPivotZoneFramework);
   ObjectSet(nameObj, OBJPROP_COLOR, PivotZoneColor); 
  }
//--------------------------------------------------------
// Pivot Zone. Конец.
//-------------------------------------------------------

//--------------------------------------------------------
// Определение точки пересечения RL400 медианы. Начало.
//-------------------------------------------------------
// flag=true - рассчитывается ISL
// flag=false - рассчитывается UWL/LWL
void ML_RL400(double Tangens, double pitch_cena1[], datetime pitch_time1[], int& tB1, double& B1, bool flag)
  {
   int m, m1, m2, a, b, c;
   datetime twr;

   twr=iTime(Symbol(),Period(),0);
   if (twr>=pitch_time1[0]) a=iBarShift(Symbol(),Period(),pitch_time1[0]); else a=-(pitch_time1[0]-twr)/(Period()*60);
   if (twr>=pitch_time1[1]) b=iBarShift(Symbol(),Period(),pitch_time1[1]); else b=-(pitch_time1[1]-twr)/(Period()*60);
   if (twr>=pitch_time1[2]) c=iBarShift(Symbol(),Period(),pitch_time1[2]); else c=-(pitch_time1[2]-twr)/(Period()*60);

   m1=a;

   m2=MathCeil((b+c)/2.0);
   m=(m1-m2)*4;

   if (m>m2)
     {
      tB1=Time[0]+(m-m2)*Period()*60;
      if (tB1<0) tB1=2133648000;
      if (flag)
        {
         B1=pitch_cena1[1]-Tangens*(b+(tB1-Time[0])/(60*Period()));
        }
      else
        {
         B1=pitch_cena1[0]-Tangens*(a+(tB1-Time[0])/(60*Period()));
        }
     }
   else
     {
      tB1=Time[m2-m];
      if (flag) B1=pitch_cena1[1]-Tangens*(b-iBarShift(Symbol(),Period(),tB1));
      else  B1=pitch_cena1[0]-Tangens*(a-iBarShift(Symbol(),Period(),tB1));

     }
  }
//--------------------------------------------------------
// Определение точки пересечения RL400 медианы. Конец.
//-------------------------------------------------------

//--------------------------------------------------------
// Вывод произвольных фибовееров. Начало.
//--------------------------------------------------------
void screenFiboFan()
  {
   int i;
   double a1,b1;  

   a1=afrx[mFan[0]]; b1=afrx[mFan[1]];
  
   nameObj="FiboFan" + ExtComplekt+"_";

   if (mFan[1]>0)
     {
      if (ExtSave)
        {
         nameObj=nameObj + save;
        }
     }

   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_FIBOFAN,0,afr[mFan[0]],a1,afr[mFan[1]],b1);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,ExtFanStyle);
   ObjectSet(nameObj,OBJPROP_LEVELWIDTH,ExtFanWidth);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboFanColor);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   ObjectSet(nameObj,OBJPROP_COLOR,ExtObjectColor);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtObjectStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtObjectWidth);

   if (ExtFiboType==0)
     {
      screenFibo_st();
     }
   else if (ExtFiboType==1)
     {
      screenFibo_Pesavento();
     }
   else if (ExtFiboType==2)
     {
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi);
      for (i=0;i<Sizefi;i++)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi[i]);
         ObjectSetFiboDescription(nameObj, i, fitxt100[i]); 
        }
     }

  }
//--------------------------------------------------------
// Вывод произвольных фибовееров. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Список стандартных фиб для произвольных вееров. Начало.
//--------------------------------------------------------
void screenFibo_st()
  {
   double   fi_1[]={0.236, 0.382, 0.5, 0.618, 0.764, 0.854, 1.0, phi, 2.618};
   string   fitxt100_1[]={"23.6", "38.2", "50.0", "61.8", "76.4", "85.4", "100.0", "161.8", "2.618"};
   int i;
   Sizefi_1=9;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
   for (i=0;i<Sizefi_1;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
      ObjectSetFiboDescription(nameObj, i, fitxt100_1[i]); 
     }
  }
//--------------------------------------------------------
// Список стандартных фиб для произвольных вееров. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Список фиб Песавенто для произвольных вееров. Начало.
//--------------------------------------------------------
void screenFibo_Pesavento()
  {
   double   fi_1[]={0.382, 0.5, 0.618, 0.786, 0.886, 1.0, 1.272, phi, 2.0, 2.618};
   string   fitxt100_1[]={"38.2", "50.0", "61.8", "78.6", "88.6", "100.0", "127.2", "161.8", "200.0", "2.618"};
   int i;
   Sizefi_1=10;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
   for (i=0;i<Sizefi_1;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
      ObjectSetFiboDescription(nameObj, i, fitxt100_1[i]); 
     }
  }
//--------------------------------------------------------
// Список фиб Песавенто для произвольных вееров. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод фиб статических. Начало.
//--------------------------------------------------------
void screenFiboS()
  {
   nameObj="fiboS" + ExtComplekt+"_";
   if (mFibo[1]>0)
     {
      if (ExtSave)
        {
         nameObj=nameObj + save;
        }
     }

   screenFibo_(ExtFiboS, "                             ", mFibo[0], mFibo[1]);
  }
//--------------------------------------------------------
// Вывод фиб статических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод фиб динамических. Начало.
//--------------------------------------------------------
void screenFiboD()
  {
   nameObj="fiboD" + ExtComplekt+"_";
   screenFibo_(ExtFiboD, "", 1, 0);
  }
//--------------------------------------------------------
// Вывод фиб динамических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Создание фиб. Начало.
//--------------------------------------------------------
void screenFibo_(color colorFibo, string otstup, int a1, int a2)
  {
   double fibo_0, fibo_100, fiboPrice, fiboPrice1;

   ObjectDelete(nameObj);

   if (!ExtFiboCorrectionExpansion)
     {
      fibo_0=afrx[a1];fibo_100=afrx[a2];
      fiboPrice=afrx[a1]-afrx[a2];fiboPrice1=afrx[a2];
     }
   else
     {
      fibo_100=afrx[a1];fibo_0=afrx[a2];
      fiboPrice=afrx[a2]-afrx[a1];fiboPrice1=afrx[a1];
     }

   if (!ExtFiboCorrectionExpansion)
     {
      ObjectCreate(nameObj,OBJ_FIBO,0,afr[a1],fibo_0,afr[a2],fibo_100);
     }
   else
     {
      ObjectCreate(nameObj,OBJ_FIBO,0,afr[a2],fibo_0,afr[a1],fibo_100);
     }

   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,colorFibo);

   ObjectSet(nameObj,OBJPROP_COLOR,ExtObjectColor);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtObjectStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtObjectWidth);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,ExtFiboStyle);
   ObjectSet(nameObj,OBJPROP_LEVELWIDTH,ExtFiboWidth);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

   if (ExtFiboType==0)
     {
      fibo_standart (fiboPrice, fiboPrice1,"-"+Period_tf+otstup);
     }
   else if (ExtFiboType==1)
     {
      fibo_patterns(fiboPrice, fiboPrice1,"-"+Period_tf+otstup);
     }
   else if (ExtFiboType==2)
     {
      fibo_custom (fiboPrice, fiboPrice1,"-"+Period_tf+otstup);
     }
  }
//--------------------------------------------------------
// Создание фиб. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы стандартные. Начало.
//--------------------------------------------------------
void fibo_standart(double fiboPrice,double fiboPrice1,string fibo)
  {
   double   fi_1[]={0, 0.146, 0.236, 0.382, 0.5, 0.618, 0.764, 0.854, 1.0, 1.236, phi, 2.618, 4.236, 6.854};
   string   fitxt100_1[]={"0.0", "14.6", "23.6", "38.2", "50.0", "61.8", "76.4", "85.4", "100.0", "123.6", "161.8", "2.618", "423.6", "685.4"};
   int i;
   Sizefi_1=14;

   if (!ExtFiboCorrectionExpansion)
     {   
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
      for (i=0;i<Sizefi_1;i++)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
         ObjectSetFiboDescription(nameObj, i, fitxt100_1[i]+" "+DoubleToStr(fiboPrice*fi_1[i]+fiboPrice1, Digits)+fibo); 
        }
     }
   else
     {
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1+2);

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,0);
      ObjectSetFiboDescription(nameObj, 0, "Fe 1 "+DoubleToStr(fiboPrice+fiboPrice1, Digits)+fibo); 

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,1);
      ObjectSetFiboDescription(nameObj, 1, "Fe 0 "+DoubleToStr(fiboPrice1, Digits)+fibo); 

      for (i=1;i<Sizefi_1;i++)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i+2,1+fi_1[i]);
         ObjectSetFiboDescription(nameObj, i+2, "Fe "+fitxt100_1[i]+" "+DoubleToStr(fiboPrice*(1+fi_1[i])+fiboPrice1, Digits)+fibo); 
        }
     }
  }
//--------------------------------------------------------
// Фибы стандартные. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы с паттернами. Начало.
//--------------------------------------------------------
void fibo_patterns(double fiboPrice,double fiboPrice1,string fibo)
  {
   double   fi_1[]={0.0, 0.382, 0.447, 0.5, 0.618, 0.707, 0.786, 0.854, 0.886, 1.0, 1.128, 1.272, 1.414, phi, 2.0, 2.618, 4.236};
   string   fitxt100_1[]={"0.0", "38.2", "44.7", "50.0", "61.8", "70.7", "78.6", "85.4", "88.6", "100.0", "112.8", "127.2", "141.4", "161.8", "200.0", "261.8", "400.0"};
   int i;
   Sizefi_1=17;

   if (!ExtFiboCorrectionExpansion)
     {   
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
      for (i=0;i<Sizefi_1;i++)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
         ObjectSetFiboDescription(nameObj, i, fitxt100_1[i]+" "+DoubleToStr(fiboPrice*fi_1[i]+fiboPrice1, Digits)+fibo); 
        }
     }
   else
     {
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1+2);

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,0);
      ObjectSetFiboDescription(nameObj, 0, "Fe 1 "+DoubleToStr(fiboPrice+fiboPrice1, Digits)+fibo); 

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,1);
      ObjectSetFiboDescription(nameObj, 1, "Fe 0 "+DoubleToStr(fiboPrice1, Digits)+fibo); 

      for (i=1;i<Sizefi_1;i++)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i+2,1+fi_1[i]);
         ObjectSetFiboDescription(nameObj, i+2, "Fe "+fitxt100_1[i]+" "+DoubleToStr(fiboPrice*(1+fi_1[i])+fiboPrice1, Digits)+fibo); 
        }
     }
  }
//--------------------------------------------------------
// Фибы с паттернами. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы пользовательские. Начало.
//--------------------------------------------------------
void fibo_custom(double fiboPrice,double fiboPrice1,string fibo)
  {
   int i;

   if (!ExtFiboCorrectionExpansion)
     {   
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi);
      for (i=0;i<Sizefi;i++)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi[i]);
         ObjectSetFiboDescription(nameObj, i, fitxt100[i]+" "+DoubleToStr(fiboPrice*fi[i]+fiboPrice1, Digits)+fibo); 
        }
     }
   else
     {
      ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi+2);

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,0);
      ObjectSetFiboDescription(nameObj, 0, "Fe 1 "+DoubleToStr(fiboPrice+fiboPrice1, Digits)+fibo); 

      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL,1);
      ObjectSetFiboDescription(nameObj, 1, "Fe 0 "+DoubleToStr(fiboPrice1, Digits)+fibo); 

      for (i=0;i<Sizefi;i++)
        {
         if (fi[i]>0)
           {
            ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i+2,1+fi[i]);
            ObjectSetFiboDescription(nameObj, i+2, "Fe "+fitxt100[i]+" "+DoubleToStr(fiboPrice*(1+fi[i])+fiboPrice1, Digits)+fibo); 
           }
        }
     }
  }
//--------------------------------------------------------
// Фибы пользовательские. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод фибо-дуг статических. Начало.
//--------------------------------------------------------
void screenFiboArcS()
  {
   double fibo_0, fibo_100, AutoScale;

   fibo_0=afrx[mArcS[0]];fibo_100=afrx[mArcS[1]];

   if (ExtArcStaticScale>0)
     {
      AutoScale=ExtArcStaticScale;
     }
   else
     {
      AutoScale=(MathAbs(fibo_0-fibo_100)/Point)/MathAbs(iBarShift(Symbol(),Period(),afr[mArcS[1]])-iBarShift(Symbol(),Period(),afr[mArcS[0]]));
     }

   nameObj="FiboArcS" + ExtComplekt+"_";
   if (ExtSave)
     {
      nameObj=nameObj + save;
     }
   ObjectDelete(nameObj);

   ObjectCreate(nameObj,OBJ_FIBOARC,0,afr[mArcS[0]],fibo_0,afr[mArcS[1]],fibo_100);

   fiboArc(AutoScale, ExtArcStaticColor);
  }
//--------------------------------------------------------
// Вывод фибо-дуг статических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод фибо-дуг динамических. Начало.
//--------------------------------------------------------
void screenFiboArcD()
  {
   double fibo_0, fibo_100, AutoScale;

   fibo_0=afrx[mArcD[0]];fibo_100=afrx[mArcD[1]];

   if (ExtArcDinamicScale>0)
     {
      AutoScale=ExtArcDinamicScale;
     }
   else
     {
      AutoScale=(MathAbs(fibo_0-fibo_100)/Point)/MathAbs(iBarShift(Symbol(),Period(),afr[mArcD[1]])-iBarShift(Symbol(),Period(),afr[mArcD[0]]));
     }

   nameObj="FiboArcD" + ExtComplekt+"_";

   ObjectDelete(nameObj);

   ObjectCreate(nameObj, OBJ_FIBOARC,0,afr[mArcD[0]],fibo_0,afr[mArcD[1]],fibo_100);

   fiboArc(AutoScale, ExtArcDinamicColor);
  }
//--------------------------------------------------------
// Вывод фибо-дуг динамических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы для фибо-дуг. Начало.
//--------------------------------------------------------
void fiboArc(double AutoScale, color ArcColor)
  {
   ObjectSet(nameObj,OBJPROP_SCALE,AutoScale);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   ObjectSet(nameObj,OBJPROP_COLOR,ExtObjectColor);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtObjectStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtObjectWidth);
   ObjectSet(nameObj,OBJPROP_ELLIPSE,true);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ArcColor);
   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,ExtArcStyle);
   ObjectSet(nameObj,OBJPROP_LEVELWIDTH,ExtArcWidth);


   if (ExtFiboType==0)
     {
      fiboArc_st();
     }
   else if (ExtFiboType==1)
     {
      fiboArc_Pesavento();
     }
   else if (ExtFiboType==2)
     {
      fiboArc_custom();
     }
  }
//--------------------------------------------------------
// Фибы для фибо-дуг. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы для стандартных фибо-дуг. Начало.
//--------------------------------------------------------
void fiboArc_st()
  {
   double   fi_1[]={0.0, 0.146, 0.236, 0.382, 0.5, 0.618, 0.764, 0.854, 1.0, 1.236, phi, 2.0, 2.618, 3.0, 4.236, 4.618};
   string   fitxt100_1[]={"0.0", "14.6", "23.6", "38.2", "50.0", "61.8", "76.4", "85.4", "100.0", "123.6", "161.8", "200.0", "261.8", "300.0", "423.6", "461.8"};
   int i;
   Sizefi_1=16;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
   for (i=0;i<Sizefi_1;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
      ObjectSetFiboDescription(nameObj,i,fitxt100_1[i]);
     }
  }
//--------------------------------------------------------
// Фибы для стандартных фибо-дуг. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы для фибо-дуг с числами Песавенто. Начало.
//--------------------------------------------------------
void fiboArc_Pesavento()
  {
   double   fi_1[]={0.0, 0.146, 0.236, 0.382, 0.5, 0.618, 0.786, 0.886, 1.0, 1.272, phi, 2.0, 2.618, 3.0, 4.236, 4.618};
   string   fitxt100_1[]={"0.0", "14.6", "23.6", "38.2", "50.0", "61.8", "78.6", "88.6", "100.0", "127.2", "161.8", "200.0", "261.8", "300.0", "423.6", "461.8"};
   int i;
   Sizefi_1=16;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
   for (i=0;i<Sizefi_1;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
      ObjectSetFiboDescription(nameObj,i,fitxt100_1[i]);
     }
  }
//--------------------------------------------------------
// Фибы для фибо-дуг с числами Песавенто. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Фибы для пользовательских фибо-дуг. Начало.
//--------------------------------------------------------
void fiboArc_custom()
  {
   int i;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi);
   for (i=0;i<Sizefi;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi[i]);
      ObjectSetFiboDescription(nameObj,i,fitxt100[i]);
     }
  }
//--------------------------------------------------------
// Фибы для пользовательских фибо-дуг. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
//  Функции для рисования золотой спирали. Начало.
//--------------------------------------------------------
void GoldenSpiral(datetime t2,double p2,datetime t4,double p4) 
 {
// In polar coordinates the basic spiral equation is:
// r = a * e ^ (Theta * cot Alpah)
// for golden spiral: cot Alpha = 2/pi * ln(phi)
   
   double startAngle; // угол в радианах(in radians)

   startAngle=MathArctan(((p4-p2)/Point)/((iBarShift(NULL,0,t4,false)-iBarShift(NULL,0,t2,false))*Scale()));

//----  
   double cotAlpha = (1/(2 * goldenSpiralCycle *pi)) * MathLog(phi);
   double r0 = (iBarShift(NULL,0,t4,false)-iBarShift(NULL,0,t2,false))/MathCos(startAngle);
   double r1=1.0/MathExp(startAngle * cotAlpha);
   double a = 0;
   double x1 = 0;
   double y1 = 0;
//----   
   for(int i = 0; i < NumberOfLines; i++)
     {
      double Theta =startAngle + a * pi / 4;
      double r = r0*r1 * MathExp(Theta * cotAlpha);
      //----
      if (clockWiseSpiral == false){Theta = startAngle - a * pi / 4;}
      //----      
      double x2 = r * MathCos(Theta);
      double y2 = r * MathSin(Theta);
      a += accurity;
      //----     
      string label = "Spiral_"+"_"+ExtComplekt+"_"+i;
      DrawLine(x1, y1, x2, y2,t2,p2,t4,p4,label);
      //----              
      x1 = x2;
      y1 = y2;
     }
 }

   
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawLine(double x1, double y1, double x2, double y2,datetime t2,double p2,datetime t4,double p4, string label)
  {
   int Shift_1 = iBarShift(NULL, 0, t4, false);
   int Shift_2 = iBarShift(NULL, 0, t2, false);

//----   
   int timeShift1 = Shift_2 + MathRound(x1);
   int timeShift2 = Shift_2 + MathRound(x2);
//----   
   double price1 = p2 + NormalizeDouble(y1* Scale() * Point, Digits);
   double price2 = p2 + NormalizeDouble(y2* Scale() * Point, Digits);
//----   
   if((x2 >= 0 && y2 >= 0) || (x2 <= 0 && y2 <= 0))
       color lineColor = spiralColor1;
   else
       lineColor = spiralColor2;
   ObjectDelete(label);
   ObjectCreate(label, OBJ_TREND, 0, GetTime(timeShift1), price1, GetTime(timeShift2), price2, 0, 0);
   ObjectSet(label, OBJPROP_RAY, 0);
   ObjectSet(label, OBJPROP_COLOR, lineColor);
   ObjectSet(label, OBJPROP_STYLE, ExtSpiralStyle);
   ObjectSet(label, OBJPROP_WIDTH, ExtSpiralWidth);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime GetTime(int timeShift)
  {
   if(timeShift >= 0)
      return(Time[timeShift]);
   datetime time = Time[0] - Period()*timeShift*60;
   return(time);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Scale()
{
   double priceRange = WindowPriceMax(0) - WindowPriceMin(0);
   double barsCount = WindowBarsPerChart();
   double chartScale = (priceRange / Point) / barsCount;
   return(chartScale*GPixels/VPixels);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//--------------------------------------------------------
// Функции для рисования золотой спирали. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод фибо-вееров статических. Начало.
//--------------------------------------------------------
void screenFiboFanS()
  {
   double fiboPrice1, fiboPrice2;

   nameObj="fiboFanS" + ExtComplekt+"_";
   ObjectDelete(nameObj);

   if (ExtPitchforkCandle)
     {
      if (ExtPitchfork_1_HighLow)
        {
         fiboPrice1=mPitchCena[1];fiboPrice2=mPitchCena[2];
        }
      else 
        {
         fiboPrice1=mPitchCena[1];fiboPrice2=mPitchCena[2];
        }
      ObjectCreate(nameObj,OBJ_FIBOFAN,0,mPitchTime[1],fiboPrice1,mPitchTime[2],fiboPrice2);
     }
   else
     {
      if (afrl[mPitch[1]]>0) 
        {
         fiboPrice1=afrl[mPitch[1]];fiboPrice2=afrh[mPitch[2]];
        }
      else 
        {
         fiboPrice1=afrh[mPitch[1]];fiboPrice2=afrl[mPitch[2]];
        }
      ObjectCreate(nameObj,OBJ_FIBOFAN,0,afr[mPitch[1]],fiboPrice1,afr[mPitch[2]],fiboPrice2);
     }

   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboFanS);

   FiboFanLevel();

  }
//--------------------------------------------------------
// Вывод фибо-вееров статических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод фибо-вееров динамических. Начало.
//--------------------------------------------------------
void screenFiboFanD()
  {
   double fiboPrice1, fiboPrice2;

   nameObj="fiboFanD" + ExtComplekt+"_";

   ObjectDelete(nameObj);

   fiboPrice1=afrx[1];fiboPrice2=afrx[0];

   ObjectCreate(nameObj,OBJ_FIBOFAN,0,afr[1],fiboPrice1,afr[0],fiboPrice2);
   ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboFanD);

   FiboFanLevel();
  }
//--------------------------------------------------------
// Вывод фибо-вееров динамических. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Уровни фибо-вееров. Конец.
//--------------------------------------------------------
void FiboFanLevel()
  {
   if(ExtFiboFanExp) ObjectSet(nameObj,OBJPROP_FIBOLEVELS,6); else ObjectSet(nameObj,OBJPROP_FIBOLEVELS,4);

   ObjectSet(nameObj,OBJPROP_COLOR,ExtObjectColor);
   ObjectSet(nameObj,OBJPROP_STYLE,ExtObjectStyle);
   ObjectSet(nameObj,OBJPROP_WIDTH,ExtObjectWidth);

   ObjectSet(nameObj,OBJPROP_LEVELSTYLE,STYLE_DASH);
   ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+0,0.236);
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+1,0.382);
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+2,0.5);
   ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+3,phi-1);

   if (ExtFiboFanHidden)
     {
      ObjectSetFiboDescription(nameObj, 0, "23.6"); 
      ObjectSetFiboDescription(nameObj, 1, "38.2"); 
      ObjectSetFiboDescription(nameObj, 2, "50.0"); 
      ObjectSetFiboDescription(nameObj, 3, "61.8"); 
     }
   if(ExtFiboFanExp)
     {
      if (ExtFiboType==0)
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+4,0.764);
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+5,0.854);

         if (ExtFiboFanHidden)
           {
            ObjectSetFiboDescription(nameObj, 4, "76.4"); 
            ObjectSetFiboDescription(nameObj, 5, "85.4"); 
           }
        }
      else
        {
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+4,0.786);
         ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+5,0.886);

         if (ExtFiboFanHidden)
           {
            ObjectSetFiboDescription(nameObj, 4, "78.6"); 
            ObjectSetFiboDescription(nameObj, 5, "88.6"); 
           }
        }
     }
  }
//--------------------------------------------------------
//  Уровни фибо-вееров. Начало.
//--------------------------------------------------------

//--------------------------------------------------------
// Вывод расширений Фибоначчи. Начало.
//--------------------------------------------------------
void FiboExpansion()
  {
   if (ExtFiboExpansion>1)
     {
      int i;
      double znach1,znach2,fi_1[];

      nameObj="fiboExpansion" + ExtComplekt+"_";
      if (mExpansion[2]>0)
        {
         if (ExtSave)
           {
            nameObj=nameObj + save;
           }
        }

      ObjectDelete(nameObj);
      if (afrl[mExpansion[0]]>0)
        {
         ObjectCreate(nameObj,OBJ_EXPANSION,0,afr[mExpansion[0]],afrl[mExpansion[0]],afr[mExpansion[1]],afrh[mExpansion[1]],afr[mExpansion[2]],afrl[mExpansion[2]]);
         znach1=afrh[mExpansion[1]]-afrl[mExpansion[0]];
         znach2=afrl[mExpansion[2]];
        }
      else
        {
         ObjectCreate(nameObj,OBJ_EXPANSION,0,afr[mExpansion[0]],afrh[mExpansion[0]],afr[mExpansion[1]],afrl[mExpansion[1]],afr[mExpansion[2]],afrh[mExpansion[2]]);
         znach1=-(afrh[mExpansion[0]]-afrl[mExpansion[1]]);
         znach2=afrh[mExpansion[2]];
        }

      ObjectSet(nameObj,OBJPROP_COLOR,ExtObjectColor);
      ObjectSet(nameObj,OBJPROP_STYLE,ExtObjectStyle);
      ObjectSet(nameObj,OBJPROP_WIDTH,ExtObjectWidth);
      ObjectSet(nameObj,OBJPROP_LEVELCOLOR,ExtFiboExpansionColor);
      ObjectSet(nameObj,OBJPROP_LEVELSTYLE,ExtExpansionStyle);
      ObjectSet(nameObj,OBJPROP_LEVELWIDTH,ExtExpansionWidth);
      ObjectSet(nameObj,OBJPROP_BACK,ExtBack);

      if (ExtFiboType==0)
        {
         FiboExpansion_st(znach1, znach2);
        }
      else if (ExtFiboType==1)
        {
         FiboExpansion_Pesavento(znach1, znach2);
        }
      else if (ExtFiboType==2)
        {
         ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi);
         for (i=0;i<Sizefi;i++)
           {
            ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi[i]);
            ObjectSetFiboDescription(nameObj, i, "FE "+fitxt100[i]+" "+DoubleToStr(znach1*fi[i]+znach2, Digits)+"-"+Period_tf); 
           }
        }
     }
  }
//--------------------------------------------------------
// Вывод расширений Фибоначчи. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Значения стандартных фиб для расширений Фибоначчи. Начало.
//--------------------------------------------------------
void FiboExpansion_st(double znach1, double znach2)
  {
   int i;
   double fi_1[]={0.236, 0.382, 0.5, 0.618, 0.764, 0.854, 1.0, 1.236, phi, 2.0, 2.618};
   string tf="-"+Period_tf, fitxt100_1[]={"23.6", "38.2", "50.0", "61.8", "76.4", "85.4", "100.0", "123.6", "161.8", "200.0", "261.8"};
   Sizefi_1=11;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
   for (i=0;i<Sizefi_1;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
      ObjectSetFiboDescription(nameObj, i, "FE "+fitxt100_1[i]+" "+DoubleToStr(znach1*fi_1[i]+znach2, Digits)+tf); 
     }
  }
//--------------------------------------------------------
// Значения стандартных фиб для расширений Фибоначчи. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Значения фиб Песавенто для расширений Фибоначчи. Начало.
//--------------------------------------------------------
void FiboExpansion_Pesavento(double znach1, double znach2)
  {
   int i;
   double fi_1[]={0.382, 0.5, 0.618, 0.707, 0.786, 0.886, 1.0, 1.272, 1.414, phi, 2.0, 2.618, 3.0, 4.236, 4.618};
   string tf="-"+Period_tf, fitxt100_1[]={"38.2", "50.0", "61.8", "70.7", "78.6", "88.6", "100.0", "127.2", "141.4", "161.8", "200.0", "261.8", "300.0", "423.6", "461.8"};
   Sizefi_1=15;

   ObjectSet(nameObj,OBJPROP_FIBOLEVELS,Sizefi_1);
   for (i=0;i<Sizefi_1;i++)
     {
      ObjectSet(nameObj,OBJPROP_FIRSTLEVEL+i,fi_1[i]);
      ObjectSetFiboDescription(nameObj, i, "FE "+fitxt100_1[i]+" "+DoubleToStr(znach1*fi_1[i]+znach2, Digits)+tf); 
     }
  }
//--------------------------------------------------------
// Значения фиб Песавенто для расширений Фибоначчи. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление соединительных линий и чисел.
//--------------------------------------------------------
void delete_objects1()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"_" + ExtComplekt + "pl")>-1) ObjectDelete (txt);
      if (StringFind(txt,"_" + ExtComplekt + "ph")>-1) ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление соединительных линий и чисел.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление соединительных линий и чисел.
//--------------------------------------------------------
void delete_objects2(string txt1)
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,txt1)>-1)ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление соединительных линий и чисел.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление объектов паттернов Gartley.
//--------------------------------------------------------
void delete_objects3()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"_"+ExtComplekt+"Triangle")>-1)ObjectDelete (txt);

      if (RangeForPointD>0)
        {
         if (StringFind(txt,"_"+ExtComplekt+"PointD")>-1)ObjectDelete (txt);
         if (StringFind(txt,"_"+ExtComplekt+"PDL")>-1)ObjectDelete (txt);
        }

      if (VectorOfAMirrorTrend>0) if (StringFind(txt,"_"+ExtComplekt+"VectorOfAMirrorTrend")>-1) ObjectDelete (txt);

      ArrayInitialize(PeakCenaX,0);
      ArrayInitialize(PeakCenaA,0);
      ArrayInitialize(PeakCenaB,0);
      ArrayInitialize(PeakCenaC,0);
      ArrayInitialize(PeakCenaD,0);

      ArrayInitialize(PeakTimeX,0);
      ArrayInitialize(PeakTimeA,0);
      ArrayInitialize(PeakTimeB,0);
      ArrayInitialize(PeakTimeC,0);
      ArrayInitialize(PeakTimeD,0);
     }

   if (RangeForPointD>0)
     {
      FlagForD=true;
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление объектов паттернов Gartley.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление соединительных линий и чисел.
//--------------------------------------------------------
void delete_objects4()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"_" + ExtComplekt + "pg")>-1) ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление соединительных линий и чисел.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление Equilibrium.
//--------------------------------------------------------
void delete_objects5()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"_"+ExtComplekt+"Equilibrium")>-1)ObjectDelete (txt);
      else if (StringFind(txt,"_"+ExtComplekt+"Reaction")>-1)ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление Equilibrium.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление статических меток в вилах Эндрюса.
//--------------------------------------------------------
void delete_objects6()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"m#"+ExtComplekt+"_"+"s")>-1) ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление статических меток в вилах Эндрюса.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление динамических меток в вилах Эндрюса.
//--------------------------------------------------------
void delete_objects7()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"m#"+ExtComplekt+"_"+"d")>-1) ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление динамических меток в вилах Эндрюса.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление сигнальной метки APm.
//--------------------------------------------------------
 
void delete_objects8()
  {
   int i, i_APm=0, count_APm=0;
   string txt;

   if (!ObjectFind(nameCheckLabel)==0) return;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      // подсчет колическтва вил с меткой APm
      if (ObjectType(txt)==OBJ_PITCHFORK)
        {
         if (StringFind(txt,"_APm",0)>0) i_APm++;
        }
     }

   ObjectDelete(nameCheckLabel_hidden);
   if (i_APm>1)
     {
      if (ObjectFind(nameCheckLabel)==0)
        {
         // Проверка положения сигнальной метки APm
         if (ObjectGet(nameCheckLabel,OBJPROP_XDISTANCE)!=vX || ObjectGet(nameCheckLabel,OBJPROP_YDISTANCE)!=vY)
           {
            count_APm=(i_APm-1)*2;
           }
         else
           {
            count_APm=i_APm;
           }

         ObjectCreate(nameCheckLabel_hidden,OBJ_TEXT,0,0,0);

         ObjectSetText(nameCheckLabel_hidden,""+i_APm+"_"+count_APm);
         ObjectSet(nameCheckLabel_hidden, OBJPROP_COLOR, CLR_NONE);
         ObjectSet(nameCheckLabel_hidden, OBJPROP_BACK, true);
        }
     }

   if (i_APm>0)
     {
      ObjectDelete(nameCheckLabel);
      ObjectCreate(nameCheckLabel,OBJ_LABEL,0,0,0);

      ObjectSetText(nameCheckLabel,"APm");
      ObjectSet(nameCheckLabel, OBJPROP_FONTSIZE, 10);
      ObjectSet(nameCheckLabel, OBJPROP_COLOR, Red);

      ObjectSet(nameCheckLabel, OBJPROP_CORNER, 1);
      ObjectSet(nameCheckLabel, OBJPROP_XDISTANCE, vX+2);
      ObjectSet(nameCheckLabel, OBJPROP_YDISTANCE, vY);
     }
   else ObjectDelete(nameCheckLabel);
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление сигнальной метки APm.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление инструментов вил, созданных вручную.
//--------------------------------------------------------
 
void delete_objects9()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"pmediana_" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"SLM382_" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"SLM618_" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"ISL_" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"UTL" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"LTL" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"UWL" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"LWL" + ExtComplekt+"_")>-1) ObjectDelete(txt);
      if (StringFind(txt,"FSL Shiff Lines S_" + ExtComplekt+"_")>-1) ObjectDelete(txt);

     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление инструментов вил, созданных вручную.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление спирали.
//--------------------------------------------------------
void delete_objects_spiral()
  {
   int i;

   for(i=0;i<NumberOfLines;i++)
     {
      ObjectDelete("Spiral_"+"_"+ExtComplekt+"_"+i);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление спирали.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление объектов. Начало.
// Удаление номеров переломов зигзага.
//--------------------------------------------------------
void delete_objects_number()
  {
   int i;
   string txt;

   for (i=ObjectsTotal()-1; i>=0; i--)
     {
      txt=ObjectName(i);
      if (StringFind(txt,"NumberPeak" + "_" + ExtComplekt + "_")>-1) ObjectDelete (txt);
     }
  }
//--------------------------------------------------------
// Удаление объектов. Конец.
// Удаление номеров переломов зигзага.
//--------------------------------------------------------

//--------------------------------------------------------
// Удаление динамических объектов. Начало.
//--------------------------------------------------------
void delete_objects_dinamic()
  {
   int i;
   
   ObjectDelete("fiboD" + ExtComplekt+"_");
   ObjectDelete("fiboFanD" + ExtComplekt+"_");
   ObjectDelete("RLineD" + ExtComplekt+"_");
   ObjectDelete("pitchforkD" + ExtComplekt+"_");
   ObjectDelete("Master_pitchforkD" + ExtComplekt+"_");
   ObjectDelete("ISL_D" + ExtComplekt+"_");
   ObjectDelete("RZD" + ExtComplekt+"_");
   ObjectDelete("pmedianaD" + ExtComplekt+"_");
   ObjectDelete("1-2pmedianaD" + ExtComplekt+"_");
   ObjectDelete("SLM382D" + ExtComplekt+"_");
   ObjectDelete("SLM618D" + ExtComplekt+"_");
   ObjectDelete("FSL Shiff Lines D" + ExtComplekt+"_");
   ObjectDelete("fiboExpansion" + ExtComplekt+"_");
   ObjectDelete("PivotZoneD" + ExtComplekt+"_");
   ObjectDelete("FanMedianaDinamic" + ExtComplekt+"_");
   ObjectDelete("FiboArcD" + ExtComplekt+"_");
   if (ExtPivotZZ1Num==1) ObjectDelete("LinePivotZZ" + "1" + ExtComplekt+"_");
   if (ExtPivotZZ2Num==1) ObjectDelete("LinePivotZZ" + "2" + ExtComplekt+"_");

   for (i=0; i<7; i++)
     {
      nameObj="VLD"+i+" " + ExtComplekt+"_";
      ObjectDelete(nameObj);
     }
  }
//--------------------------------------------------------
// Удаление динамических объектов. Конец.
//--------------------------------------------------------

//----------------------------------------------------
//  ZigZag (из МТ4 немного измененный). Начало.
//----------------------------------------------------
void ZigZag_()
  {
//  ZigZag из МТ. Начало.
   if (ExtMaxBar>0) _maxbarZZ=ExtMaxBar; else _maxbarZZ=Bars;
   int    shift, back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;
   int    vDepth = 0;
   bool   endCyklDirection=true;

   if (ExtIndicator==11)
     {
      bool     endCykl=false;
      Depth    = minDepth;
      if (ExtGartleyTypeSearch!=2) countGartley = 0;
      countColor   = 0;
      if (flagExtGartleyTypeSearch2==false) {delete_objects3(); vPatOnOff = 0;}

      if (ExtGartleyTypeSearch>0 && ExtHiddenPP==2 && flagExtGartleyTypeSearch2==false) delete_objects4();
     }
   else
     {
      Depth    = minBars;
      minDepth = minBars;
      maxDepth = minBars;
     }

   if (DirectionOfSearchMaxMin) vDepth = maxDepth; else vDepth = minDepth;

   while (endCyklDirection)
     {

      if (ExtIndicator==11)
        {
         if (ExtLabel>0) {ArrayInitialize(la,0.0); ArrayInitialize(ha,0.0);}
         ArrayInitialize(zz,0);ArrayInitialize(zzL,0);ArrayInitialize(zzH,0);

         if (DirectionOfSearchMaxMin)
           {
            if (vDepth < minDepth)
              {
               if (ExtGartleyTypeSearch>0 && ExtIndicator==11 && vPatOnOff==1) vDepth=minBarsToNumberPattern;
               else vDepth=minBars;
               endCykl=true;
              }
           }
         else
           {
            if (vDepth > maxDepth)
              {
               if (ExtGartleyTypeSearch>0 && ExtIndicator==11 && vPatOnOff==1) vDepth=minBarsToNumberPattern;
               else vDepth=minBars;
               endCykl=true;
              }
           }

         Depth = vDepth;

         if (DirectionOfSearchMaxMin)
           {
            vDepth-=IterationStep;
           }
         else
           {
            vDepth+=IterationStep;
           }

         if (flagExtGartleyTypeSearch2 && ExtGartleyTypeSearch==2 && vPatOnOff==1) {endCykl=true; Depth=minBarsToNumberPattern;}
        }
      else
        {
         endCyklDirection=false;
        }

      minBarsX=Depth;
      
      // первый большой цикл
      for(shift=_maxbarZZ-Depth; shift>=ExtMinBar; shift--)
        {
         val=Low[iLowest(NULL,0,MODE_LOW,Depth,shift)];
         if(val==lastlow) val=0.0;
         else 
           { 
            lastlow=val; 
            if((Low[shift]-val)>(ExtDeviation*Point)) val=0.0;
            else
              {
               for(back=1; back<=ExtBackstep; back++)
                 {
                  res=zzL[shift+back];
                  if((res!=0)&&(res>val)) zzL[shift+back]=0.0; 
                 }
              }
           } 
          if (Low[shift]==val) 
            {
             zzL[shift]=val;
             if (ExtLabel>0) la[shift]=val;
            }

          val=High[iHighest(NULL,0,MODE_HIGH,Depth,shift)];
          if(val==lasthigh) val=0.0;
          else 
            {
             lasthigh=val;
             if((val-High[shift])>(ExtDeviation*Point)) val=0.0;
             else
               {
                for(back=1; back<=ExtBackstep; back++)
                  {
                   res=zzH[shift+back];
                   if((res!=0)&&(res<val)) zzH[shift+back]=0.0; 
                  } 
               }
            }
          if (High[shift]==val)
            {
             zzH[shift]=val;
             if (ExtLabel>0) ha[shift]=val;
            }
        }

      // второй большой цикл 
      lasthigh=-1; lasthighpos=-1;
      lastlow=-1;  lastlowpos=-1;

      for(shift=_maxbarZZ-Depth; shift>=ExtMinBar; shift--)
        {
         curlow=zzL[shift];
         curhigh=zzH[shift];
         if((curlow==0)&&(curhigh==0)) continue;

         if(curhigh!=0)
           {
            if(lasthigh>0) 
              {
               if(lasthigh<curhigh) zzH[lasthighpos]=0;
               else zzH[shift]=0;
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
               if(lastlow>curlow) zzL[lastlowpos]=0;
               else zzL[shift]=0;
              }

            if((curlow<lastlow)||(lastlow<0))
              {
               lastlow=curlow;
               lastlowpos=shift;
              } 
            lasthigh=-1;
           }
        }
      // третий большой цикл
      for(shift=_maxbarZZ-1; shift>=ExtMinBar; shift--)
        {
         zz[shift]=zzL[shift];
         if(shift>=_maxbarZZ-Depth) {zzH[shift]=0.0; zzL[shift]=0.0; zz[shift]=0.0;}
         else
           {
            res=zzH[shift];
            if(res!=0.0)
              {
               zz[shift]=res;
              }
           }
        }

      NoGorb(Depth); // удаляем горбы зигзага

      if (ExtIndicator!=11 && ExtLabel>0)  // расставляем метки на барах, где появился новый луч и на переломах зигзага
        {
         Metka();
        }

      // поиск паттернов
      if (ExtIndicator==11)
        {
         if (ExtLabel>0)  // расставляем метки на барах, где появился новый луч и на переломах зигзага
           {
            Metka();
           }

         if (endCykl)
           {
            return(0);
           }

         _Gartley("ExtIndicator=11_" + Depth+"/"+ExtDeviation+"/"+ExtBackstep, Depth);

         if (ExtGartleyTypeSearch==0 && vPatOnOff==1)
           {
            return(0);
           }
        }  // поиск паттернов конец
     }
  }
//--------------------------------------------------------
// ZigZag из МТ. Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Исправление возникающих горбов зигзага. Начало.
//--------------------------------------------------------
void NoGorb(int Depth)
  {
   double vel1, vel2, vel3, vel4;
   int bar1, bar2, bar3, bar4;
   int count;
   for(int bar=Bars-Depth; bar>=0; bar--)
     {
      if (zz[bar]!=0)
        {
         count++;
         vel4=vel3;bar4=bar3;
         vel3=vel2;bar3=bar2;
         vel2=vel1;bar2=bar1;
         vel1=zz[bar];bar1=bar;
         if (count<3) continue; 
         if ((vel3<vel2)&&(vel2<vel1)) {zz[bar2]=0;zzL[bar2]=0;zzH[bar2]=0;bar=bar3+1;}
         if ((vel3>vel2)&&(vel2>vel1)) {zz[bar2]=0;zzL[bar2]=0;zzH[bar2]=0;bar=bar3+1;}
         if ((vel2==vel1)&&(vel1!=0 )) {zz[bar1]=0;zzL[bar1]=0;zzH[bar1]=0;bar=bar3+1;}
        }
    } 
  }
//--------------------------------------------------------
// Исправление возникающих горбов зигзага. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Расстановка меток. Начало.
//--------------------------------------------------------
void Metka()
  {
   int shift, metka=0; // =0 - до первого перелома ZZ. =1 - ищем метки максимумов. =2 - ищем метки минимумов.
   for(shift=Bars-1; shift>=0; shift--)
     {
      if (zz[shift]>0)
        {
         if (zzH[shift]>0)
           {
            metka=2; la[shift]=0; shift--;
           }
         else
           {
            metka=1; ha[shift]=0; shift--;
           }
        }

      if (metka==0)
        {
         ha[shift]=0; la[shift]=0;
        }
      else if (metka==1)
        {
         if (ha[shift]>0) metka=0;
         la[shift]=0;
        }
      else if (metka==2)
        {
         if (la[shift]>0) metka=0;
         ha[shift]=0;
        }
     }
  }
//--------------------------------------------------------
// Расстановка меток. Конец.
//--------------------------------------------------------

//--------------------------------------------------------
// Поиск паттернов Gartley. Начало.
//--------------------------------------------------------
void _Gartley(string _Depth, int Depth)
  {
   int  i, j, k, m, shift;

   double   min_DeltaGartley = (1 - ExtDeltaGartley);
   double   max_DeltaGartley = (1 + ExtDeltaGartley);
   double   vl0382 = min_DeltaGartley * (2-phi);
   double   vh05   = max_DeltaGartley * 0.5;
   double   vl0618 = min_DeltaGartley * (phi-1);
   double   vh0618 = max_DeltaGartley * (phi-1);
   double   vl0786 = min_DeltaGartley * 0.786;
   double   vh0786 = max_DeltaGartley * 0.786;
   double   vl0886 = min_DeltaGartley * 0.886;
   double   vh0886 = max_DeltaGartley * 0.886;
   double   vl1128 = min_DeltaGartley * 1.128;
   double   vh1128 = max_DeltaGartley * 1.128;
   double   vl1272 = min_DeltaGartley * 1.272;
   double   vl1618 = min_DeltaGartley * phi;
   double   vh1618 = max_DeltaGartley * phi;
   double   vl2236 = min_DeltaGartley * 2.236;
   double   vh2236 = max_DeltaGartley * 2.236;
   double   vh2618 = max_DeltaGartley * (phi+1);
   double   vh3618 = max_DeltaGartley * (phi+2);

   double   LevelDA1382,LevelDA1618,LevelDA2,LevelDA2618,LevelDA3618,LevelDA4618,LevelDC1382,LevelDC1618,LevelDC2,LevelDC2618,LevelDC3618,LevelDC4618;
   double   LevelForD;
   datetime timeLineD;
   double   bartoD;
   double   vlXB=0, vhXB=0, vlAC=0, vhAC=0, vlBD=0, vhBD=0, vlXD=0, vhXD=0;

   int      aXABCD[5]; // номера баров с точками XABCD пятиточечных паттернов
   double   retXD;
   double   retXB;
   double   retBD;
   double   retAC;
   double   XA, BC, XC, BD;
   
   double   vDelta0 = 0.000001;
   int      vNull   = 0;
   int      X=0,A=1,B=2,C=3,D=4;
   string   nameObj1, nameObj2;
   bool     vClassic   = false;
   bool     vSharkPattern  = false;
   string   vBull      = "Bullish";
   string   vBear      = "Bearish";
   string   vGartley   = "Gartley";
   string   vBat       = "Bat";
   string   vButterfly = "Butterfly";
   string   vCrab      = "Crab";
   string   vCustom    = "Custom";
   string   vShark     = "Shark";
   int      aNumBarPeak[];
   double   tangensXB;

   color    colorPattern;

   if (ExtIndicator!=11)    delete_objects3();

   if ((ExtGartleyTypeSearch==0 && ExtIndicator==11) || ExtIndicator!=11) vPatOnOff = 0;
   maxPeak      = 0;

   ArrayResize(aNumBarPeak, ArraySize(zz));
   for(shift=0; shift<_maxbarZZ; shift++)
     {
      if (zz[shift]>0) {aNumBarPeak[maxPeak] = shift; maxPeak++;}
     }

   ArrayResize(aNumBarPeak, maxPeak);

   if (ExtIndicator>5 && ExtIndicator<11 && GrossPeriod>Period())
     {
      bartoD=maxBarToD;
     }
   else
     {
      if (patternInfluence)
        {
         bartoD=AllowedBandPatternInfluence*(aNumBarPeak[4]-aNumBarPeak[0]);
        }
      else
        {
         bartoD=maxBarToD;
        }
     }

   aXABCD[D] = aNumBarPeak[0];
   k = 0;
   while (k < maxPeak-5 && aXABCD[D] < bartoD+2)
     {
      vBullBear    = "";
      vNamePattern = "";
      aXABCD[X] = aNumBarPeak[k + 4];
      aXABCD[A] = aNumBarPeak[k + 3];
      aXABCD[B] = aNumBarPeak[k + 2];
      aXABCD[C] = aNumBarPeak[k + 1];
      aXABCD[D] = aNumBarPeak[k];

      // Classic
      if (CustomPattern<3)
        {
         // определяем направление паттерна - Bull или Bear
         if ((zz[aXABCD[A]] > zz[aXABCD[C]]) && (zz[aXABCD[C]] > zz[aXABCD[B]]) && (zz[aXABCD[B]] > zz[aXABCD[X]]) && (zz[aXABCD[X]] > zz[aXABCD[D]]) && ((zz[aXABCD[C]] - zz[aXABCD[D]]) >= (zz[aXABCD[A]] - zz[aXABCD[B]]) * ExtCD))
           {
            vBullBear = vBull;
           }
         else if ((zz[aXABCD[A]] > zz[aXABCD[C]]) && (zz[aXABCD[C]] > zz[aXABCD[B]]) && (zz[aXABCD[B]] > zz[aXABCD[D]]) && (zz[aXABCD[D]] > zz[aXABCD[X]]) && ((zz[aXABCD[C]] - zz[aXABCD[D]]) >= (zz[aXABCD[A]] - zz[aXABCD[B]]) * ExtCD))
           {
            vBullBear = vBull;
           }
         else if ((zz[aXABCD[X]] > zz[aXABCD[D]]) && (zz[aXABCD[D]] > zz[aXABCD[B]]) && (zz[aXABCD[B]] > zz[aXABCD[C]]) && (zz[aXABCD[C]] > zz[aXABCD[A]]) && ((zz[aXABCD[D]] - zz[aXABCD[C]]) >= (zz[aXABCD[B]] - zz[aXABCD[A]]) * ExtCD))
           {
            vBullBear = vBear;
           }
         else if ((zz[aXABCD[D]] > zz[aXABCD[X]]) && (zz[aXABCD[X]] > zz[aXABCD[B]]) && (zz[aXABCD[B]] > zz[aXABCD[C]]) && (zz[aXABCD[C]] > zz[aXABCD[A]]) && ((zz[aXABCD[D]] - zz[aXABCD[C]]) >= (zz[aXABCD[B]] - zz[aXABCD[A]]) * ExtCD))
           {
            vBullBear = vBear;
           }

         // определяем ретресменты
         if (vBullBear == vBull)
           {
            retXB = (zz[aXABCD[A]] - zz[aXABCD[B]]) / (zz[aXABCD[A]] - zz[aXABCD[X]] + vDelta0);
            retXD = (zz[aXABCD[A]] - zz[aXABCD[D]]) / (zz[aXABCD[A]] - zz[aXABCD[X]] + vDelta0);
            retBD = (zz[aXABCD[C]] - zz[aXABCD[D]]) / (zz[aXABCD[C]] - zz[aXABCD[B]] + vDelta0);
            retAC = (zz[aXABCD[C]] - zz[aXABCD[B]]) / (zz[aXABCD[A]] - zz[aXABCD[B]] + vDelta0);
            if (RangeForPointD>0 && FlagForD)
              {
               XA=zz[aXABCD[A]] - zz[aXABCD[X]];
               BC=zz[aXABCD[C]] - zz[aXABCD[B]];
              }
           }
         else if (vBullBear == vBear)
           {
            retXB = (zz[aXABCD[B]] - zz[aXABCD[A]]) / (zz[aXABCD[X]] - zz[aXABCD[A]] + vDelta0);
            retXD = (zz[aXABCD[D]] - zz[aXABCD[A]]) / (zz[aXABCD[X]] - zz[aXABCD[A]] + vDelta0);
            retBD = (zz[aXABCD[D]] - zz[aXABCD[C]]) / (zz[aXABCD[B]] - zz[aXABCD[C]] + vDelta0);
            retAC = (zz[aXABCD[B]] - zz[aXABCD[C]]) / (zz[aXABCD[B]] - zz[aXABCD[A]] + vDelta0);
            if (RangeForPointD>0 && FlagForD)
              {
               XA=zz[aXABCD[X]] - zz[aXABCD[A]];
               BC=zz[aXABCD[B]] - zz[aXABCD[C]];
              }
           }

         // определяем наименование паттерна
         if (StringLen(vBullBear)>0)
           {
            if (retAC >= vl0382 && retAC <= vh0886 && retXD >= vl0618 && retXD <= vh0786 && retBD >= vl1128 && retBD <= vh2236 && retXB >= vl0382 && retXB <= vh0618)
              {
               vNamePattern=vGartley; // Gartley
               if (RangeForPointD>0 && FlagForD)
                 {
                  if (vBullBear == vBull)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]-XA*vh0786,zz[aXABCD[C]]-BC*vh2236);
                     LevelForDmax = MathMin(zz[aXABCD[A]]-XA*vl0618,zz[aXABCD[C]]-BC*vl1128);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*phi;
                        LevelDA2      = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*2;
                        LevelDA2618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*phi;
                        LevelDC2      = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*2;
                        LevelDC2618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(3+phi);
                       }
                    }
                  else if (vBullBear == vBear)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]+XA*vl0618,zz[aXABCD[C]]+BC*vl1128);
                     LevelForDmax = MathMin(zz[aXABCD[A]]+XA*vh0786,zz[aXABCD[C]]+BC*vh2236);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*phi;
                        LevelDA2      = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*2;
                        LevelDA2618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*phi;
                        LevelDC2      = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*2;
                        LevelDC2618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(3+phi);
                       }
                    }
                 }
              }
            else if (retAC >= vl0382 && retAC <= vh0886 && retXD >= vl1272 && retXD <= vh1618 && retBD >= vl1272 && retBD <= vh2618 && retXB >= vl0618 && retXB <= vh0886)
              {
               vNamePattern=vButterfly; // Butterfly
               if (RangeForPointD>0 && FlagForD)
                 {
                  if (vBullBear == vBull)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]-XA*vh1618,zz[aXABCD[C]]-BC*vh2618);
                     LevelForDmax = MathMin(zz[aXABCD[A]]-XA*vl1272,zz[aXABCD[C]]-BC*vl1272);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*phi;
                        LevelDA2      = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*2;
                        LevelDA2618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*phi;
                        LevelDC2      = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*2;
                        LevelDC2618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(3+phi);
                       }
                    }
                  else if (vBullBear == vBear)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]+XA*vl1272,zz[aXABCD[C]]+BC*vl1272);
                     LevelForDmax = MathMin(zz[aXABCD[A]]+XA*vh1618,zz[aXABCD[C]]+BC*vh2618);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*phi;
                        LevelDA2      = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*2;
                        LevelDA2618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*phi;
                        LevelDC2      = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*2;
                        LevelDC2618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(3+phi);
                       }
                    }
                 }
              }
            else if (retAC >= vl0382 && retAC <= vh0886 && retXD >= vl1618 && retXD <= vh1618 && retBD >= vl2236 && retBD <= vh3618 && retXB >= vl0382 && retXB <= vh0618)
              {
               vNamePattern=vCrab; // Crab
               if (RangeForPointD>0 && FlagForD)
                 {
                  if (vBullBear == vBull)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]-XA*vh1618,zz[aXABCD[C]]-BC*vh3618);
                     LevelForDmax = MathMin(zz[aXABCD[A]]-XA*vl1618,zz[aXABCD[C]]-BC*vl2236);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*phi;
                        LevelDA2      = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*2;
                        LevelDA2618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*phi;
                        LevelDC2      = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*2;
                        LevelDC2618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(3+phi);
                       }
                    }
                  else if (vBullBear == vBear)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]+XA*vl1618,zz[aXABCD[C]]+BC*vl2236);
                     LevelForDmax = MathMin(zz[aXABCD[A]]+XA*vh1618,zz[aXABCD[C]]+BC*vh3618);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*phi;
                        LevelDA2      = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*2;
                        LevelDA2618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*phi;
                        LevelDC2      = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*2;
                        LevelDC2618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(3+phi);
                       }
                    }
                 }
              }
            else if (retAC >= vl0382 && retAC <= vh0886 && retXD >= vl0886 && retXD <= vh0886 && retBD >= vl1272 && retBD <= vh2618 && retXB >= vl0382 && retXB <= vh0618)
              {
               vNamePattern=vBat; // Bat
               if (RangeForPointD>0 && FlagForD)
                 {
                  if (vBullBear == vBull)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]-XA*vh0886,zz[aXABCD[C]]-BC*vh2618);
                     LevelForDmax = MathMin(zz[aXABCD[A]]-XA*vl0886,zz[aXABCD[C]]-BC*vl1272);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*phi;
                        LevelDA2      = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*2;
                        LevelDA2618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*phi;
                        LevelDC2      = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*2;
                        LevelDC2618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(3+phi);
                       }
                    }
                  else if (vBullBear == vBear)
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]+XA*vl0886,zz[aXABCD[C]]+BC*vl1272);
                     LevelForDmax = MathMin(zz[aXABCD[A]]+XA*vh0886,zz[aXABCD[C]]+BC*vh2618);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*phi;
                        LevelDA2      = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*2;
                        LevelDA2618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(3+phi);
                        LevelDC1382   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*phi;
                        LevelDC2      = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*2;
                        LevelDC2618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(3+phi);
                       }
                    }
                 }
              }
           }
        }

      // SharkPattern
      if (CustomPattern<3 && StringLen(vNamePattern)==0)
        {
         vBullBear    = "";
         vNamePattern = "";
         if ((zz[aXABCD[A]] < zz[aXABCD[C]]) && (zz[aXABCD[A]] > zz[aXABCD[B]]) && (zz[aXABCD[B]] > zz[aXABCD[D]]))
           {
            vBullBear = vBull;
           }
         else if ((zz[aXABCD[A]] > zz[aXABCD[C]]) && (zz[aXABCD[A]] < zz[aXABCD[B]]) && (zz[aXABCD[B]] < zz[aXABCD[D]]))
           {
            vBullBear = vBear;
           }

         // определяем ретресменты
         if (StringLen(vBullBear)>0)
           {
            if (vBullBear == vBull)
              {
               retXD = (zz[aXABCD[C]] - zz[aXABCD[D]]) / (zz[aXABCD[C]] - zz[aXABCD[X]] + vDelta0);
               retBD = (zz[aXABCD[C]] - zz[aXABCD[D]]) / (zz[aXABCD[C]] - zz[aXABCD[B]] + vDelta0);
               retAC = (zz[aXABCD[C]] - zz[aXABCD[B]]) / (zz[aXABCD[A]] - zz[aXABCD[B]] + vDelta0);
               if (RangeForPointD>0 && FlagForD)
                 {
                  XC=zz[aXABCD[C]] - zz[aXABCD[X]];
                  BC=zz[aXABCD[C]] - zz[aXABCD[B]];
                 }
              }
            else if (vBullBear == vBear)
              {
               retXD = (zz[aXABCD[D]] - zz[aXABCD[C]]) / (zz[aXABCD[X]] - zz[aXABCD[C]] + vDelta0);
               retBD = (zz[aXABCD[D]] - zz[aXABCD[C]]) / (zz[aXABCD[B]] - zz[aXABCD[C]] + vDelta0);
               retAC = (zz[aXABCD[B]] - zz[aXABCD[C]]) / (zz[aXABCD[B]] - zz[aXABCD[A]] + vDelta0);
               if (RangeForPointD>0 && FlagForD)
                 {
                  XC=zz[aXABCD[X]] - zz[aXABCD[C]];
                  BC=zz[aXABCD[B]] - zz[aXABCD[C]];
                 }
              }

            // определяем наименование паттерна
            if (retAC >= vl1128 && retAC <= vh1618 && retXD >= vl0886 && retXD <= vh1128 && retBD >= vl1618 && retBD <= vh2236)
              {
               vNamePattern=vShark; // Shark
               if (RangeForPointD>0 && FlagForD)
                 {
                  if (vBullBear == vBull)
                    {
                     LevelForDmin = MathMin(zz[aXABCD[C]]-XC*vh1128,zz[aXABCD[C]]-BC*vh2236);
                     LevelForDmax = MathMax(zz[aXABCD[C]]-XC*vl0886,zz[aXABCD[C]]-BC*vl1618);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = 0;
                        LevelDA1618   = 0;
                        LevelDA2      = 0;
                        LevelDA2618   = 0;
                        LevelDA3618   = 0;
                        LevelDA4618   = 0;
                        LevelDC1382   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*phi;
                        LevelDC2      = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*2;
                        LevelDC2618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(3+phi);
                       }
                    }
                  else if (vBullBear == vBear)
                    {
                     LevelForDmin = MathMin(zz[aXABCD[C]]+XC*vl0886,zz[aXABCD[C]]+BC*vl1618);
                     LevelForDmax = MathMax(zz[aXABCD[C]]+XC*vh1128,zz[aXABCD[C]]+BC*vh2236);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = 0;
                        LevelDA1618   = 0;
                        LevelDA2      = 0;
                        LevelDA2618   = 0;
                        LevelDA3618   = 0;
                        LevelDA4618   = 0;
                        LevelDC1382   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*1.382;
                        LevelDC1618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*phi;
                        LevelDC2      = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*2;
                        LevelDC2618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(1+phi);
                        LevelDC3618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(2+phi);
                        LevelDC4618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(3+phi);
                       }
                    }
                 }
              }
           }
        }

      // CustomPattern
      if (CustomPattern>0 && StringLen(vNamePattern)==0)
        {
         vBullBear    = "";
         vNamePattern = "";
         if (CustomPattern==2 || CustomPattern==4) 
           {
            vlAC=min_DeltaGartley * minAC;
            vlBD=min_DeltaGartley * minBD;
            vlXB=min_DeltaGartley * minXB;
            vlXD=min_DeltaGartley * minXD;
           } 
         else
           {
            vlAC=min_DeltaGartley * maxAC;
            vlBD=min_DeltaGartley * maxBD;
            vlXB=min_DeltaGartley * maxXB;
            vlXD=min_DeltaGartley * maxXD;
           }

         vhAC = max_DeltaGartley * maxAC;
         vhBD = max_DeltaGartley * maxBD;
         vhXB = max_DeltaGartley * maxXB;
         vhXD = max_DeltaGartley * maxXD;

         tangensXB=(zz[aXABCD[B]]-zz[aXABCD[X]])/(aXABCD[X]-aXABCD[B]);
         if (zz[aXABCD[C]]>zz[aXABCD[D]] && (zz[aXABCD[B]]+(aXABCD[B]-aXABCD[D])*tangensXB)>zz[aXABCD[D]])
           {
            // определяем ретресменты
            retAC = (zz[aXABCD[C]] - zz[aXABCD[B]]) / (zz[aXABCD[A]] - zz[aXABCD[B]] + vDelta0);
            retBD = (zz[aXABCD[C]] - zz[aXABCD[D]]) / (zz[aXABCD[C]] - zz[aXABCD[B]] + vDelta0);
            retXB = (zz[aXABCD[A]] - zz[aXABCD[B]]) / (zz[aXABCD[A]] - zz[aXABCD[X]] + vDelta0);
            if (zz[aXABCD[A]]>zz[aXABCD[C]]) retXD = (zz[aXABCD[A]] - zz[aXABCD[D]]) / (zz[aXABCD[A]] - zz[aXABCD[X]] + vDelta0);
            else retXD = (zz[aXABCD[C]] - zz[aXABCD[D]]) / (zz[aXABCD[C]] - zz[aXABCD[X]] + vDelta0);

            if (retAC>vlAC && retAC<vhAC && retBD>vlBD && retBD<vhBD && retXB>vlXB && retXB<vhXB && retXD>vlXD && retXD<vhXD)
              {
               vBullBear = vBull;
               vNamePattern=vCustom; // Custom

               if (zz[aXABCD[A]]>zz[aXABCD[C]])
                 {
                  XA=zz[aXABCD[A]] - zz[aXABCD[X]];
                  BC=zz[aXABCD[C]] - zz[aXABCD[B]];
                 }
               else
                 {
                  XC=zz[aXABCD[C]] - zz[aXABCD[X]];
                  BD=zz[aXABCD[B]] - zz[aXABCD[D]];
                 }

               if (RangeForPointD>0 && FlagForD)
                 {
                  if (zz[aXABCD[A]]>zz[aXABCD[C]])
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]-XA*vhXD,zz[aXABCD[C]]-BC*vhBD);
                     LevelForDmax = MathMin(zz[aXABCD[A]]-XA*vlXD,zz[aXABCD[C]]-BC*vlBD);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*phi;
                        LevelDA2      = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*2;
                        LevelDA2618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]-(zz[aXABCD[A]]-zz[aXABCD[B]])*(3+phi);
                       }
                    }
                  else
                    {
                     LevelForDmin = MathMax(zz[aXABCD[C]]-XC*vhXD,zz[aXABCD[C]]-BC*vhBD);
                     LevelForDmax = MathMin(zz[aXABCD[C]]-XC*vlXD,zz[aXABCD[C]]-BC*vlBD);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = 0;
                        LevelDA1618   = 0;
                        LevelDA2      = 0;
                        LevelDA2618   = 0;
                        LevelDA3618   = 0;
                        LevelDA4618   = 0;
                       }
                    }
                   
                  if (RangeForPointD==2)
                    {
                     LevelDC1382   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*1.382;
                     LevelDC1618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*phi;
                     LevelDC2      = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*2;
                     LevelDC2618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(1+phi);
                     LevelDC3618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(2+phi);
                     LevelDC4618   = zz[aXABCD[C]]-(zz[aXABCD[C]]-zz[aXABCD[B]])*(3+phi);
                    }
                 }
              }
           }
         else if (zz[aXABCD[C]]<zz[aXABCD[D]] && (zz[aXABCD[B]]+(aXABCD[B]-aXABCD[D])*tangensXB)<zz[aXABCD[D]])
           {
            // определяем ретресменты
            retAC = (zz[aXABCD[B]] - zz[aXABCD[C]]) / (zz[aXABCD[B]] - zz[aXABCD[A]] + vDelta0);
            retBD = (zz[aXABCD[D]] - zz[aXABCD[C]]) / (zz[aXABCD[B]] - zz[aXABCD[C]] + vDelta0);
            retXB = (zz[aXABCD[B]] - zz[aXABCD[A]]) / (zz[aXABCD[X]] - zz[aXABCD[A]] + vDelta0);
            if (zz[aXABCD[A]]<zz[aXABCD[C]]) retXD = (zz[aXABCD[D]] - zz[aXABCD[A]]) / (zz[aXABCD[X]] - zz[aXABCD[A]] + vDelta0);
            else retXD = (zz[aXABCD[D]] - zz[aXABCD[C]]) / (zz[aXABCD[X]] - zz[aXABCD[C]] + vDelta0);

            if (retAC>vlAC && retAC<vhAC && retBD>vlBD && retBD<vhBD && retXB>vlXB && retXB<vhXB && retXD>vlXD && retXD<vhXD)
              {
               vBullBear = vBear;
               vNamePattern=vCustom; // Custom

               if (zz[aXABCD[A]]<zz[aXABCD[C]])
                 {
                  XA=zz[aXABCD[X]] - zz[aXABCD[A]];
                  BC=zz[aXABCD[B]] - zz[aXABCD[C]];
                 }
               else
                 {
                  XC=zz[aXABCD[X]] - zz[aXABCD[C]];
                  BD=zz[aXABCD[D]] - zz[aXABCD[B]];
                 }

               if (RangeForPointD>0 && FlagForD)
                 {
                  if (zz[aXABCD[A]]<zz[aXABCD[C]])
                    {
                     LevelForDmin = MathMax(zz[aXABCD[A]]+XA*vlXD,zz[aXABCD[C]]+BC*vlBD);
                     LevelForDmax = MathMin(zz[aXABCD[A]]+XA*vhXD,zz[aXABCD[C]]+BC*vhBD);
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*1.382;
                        LevelDA1618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*phi;
                        LevelDA2      = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*2;
                        LevelDA2618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(1+phi);
                        LevelDA3618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(2+phi);
                        LevelDA4618   = zz[aXABCD[A]]+(zz[aXABCD[B]]-zz[aXABCD[A]])*(3+phi);
                       }
                    }
                  else
                    {
                     LevelForDmin = MathMax(zz[aXABCD[C]]+XC*vlXD,zz[aXABCD[C]]+BC*vlBD);
                     LevelForDmax = MathMin(zz[aXABCD[C]]+XC*vhXD,zz[aXABCD[C]]+BC*vhBD);
                     if (RangeForPointD==2)
                     if (RangeForPointD==2)
                       {
                        LevelDA1382   = 0;
                        LevelDA1618   = 0;
                        LevelDA2      = 0;
                        LevelDA2618   = 0;
                        LevelDA3618   = 0;
                        LevelDA4618   = 0;
                       }
                    }

                  if (RangeForPointD==2)
                    {
                     LevelDC1382   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*1.382;
                     LevelDC1618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*phi;
                     LevelDC2      = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*2;
                     LevelDC2618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(1+phi);
                     LevelDC3618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(2+phi);
                     LevelDC4618   = zz[aXABCD[C]]+(zz[aXABCD[B]]-zz[aXABCD[C]])*(3+phi);
                    }
                 }
              }         
           }
        }

      if (StringLen(vNamePattern)>0 && (aXABCD[D] < bartoD+2))
        {
         if (ExtGartleyTypeSearch>0 && ExtIndicator==11)
           {
            for (m=0;m<=countGartley;m++) // проверка на появление нового паттерна
              {
               if (PeakCenaX[m]==zz[aXABCD[X]] && PeakCenaA[m]==zz[aXABCD[A]] && PeakCenaB[m]==zz[aXABCD[B]] && PeakCenaC[m]==zz[aXABCD[C]] && PeakCenaD[m]==zz[aXABCD[D]])
                 {
                  if (PeakTimeX[m]==Time[aXABCD[X]] && PeakTimeA[m]==Time[aXABCD[A]] && PeakTimeB[m]==Time[aXABCD[B]] && PeakTimeC[m]==Time[aXABCD[C]] && PeakTimeD[m]==Time[aXABCD[D]]) {k++; break;}
                 }
              }

            if (m<=countGartley)
              {
               continue;
              }

            if (ArraySize(PeakCenaX)<countGartley+1)
              {
               ArrayResize(PeakCenaX,countGartley+1);
               ArrayResize(PeakCenaA,countGartley+1);
               ArrayResize(PeakCenaB,countGartley+1);
               ArrayResize(PeakCenaC,countGartley+1);
               ArrayResize(PeakCenaD,countGartley+1);
               
               ArrayResize(PeakTimeX,countGartley+1);
               ArrayResize(PeakTimeA,countGartley+1);
               ArrayResize(PeakTimeB,countGartley+1);
               ArrayResize(PeakTimeC,countGartley+1);
               ArrayResize(PeakTimeD,countGartley+1);
              }

            PeakCenaX[countGartley]=zz[aXABCD[X]];    // запись координат нового паттерна в массивы
            PeakCenaA[countGartley]=zz[aXABCD[A]];
            PeakCenaB[countGartley]=zz[aXABCD[B]];
            PeakCenaC[countGartley]=zz[aXABCD[C]];
            PeakCenaD[countGartley]=zz[aXABCD[D]];
            
            PeakTimeX[countGartley]=Time[aXABCD[X]];
            PeakTimeA[countGartley]=Time[aXABCD[A]];
            PeakTimeB[countGartley]=Time[aXABCD[B]];
            PeakTimeC[countGartley]=Time[aXABCD[C]];
            PeakTimeD[countGartley]=Time[aXABCD[D]];

            if (NumberPattern-1==countGartley)
              {
               minBarsToNumberPattern=Depth;

               LevelForDminToNumberPattern=LevelForDmin;
               LevelForDmaxToNumberPattern=LevelForDmax;

               vBullBearToNumberPattern = vBullBear;
               vNamePatternToNumberPattern = vNamePattern;
              }

            if (countColor==ColorSize) countColor=0;  // "перезаряжаем" счетчик цветов
            colorPattern=ColorList[countColor];
            countColor++;
            countGartley++;
           }
         else
           {
            colorPattern=ExtColorPatterns;

            LevelForDminToNumberPattern=LevelForDmin;
            LevelForDmaxToNumberPattern=LevelForDmax;

            vBullBearToNumberPattern = vBullBear;
            vNamePatternToNumberPattern = vNamePattern;
           }

         if (Equilibrium && ExtGartleyTypeSearch==0)
           {
            double tangens, h_ea=0, h_ec=0, delta;

            tangens=(zz[aXABCD[B]]-zz[aXABCD[X]])/(aXABCD[X]-aXABCD[B]);
            if (ReactionType)
              {
               h_ea=zz[aXABCD[A]]-(zz[aXABCD[X]]+(aXABCD[X]-aXABCD[A])*tangens);
               h_ec=zz[aXABCD[C]]-(zz[aXABCD[B]]+(aXABCD[B]-aXABCD[C])*tangens);
              }
            else
              {
               if (zz[aXABCD[X]]>zz[aXABCD[A]])
                 {
                  for (i=aXABCD[X]-1;i>=aXABCD[A];i--)
                    {
                     delta=Low[i]-(zz[aXABCD[X]]+(aXABCD[X]-i)*tangens);
                     if (delta<h_ea) h_ea=delta;
                    }

                  for (i=aXABCD[B]-1;i>=aXABCD[C];i--)
                    {
                     delta=Low[i]-(zz[aXABCD[B]]+(aXABCD[B]-i)*tangens);
                     if (delta<h_ec) h_ec=delta;
                    }
                 }
               else
                 {
                  for (i=aXABCD[X]-1;i>=aXABCD[A];i--)
                    {
                     delta=High[i]-(zz[aXABCD[X]]+(aXABCD[X]-i)*tangens);
                     if (delta>h_ea) h_ea=delta;
                    }

                  for (i=aXABCD[B]-1;i>=aXABCD[C];i--)
                    {
                     delta=High[i]-(zz[aXABCD[B]]+(aXABCD[B]-i)*tangens);
                     if (delta>h_ec) h_ec=delta;
                    }
                 }
              }

            nameObj="_"+ExtComplekt+"Equilibrium_" + countGartley;
            ObjectDelete(nameObj);
            ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[X]],zz[aXABCD[X]],Time[aXABCD[B]],zz[aXABCD[B]]);
            ObjectSet(nameObj,OBJPROP_COLOR,ColorEquilibrium);
            ObjectSet(nameObj,OBJPROP_STYLE,EquilibriumStyle);
            ObjectSet(nameObj,OBJPROP_WIDTH,EquilibriumWidth);
            nameObj="_"+ExtComplekt+"Reaction1_" + countGartley;
            ObjectDelete(nameObj);
            ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],zz[aXABCD[B]]+tangens*(aXABCD[B]-aXABCD[C])-h_ec,Time[0],zz[aXABCD[B]]+tangens*aXABCD[B]-h_ec);
            ObjectSet(nameObj,OBJPROP_COLOR,ColorReaction);
            ObjectSet(nameObj,OBJPROP_STYLE,EquilibriumStyle);
            ObjectSet(nameObj,OBJPROP_WIDTH,EquilibriumWidth);
            nameObj="_"+ExtComplekt+"Reaction2_" + countGartley;
            ObjectDelete(nameObj);
            ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],zz[aXABCD[B]]+tangens*(aXABCD[B]-aXABCD[C])-h_ea,Time[0],zz[aXABCD[B]]+tangens*aXABCD[B]-h_ea);
            ObjectSet(nameObj,OBJPROP_COLOR,ColorReaction);
            ObjectSet(nameObj,OBJPROP_STYLE,EquilibriumStyle);
            ObjectSet(nameObj,OBJPROP_WIDTH,EquilibriumWidth);

//            Equilibrium=false;
           }

         nameObj1="_"+ExtComplekt+"Triangle1_" + countGartley + "_" + _Depth + "_" + aXABCD[D] + "_" +vBullBear + " " + vNamePattern;
         nameObj2="_"+ExtComplekt+"Triangle2_" + countGartley + "_" + _Depth + "_" + aXABCD[D] + "_" +vBullBear + " " + vNamePattern;

         vPatOnOff = 1;

         //---------------------------------------------
         if(f==1 && ExtIndicator!=11)
           {
            f=0;
            if(ExtPlayAlert) 
              {
               Alert (Symbol(),"  ",Period(),"  появился новый Паттерн");
               PlaySound("alert.wav");
              }
            if (ExtSendMail) _SendMail("There was a pattern","on  " + Symbol() + " " + Period() + " pattern " + vBullBear + " " + vNamePattern);
           }
         //---------------------------------------------

         if (vBullBear == vBull)
           {
            ObjectCreate(nameObj1,OBJ_TRIANGLE,0,Time[aXABCD[X]],zz[aXABCD[X]],Time[aXABCD[B]],zz[aXABCD[B]],Time[aXABCD[A]],zz[aXABCD[A]]);
            ObjectSet(nameObj1,OBJPROP_COLOR,colorPattern);
            ObjectCreate(nameObj2,OBJ_TRIANGLE,0,Time[aXABCD[B]],zz[aXABCD[B]],Time[aXABCD[D]],zz[aXABCD[D]],Time[aXABCD[C]],zz[aXABCD[C]]);
            ObjectSet(nameObj2,OBJPROP_COLOR,colorPattern);
           }
         else // if (vBullBear == vBear)
           {
            ObjectCreate(nameObj1,OBJ_TRIANGLE,0,Time[aXABCD[X]],zz[aXABCD[X]],Time[aXABCD[B]],zz[aXABCD[B]],Time[aXABCD[A]],zz[aXABCD[A]]);
            ObjectSet(nameObj1,OBJPROP_COLOR,colorPattern);
            ObjectCreate(nameObj2,OBJ_TRIANGLE,0,Time[aXABCD[B]],zz[aXABCD[B]],Time[aXABCD[D]],zz[aXABCD[D]],Time[aXABCD[C]],zz[aXABCD[C]]);
            ObjectSet(nameObj2,OBJPROP_COLOR,colorPattern);
           }

         if (RangeForPointD>0) // Вывод прямоугольника для зоны точки D
           {
            if (FlagForD)
              {
               for (j=aXABCD[D];j<aXABCD[C];j++)
                 {
                  if (vBullBear == vBull)
                    {
                     if (LevelForDmax>=Low[j]) TimeForDmax  = Time[j];
                    }
                  else if (vBullBear == vBear)
                    {
                     if (LevelForDmin<=High[j]) TimeForDmin  = Time[j];
                    }
                 }

               if (vBullBear == vBull)
                 {
                  TimeForDmin  = TimeForDmax+((LevelForDmax-LevelForDmin)/((zz[aXABCD[C]]-zz[aXABCD[D]])/(aXABCD[C]-aXABCD[D]+1)))*Period()*60;
                 }
               else if (vBullBear == vBear)
                 {
                  TimeForDmax  = TimeForDmin+((LevelForDmax-LevelForDmin)/((zz[aXABCD[D]]-zz[aXABCD[C]])/(aXABCD[C]-aXABCD[D]+1)))*Period()*60;
                 }

               if (TimeForDmin>TimeForDmax)
                 {
                  timeLineD=TimeForDmin;
                  TimeForDmin=TimeForDmax;
                  TimeForDmax=timeLineD;
                 }
               else
                 {
                  timeLineD=TimeForDmax;
                 }

               if (LevelForDmin>LevelForDmax)
                 {
                  LevelForD=LevelForDmin;
                  LevelForDmin=LevelForDmax;
                  LevelForDmax=LevelForD;
                 }

               if (VectorOfAMirrorTrend==1)
                 {
                  nameObj="_"+ExtComplekt+"VectorOfAMirrorTrend_1_" + countGartley + "";
                 }
               else if (VectorOfAMirrorTrend==2)
                 {
                  nameObj="_"+ExtComplekt+"VectorOfAMirrorTrend_2_" + countGartley + "";

                  if (vBullBear == vBear) ObjectCreate(nameObj,OBJ_TREND,0,TimeForDmin,LevelForDmax,TimeForDmax,LevelForDmin);
                  else  ObjectCreate(nameObj,OBJ_TREND,0,TimeForDmin,LevelForDmin,TimeForDmax,LevelForDmax);
                 
                  ObjectSet(nameObj, OBJPROP_BACK, false);
                  ObjectSet(nameObj, OBJPROP_RAY, true); 
                  ObjectSet(nameObj, OBJPROP_COLOR, LawnGreen); 
                  ObjectSet(nameObj, OBJPROP_STYLE, STYLE_DASH); 
                 }

               nameObj="_"+ExtComplekt+"PointD_" + countGartley + "";

               ObjectCreate(nameObj,OBJ_RECTANGLE,0,TimeForDmin,LevelForDmin,TimeForDmax,LevelForDmax);
               ObjectSet(nameObj, OBJPROP_BACK, false);
               ObjectSet(nameObj, OBJPROP_COLOR, ExtColorRangeForPointD); 

               if (RangeForPointD==2)
                 {
                  if (LevelForDmax>=LevelDA1382 && LevelDA1382>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLA1382_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDA1382,timeLineD,LevelDA1382);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_AB); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDA1618 && LevelDA1618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLA1618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDA1618,timeLineD,LevelDA1618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_AB); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDA2 && LevelDA2>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLA2_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDA2,timeLineD,LevelDA2);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_AB); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDA2618 && LevelDA2618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLA2618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDA2618,timeLineD,LevelDA2618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_AB); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDA3618 && LevelDA3618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLA3618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDA3618,timeLineD,LevelDA3618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_AB); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDA4618 && LevelDA4618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLA4618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDA4618,timeLineD,LevelDA4618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_AB); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDC1382 && LevelDC1382>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLC1382_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDC1382,timeLineD,LevelDC1382);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_BC); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDC1618 && LevelDC1618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLC1618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDC1618,timeLineD,LevelDC1618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_BC); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDC2 && LevelDC2>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLC2_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDC2,timeLineD,LevelDC2);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_BC); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDC2618 && LevelDC2618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLC2618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDC2618,timeLineD,LevelDC2618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_BC); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDC3618 && LevelDC3618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLC3618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDC3618,timeLineD,LevelDC3618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_BC); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }

                  if (LevelForDmax>=LevelDC4618 && LevelDC4618>=LevelForDmin)
                    {
                     nameObj="_"+ExtComplekt+"PDLC4618_" + countGartley + "";
                     ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[C]],LevelDC4618,timeLineD,LevelDC4618);
                     ObjectSet(nameObj, OBJPROP_COLOR, ExtLineForPointD_BC); 
                     ObjectSet(nameObj, OBJPROP_RAY, false); 
                    }
                 }

//               if (ExtGartleyTypeSearch>0 && ExtIndicator==11 && ExtHiddenPP==2)
               if (ExtHiddenPP==2)
                 {
                  k1=MathCeil((aXABCD[X]+aXABCD[B])/2);
                  nameObj="_" + ExtComplekt + "pgtxt" + Time[aXABCD[B]] + "_" + Time[aXABCD[X]];
                  ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(zz[aXABCD[B]]+zz[aXABCD[X]])/2);
                  ObjectSetText(nameObj,DoubleToStr(retXB,3),ExtSizeTxt,"Arial", ExtNotFibo);
                  nameObj="_" + ExtComplekt + "pg" + Time[aXABCD[B]] + "_" + Time[aXABCD[X]];
                  ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[X]],zz[aXABCD[X]],Time[aXABCD[B]],zz[aXABCD[B]]);
                  ObjectSet(nameObj,OBJPROP_RAY,false);
                  ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet(nameObj,OBJPROP_COLOR,ExtLine);
                  ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
                  
                  k1=MathCeil((aXABCD[X]+aXABCD[D])/2);
                  nameObj="_" + ExtComplekt + "pgtxt" + Time[aXABCD[D]] + "_" + Time[aXABCD[X]];
                  ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(zz[aXABCD[D]]+zz[aXABCD[X]])/2);
                  ObjectSetText(nameObj,DoubleToStr(retXD,3),ExtSizeTxt,"Arial", ExtNotFibo);
                  nameObj="_" + ExtComplekt + "pg" + Time[aXABCD[D]] + "_" + Time[aXABCD[X]];
                  ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[X]],zz[aXABCD[X]],Time[aXABCD[D]],zz[aXABCD[D]]);
                  ObjectSet(nameObj,OBJPROP_RAY,false);
                  ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet(nameObj,OBJPROP_COLOR,ExtLine);
                  ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
                  
                  k1=MathCeil((aXABCD[B]+aXABCD[D])/2);
                  nameObj="_" + ExtComplekt + "pgtxt" + Time[aXABCD[D]] + "_" + Time[aXABCD[B]];
                  ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(zz[aXABCD[D]]+zz[aXABCD[B]])/2);
                  ObjectSetText(nameObj,DoubleToStr(retBD,3),ExtSizeTxt,"Arial", ExtNotFibo);
                  nameObj="_" + ExtComplekt + "pg" + Time[aXABCD[D]] + "_" + Time[aXABCD[B]];
                  ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[B]],zz[aXABCD[B]],Time[aXABCD[D]],zz[aXABCD[D]]);
                  ObjectSet(nameObj,OBJPROP_RAY,false);
                  ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet(nameObj,OBJPROP_COLOR,ExtLine);
                  ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
                  
                  k1=MathCeil((aXABCD[A]+aXABCD[C])/2);
                  nameObj="_" + ExtComplekt + "pgtxt" + Time[aXABCD[C]] + "_" + Time[aXABCD[A]];
                  ObjectCreate(nameObj,OBJ_TEXT,0,Time[k1],(zz[aXABCD[C]]+zz[aXABCD[A]])/2);
                  ObjectSetText(nameObj,DoubleToStr(retAC,3),ExtSizeTxt,"Arial", ExtNotFibo);
                  nameObj="_" + ExtComplekt + "pg" + Time[aXABCD[C]] + "_" + Time[aXABCD[A]];
                  ObjectCreate(nameObj,OBJ_TREND,0,Time[aXABCD[A]],zz[aXABCD[A]],Time[aXABCD[C]],zz[aXABCD[C]]);
                  ObjectSet(nameObj,OBJPROP_RAY,false);
                  ObjectSet(nameObj,OBJPROP_STYLE,STYLE_DOT);
                  ObjectSet(nameObj,OBJPROP_COLOR,ExtLine);
                  ObjectSet(nameObj,OBJPROP_BACK,ExtBack);
                  
                 }
              }

           }

         return(0);
        }
      else 
        {
         vBullBear    = "";
         vNamePattern = "";
        }
      k++;

      if (patternInfluence)
        {
         if (!(ExtIndicator>5 && ExtIndicator<11 && GrossPeriod>Period()))
           {
            bartoD=AllowedBandPatternInfluence*(aNumBarPeak[k+4]-aNumBarPeak[k]);
           }
        }
     }
  }
//--------------------------------------------------------
// Поиск паттернов Gartley. Конец.
//--------------------------------------------------------


//----------------------------------------------------
//  ZigZag Алекса немного измененный. Начало.
//----------------------------------------------------
void ang_AZZ_()
 {
   int i,n;
//   cbi=Bars-IndicatorCounted()-1;
   if (ExtMaxBar>0) cbi=ExtMaxBar; else cbi=Bars-1;
//---------------------------------
   for (i=cbi; i>=ExtMinBar; i--) 
     {
//-------------------------------------------------
      // запоминаем значение направления тренда fs и средней цены si на предыдущем баре
      if (ti<Time[i]) {fsp=fs; sip=si;} ti=Time[i];
      // Вычисляем значение ценового фильтра от процента отклонения
      if (minSize==0 && minPercent!=0) di=minPercent*Close[i]/2/100;
//-------------------------------------------------
      // Корректировка средней цены
      if (High[i]>si+di && Low[i]<si-di) // Внешний бар по отношению к ценовому фильтру di
        {
//        if (High[i]-si>si-Low[i]) si=High[i]-di;  // Отклонение хая от средней цены больше отклонения лова
//        else if (High[i]-si<si-Low[i]) si=Low[i]+di;  // соответственно, меньше

         if (fs==1) si=High[i]-di;  // 
         if (fs==2) si=Low[i]+di;  // 
        } 
      else  // Не внешний бар
        {
         if (fs==1)
           {
            if (High[i]>=si+di) si=High[i]-di;   // 
            else if (Low[i]<si-di) si=Low[i]+di;   // 
           }
         if (fs==2)
           {
            if (Low[i]<=si-di) si=Low[i]+di;   // 
            else if (High[i]>si+di) si=High[i]-di;   //
           }
        }

      // Вычисление начального значения средней цены
      if (i>cbi-1) {si=(High[i]+Low[i])/2;}

      // Определяем направление тренда для расчетного бара
      if (si>sip) fs=1; // Тренд восходящий
      if (si<sip) fs=2; // Тренд нисходящий

//-------------------------------------------------

      if (fs==1 && fsp==2) // Тредн сменился с нисходящего на восходящий
        {
         hm=High[i];

         bi=iBarShift(Symbol(),Period(),tbi);
         zz[bi]=Low[bi];
         zzL[bi]=Low[bi];
         tai=Time[i];
         fsp=fs;
         si=High[i]-di;
         sip=si;
         if (ExtLabel>0)
           {
            ha[i]=High[i]; la[bi]=Low[bi]; la[i]=0;
            tmh=Time[i]; ha[i]=High[i]; la[i]=0; // простановка метки на восходящем луче
           }
        }

      if (fs==2 && fsp==1) // Тредн сменился с восходящего на нисходящий
        {
         lm=Low[i]; 

         ai=iBarShift(Symbol(),Period(),tai); 
         zz[ai]=High[ai];
         zzH[ai]=High[ai];
         tbi=Time[i];
         si=Low[i]+di;
         fsp=fs;
         sip=si;
         if (ExtLabel>0)
           {
            ha[ai]=High[ai]; ha[i]=0; la[i]=Low[i];
            tml=Time[i]; ha[i]=0; la[i]=Low[i]; // простановка метки на нисходящем луче
           }
        }

      // Продолжение tренда. Отслеживание тренда.
      if (fs==1 && High[i]>hm) 
        {hm=High[i]; tai=Time[i]; si=High[i]-di;}
      if (fs==2 && Low[i]<lm) 
        {lm=Low[i]; tbi=Time[i]; si=Low[i]+di;}

      // Заполняем буферы для уровней подтверждения
      if (chHL && chHL_PeakDet_or_vts && ExtLabel==0) {ha[i]=si+di; la[i]=si-di;} 

//===================================================================================================
      // Нулевой бар. Расчет первого луча ZigZag-a

      if (i==0) 
        {
         ai0=iBarShift(Symbol(),Period(),tai); 
         bi0=iBarShift(Symbol(),Period(),tbi);
         if (fs==1)
           {
            for (n=bi0-1; n>=0; n--) {zzH[n]=0; zz[n]=0; if (ExtLabel>0) ha[n]=0;}
            zz[ai0]=High[ai0]; zzH[ai0]=High[ai0]; zzL[ai0]=0; if (ExtLabel>0) ha[ai0]=High[ai0];
           }
         if (fs==2)
           {
            for (n=ai0-1; n>=0; n--) {zzL[n]=0; zz[n]=0; if (ExtLabel>0) la[n]=0;}
            zz[bi0]=Low[bi0]; zzL[bi0]=Low[bi0]; zzH[bi0]=0; if (ExtLabel>0) la[bi0]=Low[bi0];
           }

         if (ExtLabel>0)
           {
            if (fs==1) {aim=iBarShift(Symbol(),0,tmh); if (aim<bi0) ha[aim]=High[aim];}
            else if (fs==2) {bim=iBarShift(Symbol(),0,tml); if (bim<ai0) la[bim]=Low[bim];}
           }
        }
//====================================================================================================
     }
//--------------------------------------------
 }
//--------------------------------------------------------
// ZigZag Алекса. Конец. 
//--------------------------------------------------------


//----------------------------------------------------
// Индикатор подобный встроенному в Ensign. Начало.
//----------------------------------------------------
void Ensign_ZZ()
 {
   int i,n;

//   cbi=Bars-IndicatorCounted()-1;
   if (ExtMaxBar>0) cbi=ExtMaxBar; else cbi=Bars-1;
//---------------------------------
   for (i=cbi; i>=ExtMinBar; i--) 
     {
//-------------------------------------------------
      // Устанавливаем начальные значения минимума и максимума бара
      if (lLast==0) {lLast=Low[i];hLast=High[i]; if (ExtIndicator==3) di=hLast-lLast;}

      // Определяем направление тренда до первой точки смены тренда.
      // Или до точки начала первого луча за левым краем.
      if (fs==0)
        {
         if (lLast<Low[i] && hLast<High[i]) {fs=1; hLast=High[i]; si=High[i]; ai=i; tai=Time[i]; if (ExtIndicator==3) di=High[i]-Low[i];}  // тренд восходящий
         if (lLast>Low[i] && hLast>High[i]) {fs=2; lLast=Low[i]; si=Low[i]; bi=i; tbi=Time[i]; if (ExtIndicator==3) di=High[i]-Low[i];}  // тренд нисходящий
        }

      if (ti<Time[i])
        {
         // запоминаем значение направления тренда fs на предыдущем баре
         ti=Time[i];

         ai0=iBarShift(Symbol(),Period(),tai); 
         bi0=iBarShift(Symbol(),Period(),tbi);

         fcount0=false;
         if ((fh || fl) && countBar>0) {countBar--; if (i==0 && countBar==0) fcount0=true;}
         // Остановка. Определение дальнейшего направления тренда.
         if (fs==1)
           {
            if (hLast>High[i] && !fh) fh=true;

            if (i==0)
              {

               if (Close[i+1]<lLast && fh) {fs=2; countBar=minBars; fh=false;}
               if (countBar==0 && si-di>Low[i+1] && High[i+1]<hLast && ai0>i+1 && fh && !fcount0) {fs=2; countBar=minBars; fh=false;}

               if (fs==2) // Тредн сменился с восходящего на нисходящий на предыдущем баре
                 {
                  zz[ai0]=High[ai0];
                  zzH[ai0]=High[ai0];
                  lLast=Low[i+1];
                  if (ExtIndicator==3) di=High[i+1]-Low[i+1];
                  si=Low[i+1];
                  bi=i+1;
                  tbi=Time[i+1];
                  if (ExtLabel>0)
                    {
                     ha[ai0]=High[ai0];
                     tml=Time[i+1]; ha[i+1]=0; la[i+1]=Low[i+1]; // простановка метки на нисходящем луче
                    }
                  else if (chHL && chHL_PeakDet_or_vts) {ha[i+1]=si+di; la[i+1]=si;}
                }

              }
            else
              {
               if (Close[i]<lLast && fh) {fs=2; countBar=minBars; fh=false;}
               if (countBar==0 && si-di>Low[i] && High[i]<hLast && fh) {fs=2; countBar=minBars; fh=false;}

               if (fs==2) // Тредн сменился с восходящего на нисходящий
                 {
                  zz[ai]=High[ai];
                  zzH[ai]=High[ai];
                  lLast=Low[i];
                  if (ExtIndicator==3) di=High[i]-Low[i];
                  si=Low[i];
                  bi=i;
                  tbi=Time[i];
                  if (ExtLabel>0)
                    {
                     ha[ai]=High[ai];
                     tml=Time[i]; ha[i]=0; la[i]=Low[i]; // простановка метки на нисходящем луче
                    }
                  else if (chHL && chHL_PeakDet_or_vts) {ha[i]=si+di; la[i]=si;}
                 }
              }

           }
         else // fs==2
           {
            if (lLast<Low[i] && !fl) fl=true;

            if (i==0)
              {

               if (Close[i+1]>hLast && fl) {fs=1; countBar=minBars; fl=false;}
               if (countBar==0 && si+di<High[i+1] && Low[i+1]>lLast && bi0>i+1 && fl && !fcount0) {fs=1; countBar=minBars; fl=false;}

               if (fs==1) // Тредн сменился с нисходящего на восходящий на предыдущем баре
                 {
                  zz[bi0]=Low[bi0];
                  zzL[bi0]=Low[bi0];
                  hLast=High[i+1];
                  if (ExtIndicator==3) di=High[i+1]-Low[i+1];
                  si=High[i+1];
                  ai=i+1;
                  tai=Time[i+1];
                  if (ExtLabel>0)
                    {
                     la[bi0]=Low[bi0];
                     tmh=Time[i+1]; ha[i+1]=High[i+1]; la[i+1]=0; // простановка метки на восходящем луче
                    }
                  else if (chHL && chHL_PeakDet_or_vts) {ha[i+1]=si; la[i+1]=si-di;}
                 }

              }
            else
              {
               if (Close[i]>hLast && fl) {fs=1; countBar=minBars; fl=false;}
               if (countBar==0 && si+di<High[i] && Low[i]>lLast && fl) {fs=1; countBar=minBars; fl=false;}

               if (fs==1) // Тредн сменился с нисходящего на восходящий
                 {
                  zz[bi]=Low[bi];
                  zzL[bi]=Low[bi];
                  hLast=High[i];
                  if (ExtIndicator==3) di=High[i]-Low[i];
                  si=High[i];
                  ai=i;
                  tai=Time[i];
                  if (ExtLabel>0)
                    {
                     la[bi]=Low[bi];
                     tmh=Time[i]; ha[i]=High[i]; la[i]=0; // простановка метки на восходящем луче
                    }
                  else if (chHL && chHL_PeakDet_or_vts==1) {ha[i]=si; la[i]=si-di;}
                 }
              }
           }
        } 

      // Продолжение тренда
      if (fs==1 && High[i]>si) {ai=i; tai=Time[i]; hLast=High[i]; si=High[i]; countBar=minBars; fh=false; if (ExtIndicator==3) di=High[i]-Low[i];}

      if (fs==2 && Low[i]<si) {bi=i; tbi=Time[i]; lLast=Low[i]; si=Low[i]; countBar=minBars; fl=false; if (ExtIndicator==3) di=High[i]-Low[i];}

      // Заполняем буферы для уровней подтверждения
      if (chHL && chHL_PeakDet_or_vts && ExtLabel==0)
        {
         if (fs==1) {ha[i]=si; la[i]=si-di;}
         if (fs==2) {ha[i]=si+di; la[i]=si;}
        } 

//===================================================================================================
      // Нулевой бар. Расчет первого луча ZigZag-a

      if (i==0) 
        {
         ai0=iBarShift(Symbol(),Period(),tai); 
         bi0=iBarShift(Symbol(),Period(),tbi);

         if (fs==1)
           {
            for (n=bi0-1; n>=0; n--) {zzH[n]=0; zz[n]=0; if (ExtLabel>0) ha[n]=0;} 
            zz[ai0]=High[ai0]; zzH[ai0]=High[ai0]; zzL[ai0]=0; if (ExtLabel>0) ha[ai0]=High[ai0];
           }
         if (fs==2)
           {
            for (n=ai0-1; n>=0; n--) {zzL[n]=0; zz[n]=0; if (ExtLabel>0) la[n]=0;} 
            zz[bi0]=Low[bi0]; zzL[bi0]=Low[bi0]; zzH[bi0]=0; if (ExtLabel>0) la[bi0]=Low[bi0];
           }

         if (ExtLabel>0)
           {
            if (fs==1) {aim=iBarShift(Symbol(),0,tmh); if (aim<bi0) ha[aim]=High[aim];}
            else if (fs==2) {bim=iBarShift(Symbol(),0,tml); if (bim<ai0) la[bim]=Low[bim];}
           }

        }

//====================================================================================================
     }
//--------------------------------------------
 }
//--------------------------------------------------------
// Индикатор подобный встроенному в Ensign. Конец. 
//--------------------------------------------------------


//----------------------------------------------------
//  ZigZag tauber. Начало.
//----------------------------------------------------

void ZigZag_tauber()
  {
//  ZigZag из МТ. Начало.
   int    shift, back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;

   int    metka=0; // =0 - до первого перелома ZZ. =1 - ищем метки максимумов. =2 - ищем метки минимумов.
   double peak, wrpeak;

   ArrayInitialize(zz,0.0);
   ArrayInitialize(zzL,0.0);
   ArrayInitialize(zzH,0.0);
   if (ExtLabel>0)
     {
      ArrayInitialize(la,0.0);
      ArrayInitialize(ha,0.0);
     }

   GetHigh(0,Bars,0.0,0);

   // final cutting 
   lasthigh=-1; lasthighpos=-1;
   lastlow=-1;  lastlowpos=-1;

   for(shift=Bars; shift>=0; shift--)
     {
      curlow=zzL[shift];
      curhigh=zzH[shift];
      if((curlow==0)&&(curhigh==0)) continue;
      //---
      if(curhigh!=0)
        {
        if(lasthigh>0) 
           {
            if(lasthigh<curhigh) zzH[lasthighpos]=0;
            else zzH[shift]=0;
           }
        //---
         if(lasthigh<curhigh || lasthigh<0)
           {
            lasthigh=curhigh;
            lasthighpos=shift;
           }
         lastlow=-1;
        }
      //----
      if(curlow!=0)
        {
         if(lastlow>0)
           {
            if(lastlow>curlow) zzL[lastlowpos]=0;
            else zzL[shift]=0;
          }
         //---
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
      zz[shift]=zzL[shift];
      res=zzH[shift];
      if(res!=0.0) zz[shift]=res;
     }

   if (ExtLabel>0)  // расставляем метки
     {
      for(shift=Bars-1; shift>=0; shift--)
        {

         if (zz[shift]>0)
           {
            if (zzH[shift]>0)
              {
               peak=High[shift]; wrpeak=Low[shift];
               ha[shift]=High[shift]; la[shift]=0;
               metka=2; shift--;
              }
            else
              {
               peak=Low[shift]; wrpeak=High[shift];
               la[shift]=Low[shift]; ha[shift]=0;
               metka=1; shift--;
              }
           }

         if (metka==1)
           {
            if (wrpeak<High[shift])
              {
               if (High[shift]-peak>minSize*Point) {metka=0;  ha[shift]=High[shift];}
              }
            else
              {
               wrpeak=High[shift];
              }
           }
         else if (metka==2)
           {
            if (wrpeak>Low[shift])
              {
               if (peak-Low[shift]>minSize*Point) {metka=0;  la[shift]=Low[shift];}
              }
            else
              {
               wrpeak=Low[shift];
              }
           }

        }
     }

  }

void GetHigh(int start, int end, double price, int step)
  {
   int count=end-start;
   if (count<=0) return;
   int i=iHighest(NULL,0,MODE_HIGH,count+1,start);
   double val=High[i];
   if ((val-price)>(minSize*Point))
     { 
      zzH[i]=val;
      if (i==start) {GetLow(start+step,end-step,val,1-step); if (zzL[start-1]>0) zzL[start]=0; return;}     
      if (i==end) {GetLow(start+step,end-step,val,1-step); if (zzL[end+1]>0) zzL[end]=0; return;} 
      GetLow(start,i-1,val,0);
      GetLow(i+1,end,val,0);
     }
  }

void GetLow(int start, int end, double price, int step)
  {
   int count=end-start;
   if (count<=0) return;
   int i=iLowest(NULL,0,MODE_LOW,count+1,start);
   double val=Low[i];
   if ((price-val)>(minSize*Point))
     {
      zzL[i]=val; 
      if (i==start) {GetHigh(start+step,end-step,val,1-step); if (zzH[start-1]>0) zzH[start]=0; return;}     
      if (i==end) {GetHigh(start+step,end-step,val,1-step); if (zzH[end+1]>0) zzH[end]=0; return;}   
      GetHigh(start,i-1,val,0);
      GetHigh(i+1,end,val,0);
     }
  }
//--------------------------------------------------------
// ZigZag tauber. Конец. 
//--------------------------------------------------------

//----------------------------------------------------
// Свинги Ганна. Начало.
//----------------------------------------------------
void GannSwing()
 {
   int i,n;

   // Переменные для Свингов Ганна
   double lLast_m=0, hLast_m=0;
   int countBarExt=0; // счетчик внешних баров
   int countBarl=0,countBarh=0;
   fs=0; ti=0;

// lLast, hLast - минимум и максимум активного бара
// lLast_m, hLast_m - минимум и максимум "промежуточных" баров


    ArrayInitialize(zz,0.0);
    ArrayInitialize(zzL,0.0);
    ArrayInitialize(zzH,0.0);
    if (ExtLabel>0)
      {
       ArrayInitialize(la,0.0);
       ArrayInitialize(ha,0.0);
      }

//   cbi=Bars-IndicatorCounted()-1;
//---------------------------------
//   cbi=Bars-1; 
   if (ExtMaxBar>0) cbi=ExtMaxBar; else cbi=Bars-1;
   for (i=cbi; i>=ExtMinBar; i--) 
     {
//-------------------------------------------------
      // Устанавливаем начальные значения минимума и максимума бара
      if (lLast==0) {lLast=Low[i]; hLast=High[i]; ai=i; bi=i;}
      if (ti!=Time[i])
        {
         ti=Time[i];
         if (lLast_m==0 && hLast_m==0)
           {
            if (lLast>Low[i] && hLast<High[i]) // Внешний бар
              {
               lLast=Low[i];hLast=High[i];lLast_m=Low[i];hLast_m=High[i];countBarExt++;
               if (fs==1) {countBarl=countBarExt; ai=i; tai=Time[i];}
               else if (fs==2) {countBarh=countBarExt; bi=i; tbi=Time[i];}
               else {countBarl++;countBarh++;}
              }
            else if (lLast<=Low[i] && hLast<High[i]) // Тенденция на текущем баре восходящая
              {
               lLast_m=0;hLast_m=High[i];countBarl=0;countBarExt=0;
               if (fs!=1) countBarh++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; ai=i; tai=Time[i];}
              }
            else if (lLast>Low[i] && hLast>=High[i]) // Тенденция на текущем баре нисходящая
              {
               lLast_m=Low[i];hLast_m=0;countBarh=0;countBarExt=0;
               if (fs!=2) countBarl++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; bi=i; tbi=Time[i];}
              }
           }
         else  if (lLast_m>0 && hLast_m>0) // Внешний бар (предыдущий)
           {
            if (lLast_m>Low[i] && hLast_m<High[i]) // Внешний бар
              {
               lLast=Low[i];hLast=High[i];lLast_m=Low[i];hLast_m=High[i];countBarExt++;
               if (fs==1) {countBarl=countBarExt; ai=i; tai=Time[i];}
               else if (fs==2) {countBarh=countBarExt; bi=i; tbi=Time[i];}
               else {countBarl++;countBarh++;}
              }
            else if (lLast_m<=Low[i] && hLast_m<High[i]) // Тенденция на текущем баре восходящая
              {
               lLast_m=0;hLast_m=High[i];countBarl=0;countBarExt=0;
               if (fs!=1) countBarh++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; ai=i; tai=Time[i];}
              }
            else if (lLast_m>Low[i] && hLast_m>=High[i]) // Тенденция на текущем баре нисходящая
              {
               lLast_m=Low[i];hLast_m=0;countBarh=0;countBarExt=0;
               if (fs!=2) countBarl++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; bi=i; tbi=Time[i];}
              }
           }
         else  if (lLast_m>0)
           {
            if (lLast_m>Low[i] && hLast<High[i]) // Внешний бар
              {
               lLast=Low[i];hLast=High[i];lLast_m=Low[i];hLast_m=High[i];countBarExt++;
               if (fs==1) {countBarl=countBarExt; ai=i; tai=Time[i];}
               else if (fs==2) {countBarh=countBarExt; bi=i; tbi=Time[i];}
               else {countBarl++;countBarh++;}
              }
            else if (lLast_m<=Low[i] && hLast<High[i]) // Тенденция на текущем баре восходящая
              {
               lLast_m=0;hLast_m=High[i];countBarl=0;countBarExt=0;
               if (fs!=1) countBarh++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; ai=i; tai=Time[i];}
              }
            else if (lLast_m>Low[i] && hLast>=High[i]) // Тенденция на текущем баре нисходящая
              {
               lLast_m=Low[i];hLast_m=0;countBarh=0;countBarExt=0;
               if (fs!=2) countBarl++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; bi=i; tbi=Time[i];}
              }
           }
         else  if (hLast_m>0)
           {
            if (lLast>Low[i] && hLast_m<High[i]) // Внешний бар
              {
               lLast=Low[i];hLast=High[i];lLast_m=Low[i];hLast_m=High[i];countBarExt++;
               if (fs==1) {countBarl=countBarExt; ai=i; tai=Time[i];}
               else if (fs==2) {countBarh=countBarExt; bi=i; tbi=Time[i];}
               else {countBarl++;countBarh++;}
              }
            else if (lLast<=Low[i] && hLast_m<High[i]) // Тенденция на текущем баре восходящая
              {
               lLast_m=0;hLast_m=High[i];countBarl=0;countBarExt=0;
               if (fs!=1) countBarh++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; ai=i; tai=Time[i];}
              }
            else if (lLast>Low[i] && hLast_m>=High[i]) // Тенденция на текущем баре нисходящая
              {
               lLast_m=Low[i];hLast_m=0;countBarh=0;countBarExt=0;
               if (fs!=2) countBarl++;
               else {lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0; bi=i; tbi=Time[i];}
              }
           }

         // Определяем направление тренда. 
         if (fs==0)
           {
            if (lLast<lLast_m && hLast>hLast_m) // внутренний бар
              {
               lLast=Low[i]; hLast=High[i]; ai=i; bi=i; countBarl=0;countBarh=0;countBarExt=0;
              }
              
            if (countBarh>countBarl && countBarh>countBarExt && countBarh>minBars)
              {
               lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0;
               fs=1;countBarh=0;countBarl=0;countBarExt=0;
               zz[bi]=Low[bi];
               zzL[bi]=Low[bi];
               zzH[bi]=0;
               ai=i;
               tai=Time[i];
              }
            else if (countBarl>countBarh && countBarl>countBarExt && countBarl>minBars)
              {
               lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0;
               fs=2;countBarl=0;countBarh=0;countBarExt=0;
               zz[ai]=High[ai];
               zzH[ai]=High[ai];
               zzL[ai]=0;
               bi=i;
               tbi=Time[i];
              }
           }
         else
           {
            if (lLast_m==0 && hLast_m==0)
              {
               countBarl=0;countBarh=0;countBarExt=0;
              }

            // Тенденция восходящая
            if (fs==1)
              {
               if (countBarl>countBarh && countBarl>countBarExt && countBarl>minBars) // Определяем точку смены тенденции.
                 {
                  // запоминаем значение направления тренда fs на предыдущем баре
                  ai=iBarShift(Symbol(),Period(),tai); 
                  fs=2;
                  countBarl=0;

                  zz[ai]=High[ai];
                  zzH[ai]=High[ai];
                  zzL[ai]=0;
                  bi=i;
                  if (ExtLabel>0)
                    {
                     ha[ai]=High[ai]; la[ai]=0; // простановка меток на максимумах
                     tml=Time[i]; ha[i]=0; la[i]=Low[i]; // простановка метки на нисходящем луче
                    }
                  tbi=Time[i];

                  lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0;

                  for (n=0;countBarExt<minBars;n++) 
                    {
                     if (lLast<Low[i+n+1] && hLast>High[i+n+1]) {countBarExt++; countBarh++; lLast=Low[i+n+1]; hLast=High[i+n+1]; hLast_m=High[i];}
                     else break;
                    }

                  lLast=Low[i]; hLast=High[i];

                 }
              }

            // Тенденция нисходящая
            if (fs==2)
              {
               if (countBarh>countBarl && countBarh>countBarExt && countBarh>minBars) // Определяем точку смены тенденции.
                 {
                  // запоминаем значение направления тренда fs на предыдущем баре
                  bi=iBarShift(Symbol(),Period(),tbi);
                  fs=1;
                  countBarh=0;

                  zz[bi]=Low[bi];
                  zzL[bi]=Low[bi];
                  zzH[bi]=0;
                  ai=i;
                  if (ExtLabel>0)
                    {
                     ha[bi]=0; la[bi]=Low[bi];  // простановка меток на минимумах
                     tmh=Time[i]; ha[i]=High[i]; la[i]=0; // простановка метки на восходящем луче
                    }
                  tai=Time[i];

                  lLast=Low[i]; hLast=High[i]; lLast_m=0; hLast_m=0;

                  for (n=0;countBarExt<minBars;n++) 
                    {
                     if (lLast<Low[i+n+1] && hLast>High[i+n+1]) {countBarExt++; countBarl++; lLast=Low[i+n+1]; hLast=High[i+n+1]; lLast_m=Low[i];}
                     else break;
                    }

                  lLast=Low[i]; hLast=High[i];

                 }
              }
           } 
        } 
       if (i==0)
         {
          if (hLast<High[i] && fs==1) // Тенденция на текущем баре восходящая
            {
             ai=i; tai=Time[i]; zz[ai]=High[ai]; zzH[ai]=High[ai]; zzL[ai]=0;
             if (ExtLabel>0) {ha[ai]=High[ai]; la[ai]=0;} // гуляющая метка
            }
          else if (lLast>Low[i] && fs==2) // Тенденция на текущем баре нисходящая
            {
             bi=i; tbi=Time[i]; zz[bi]=Low[bi]; zzL[bi]=Low[bi]; zzH[bi]=0;
             if (ExtLabel>0) {la[bi]=Low[bi]; ha[bi]=0;} // гуляющая метка
            }
//===================================================================================================

      // Нулевой бар. Расчет первого луча ZigZag-a
          ai0=iBarShift(Symbol(),Period(),tai); 
          bi0=iBarShift(Symbol(),Period(),tbi);

          if (bi0>1) if (fs==1)
            {
             for (n=bi0-1; n>=0; n--) {zzH[n]=0.0; zz[n]=0.0; if (ExtLabel>0) ha[n]=0;}
             zz[ai0]=High[ai0]; zzH[ai0]=High[ai0]; zzL[ai0]=0.0; if (ExtLabel>0) ha[ai0]=High[ai0];
            }
          if (ai0>1) if (fs==2)
            {
             for (n=ai0-1; n>=0; n--) {zzL[n]=0.0; zz[n]=0.0; if (ExtLabel>0) la[n]=0;} 
             zz[bi0]=Low[bi0]; zzL[bi0]=Low[bi0]; zzH[bi0]=0.0; if (ExtLabel>0) la[bi0]=Low[bi0];
            }

          if (ExtLabel>0)
            {
             if (fs==1) {aim=iBarShift(Symbol(),0,tmh); if (aim<bi0) ha[aim]=High[aim];}
             else if (fs==2) {bim=iBarShift(Symbol(),0,tml); if (bim<ai0) la[bim]=Low[bim];}
            }

          if (ti<Time[1]) i=2;

         }
//====================================================================================================

     }
//--------------------------------------------
 }
//--------------------------------------------------------
// Свинги Ганна. Конец. 
//--------------------------------------------------------

//----------------------------------------------------
// nen-ZigZag. Режим DT. Начало.
//----------------------------------------------------
void nenZigZag()
 {
  if (cbi>0)
    {
//     datetime nen_time=iTime(NULL,GrossPeriod,ExtMinBar);
     datetime nen_time=iTime(NULL,GrossPeriod,0);
     int i=0, j=0; // j - номер бара с максимальным максимумом (минимальным минимумом) в полоске nen-ZigZag
     double nen_dt=0, last_j=0, last_nen=0; //last_j - значение максимального максимума (минимального минимума) в полоске nen_ZigZag
     int limit, big_limit, bigshift=0;

     int i_metka=-1, i_metka_m=-1, k, m, jm;
     bool fl_metka=false;
     double last_jm=0, last_nen_m=0;

//     if (ExtLabel>0) metka=1; else metka=0;
     if (ExtMaxBar>0) _maxbarZZ=ExtMaxBar; else _maxbarZZ=Bars;

     if (init_zz)
       {
        limit=_maxbarZZ-1;
        big_limit=iBars(NULL,GrossPeriod)-1;
       }
     else
       {
        limit=iBarShift(NULL,0,afr[2]);
        big_limit=iBarShift(NULL,GrossPeriod,afr[2]);
       }

     while (bigshift<big_limit && i<limit) // начальное заполнение буфера nen-ZigZag ("полоски")
       {
        if (Time[i]>=nen_time)
          {
           if (ExtIndicator==6)
             {
              if (ExtLabel>0)
                {
                 ha[i]=iCustom(NULL,GrossPeriod,"ZigZag_new_nen4",minBars,ExtDeviation,ExtBackstep,1,1,bigshift);
                 la[i]=iCustom(NULL,GrossPeriod,"ZigZag_new_nen4",minBars,ExtDeviation,ExtBackstep,1,2,bigshift);
                }
              nen_ZigZag[i]=iCustom(NULL,GrossPeriod,"ZigZag_new_nen4",minBars,ExtDeviation,ExtBackstep,0,0,bigshift);
             }
           else  if (ExtIndicator==7)
             {
              if (ExtLabel>0)
                {
                 ha[i]=iCustom(NULL,GrossPeriod,"DT_ZZ_nen",minBars,1,1,bigshift);
                 la[i]=iCustom(NULL,GrossPeriod,"DT_ZZ_nen",minBars,1,2,bigshift);
                }
              nen_ZigZag[i]=iCustom(NULL,GrossPeriod,"DT_ZZ_nen",minBars,0,0,bigshift);
             }
           else  if (ExtIndicator==8) nen_ZigZag[i]=iCustom(NULL,GrossPeriod,"CZigZag",minBars,ExtDeviation,0,bigshift);
           else  if (ExtIndicator==10)
             {
              if (ExtLabel>0)
                {
                 ha[i]=iCustom(NULL,GrossPeriod,"Swing_ZZ_1",minBars,1,1,bigshift);
                 la[i]=iCustom(NULL,GrossPeriod,"Swing_ZZ_1",minBars,1,2,bigshift);
                }
              nen_ZigZag[i]=iCustom(NULL,GrossPeriod,"Swing_ZZ_1",minBars,1,0,bigshift);
             }
           i++;
          }
        else {bigshift++;nen_time=iTime(NULL,GrossPeriod,bigshift);}
       }

     if (init_zz) // обработка истории
       {
        double i1=0, i2=0;
        init_zz=false;

        for (i=limit;i>ExtMinBar;i--) // определение направления первого луча
          {
           if (nen_ZigZag[i]>0)
             {
              if (i1==0) i1=nen_ZigZag[i];
              else if (i1>0 && i1!=nen_ZigZag[i]) i2=nen_ZigZag[i];
              if (i2>0) 
                {
                 if (i1>i2) hi_nen=true;
                 else hi_nen=false;
                 break;
                }
             }
          }
       }
     else // режим реального времени
       {
        if (afrl[2]>0) hi_nen=false; else hi_nen=true;
       }

     for (i=limit;i>=0;i--)
       {
//        if (i<limit) 
        {zz[i]=0; zzH[i]=0; zzL[i]=0;}

        if (nen_ZigZag[i]>0)
          {
           if (ExtLabel==2)
             {
              if (i_metka_m>=0 && !fl_metka)
                {
                 m=i_metka_m-GrossPeriod/Period();

                 for (k=i_metka_m; k>m; k--)
                   {
                    ha[k]=0; la[k]=0;
                   }

                 if (hi_nen) ha[jm]=last_nen_m;
                 else la[jm]=last_nen_m;
                 jm=0; last_nen_m=0; last_jm=0; i_metka_m=-1;
                }

              if (i_metka<0) i_metka=i;
             }

           fl_metka=true;

           if (nen_dt>0 && nen_dt!=nen_ZigZag[i])
             {
              if (i_metka>=0 && fl_metka)
                {
                 m=i_metka-GrossPeriod/Period();
                 for (k=i_metka; k>m; k--)
                   {
                    ha[k]=0; la[k]=0;
                   }
                 if (hi_nen) ha[j]=last_nen;
                 else la[j]=last_nen;
                 i_metka=i;
                }

              if (hi_nen) {hi_nen=false;zzH[j]=last_nen;}
              else {hi_nen=true;zzL[j]=last_nen;}
              last_j=0;nen_dt=0;zz[j]=last_nen;
             }

           if (hi_nen)
             {
              nen_dt=nen_ZigZag[i];
              if (last_j<High[i]) {j=i;last_j=High[i];last_nen=nen_ZigZag[i];}
             }
           else
             {
              nen_dt=nen_ZigZag[i];
              if (last_j==0) {j=i;last_j=Low[i];last_nen=nen_ZigZag[i];}
              if (last_j>Low[i]) {j=i;last_j=Low[i];last_nen=nen_ZigZag[i];}
             }

           if (nen_dt>0 && i==0)  // определение перелома на нулевом баре GrossPeriod
             {
              if (i_metka>=0 && fl_metka)
                {
                 m=i_metka-GrossPeriod/Period();
                 for (k=i_metka; k>m; k--)
                   {
                    ha[k]=0; la[k]=0;
                   }
                 if (hi_nen) ha[j]=last_nen;
                 else la[j]=last_nen;
                 fl_metka=false;
                }

              zz[j]=last_nen;
              if (hi_nen) zzH[j]=last_nen; else zzL[j]=last_nen;
             }
          }
        else
          {
           if (last_j>0 && fl_metka)
             {
              if (i_metka>=0 && fl_metka)
                {
                 m=i_metka-GrossPeriod/Period();

                 for (k=i_metka; k>m; k--)
                   {
                    ha[k]=0; la[k]=0;
                   }
                 if (hi_nen) ha[j]=last_nen;
                 else la[j]=last_nen;
                }

              fl_metka=false;

              if (hi_nen) {hi_nen=false;zzH[j]=last_nen;}
              else {hi_nen=true;zzL[j]=last_nen;}
              last_j=0;nen_dt=0;zz[j]=last_nen;
              i_metka=-1;
             }

           if (ExtLabel==2)
             {
              if ((ha[i]>0 || la[i]>0) && !fl_metka)
                {

                 if (i_metka_m<0)
                   { 
                    i_metka_m=i; jm=i;
                    if (hi_nen)
                      {
                       last_jm=High[i];last_nen_m=ha[i];
                      }
                    else
                      {
                       last_jm=Low[i];last_nen_m=la[i];
                      }
                   }

                 if (hi_nen)
                   {
                    if (last_nen_m>last_jm) {jm=i;last_jm=High[i];}
                   }
                 else
                   {
                    if (last_nen_m<last_jm) {jm=i;last_jm=Low[i];}
                   }
                }

             }
          }
       }
    }
 }
//--------------------------------------------------------
// nen-ZigZag. Режим DT. Конец. 
//--------------------------------------------------------

/*------------------------------------------------------------------+
|  ZigZag_Talex, ищет точки перелома на графике. Количество точек   |
|  задается внешним параметром ExtPoint.                            |
+------------------------------------------------------------------*/
void ZZTalex(int n)
{
/*переменные*/
   int    i,j,k,zzbarlow,zzbarhigh,curbar,curbar1,curbar2,EP,Mbar[];
   double curpr,Mprice[];
   bool flag,fd;
   
   /*начало*/
   
//   for(i=0;i<=Bars-1;i++)
//   {zz[i]=0.0;zzL[i]=0.0;zzH[i]=0.0;}
   ArrayInitialize(zz,0);ArrayInitialize(zzL,0);ArrayInitialize(zzH,0);
   
   EP=ExtPoint;
   zzbarlow=iLowest(NULL,0,MODE_LOW,n,0);        
   zzbarhigh=iHighest(NULL,0,MODE_HIGH,n,0);     
   
   if(zzbarlow<zzbarhigh) {curbar=zzbarlow; curpr=Low[zzbarlow];}
   if(zzbarlow>zzbarhigh) {curbar=zzbarhigh; curpr=High[zzbarhigh];}
   if(zzbarlow==zzbarhigh){curbar=zzbarlow;curpr=funk1(zzbarlow, n);}
   
   ArrayResize(Mbar,ExtPoint);
   ArrayResize(Mprice,ExtPoint);
   j=0;
   endpr=curpr;
   endbar=curbar;
   Mbar[j]=curbar;
   Mprice[j]=curpr;
   
   EP--;
   if(curpr==Low[curbar]) flag=true;
   else flag=false;
   fl=flag;
 
   i=curbar+1;
   while(EP>0)
   {
    if(flag)
    {
     while(i<=Bars-1)
     {
     curbar1=iHighest(NULL,0,MODE_HIGH,n,i); 
     curbar2=iHighest(NULL,0,MODE_HIGH,n,curbar1); 
     if(curbar1==curbar2){curbar=curbar1;curpr=High[curbar];flag=false;i=curbar+1;j++;break;}
     else i=curbar2;
     }
     
     Mbar[j]=curbar;
     Mprice[j]=curpr;
     EP--;
     
    }
    
    if(EP==0) break;
    
    if(!flag) 
    {
     while(i<=Bars-1)
     {
     curbar1=iLowest(NULL,0,MODE_LOW,n,i); 
     curbar2=iLowest(NULL,0,MODE_LOW,n,curbar1); 
     if(curbar1==curbar2){curbar=curbar1;curpr=Low[curbar];flag=true;i=curbar+1;j++;break;}
     else i=curbar2;
     }
     
     Mbar[j]=curbar;
     Mprice[j]=curpr;
     EP--;
    }
   }
   /* исправление вершин */
   if(Mprice[0]==Low[Mbar[0]])fd=true; else fd=false;
   for(k=0;k<=ExtPoint-1;k++)
   {
    if(k==0)
    {
     if(fd==true)
      {
       Mbar[k]=iLowest(NULL,0,MODE_LOW,Mbar[k+1]-Mbar[k],Mbar[k]);Mprice[k]=Low[Mbar[k]];endbar=minBars;
      }
     if(fd==false)
      {
       Mbar[k]=iHighest(NULL,0,MODE_HIGH,Mbar[k+1]-Mbar[k],Mbar[k]);Mprice[k]=High[Mbar[k]];endbar=minBars;
      }
    }
    if(k<ExtPoint-2)
    {
     if(fd==true)
      {
       Mbar[k+1]=iHighest(NULL,0,MODE_HIGH,Mbar[k+2]-Mbar[k]-1,Mbar[k]+1);Mprice[k+1]=High[Mbar[k+1]];
      }
     if(fd==false)
      {
       Mbar[k+1]=iLowest(NULL,0,MODE_LOW,Mbar[k+2]-Mbar[k]-1,Mbar[k]+1);Mprice[k+1]=Low[Mbar[k+1]];
      }
    }
    if(fd==true)fd=false;else fd=true;
    
    /* постройка ZigZag'a */
    zz[Mbar[k]]=Mprice[k];
    if (k==0)
      {
       if (Mprice[k]>Mprice[k+1])
         {
          zzH[Mbar[k]]=Mprice[k];
         }
       else
         {
          zzL[Mbar[k]]=Mprice[k];
         }
      }
    else
      {
       if (Mprice[k]>Mprice[k-1])
         {
          zzH[Mbar[k]]=Mprice[k];
         }
       else
         {
          zzL[Mbar[k]]=Mprice[k];
         }
      
      }
   }
  
 } 
//------------------------------------------------------------------
//  ZigZag_Talex конец                                              
//------------------------------------------------------------------

/*-------------------------------------------------------------------+
/ Фунция для поиска у первого бара (если он внешний) какой экстремум |
/ будем использовать в качестве вершины. Для ZigZag_Talex.           |
/-------------------------------------------------------------------*/
double funk1(int zzbarlow, int ExtDepth)
{
 double pr;
 int fbarlow,fbarhigh;
 
 fbarlow=iLowest(NULL,0,MODE_LOW,ExtDepth,zzbarlow);  
 fbarhigh=iHighest(NULL,0,MODE_HIGH,ExtDepth,zzbarlow);
 
 if(fbarlow>fbarhigh) pr=High[zzbarlow];
 if(fbarlow<fbarhigh) pr=Low[zzbarlow];
 if(fbarlow==fbarhigh)
 {
  fbarlow=iLowest(NULL,0,MODE_LOW,2*ExtDepth,zzbarlow);  
  fbarhigh=iHighest(NULL,0,MODE_HIGH,2*ExtDepth,zzbarlow);
  if(fbarlow>fbarhigh) pr=High[zzbarlow];
  if(fbarlow<fbarhigh) pr=Low[zzbarlow];
  if(fbarlow==fbarhigh)
  {
   fbarlow=iLowest(NULL,0,MODE_LOW,3*ExtDepth,zzbarlow);  
   fbarhigh=iHighest(NULL,0,MODE_HIGH,3*ExtDepth,zzbarlow);
   if(fbarlow>fbarhigh) pr=High[zzbarlow];
   if(fbarlow<fbarhigh) pr=Low[zzbarlow];
  }
 }
 return(pr);
}
//--------------------------------------------------------
// Конец. Для ZigZag_Talex.
//--------------------------------------------------------

//°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//  SQZZ by tovaroved.lv.  Начало.  °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
//°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
double div(double a, double b){if(MathAbs(b)*10000>MathAbs(a)) return(a*1.0/b); else return(0);}
//=============================================================================================
double ray_value(double B1, double P1, double B2, double P2, double AAA){return(P1+( AAA -B1)*div(P2-P1,B2-B1));}
//=============================================================================================
datetime bar2time(int b){int t,TFsec=Period()*60; if(b<0) t=Time[0]-(b)*TFsec; else if(b>(Bars-1)) t=Time[Bars-1]-(b-Bars+1)*TFsec; else t=Time[b];  return(t);}
//=============================================================================================
int time2bar(datetime t){int b,t0=Time[0],TFsec=Period()*60; if(t>t0) b=(t0-t)/TFsec; else if(t<Time[Bars-2]) b=(Bars-2)+(Time[Bars-2]-t)/TFsec; else b=iBarShift(0,0,t); return(b);}
//=============================================================================================
void ZigZag_SQZZ(bool zzFill=true){  static int act_time=0,	H1=10000,L1=10000,H2=10000,H3=10000,H4=10000,L2=10000,L3=10000,L4=10000;	
	static double H1p=-1,H2p=-1,H3p=-1, H4p=-1,	L1p=10000,L2p=10000,L3p=10000,L4p=10000;
	int   mnm=1,tb,sH,sL,sX, i, a, barz, b,c, ii, H,L;	double val,x,Lp,Hp,k=0.;   if(Bars<100) return; if(1==2)bar2time(0);
	barz=Bars-4;int bb=barz;
	if(minBars==0)minBars=minSize;	if(minSize==0)minSize=minBars*3; tb=MathSqrt(minSize*minBars);
	mnm=tb;
	a=time2bar(act_time);	b=barz;
	if(a>=0 && a<tb)
	  {
		ii=a;		a--;		L1+=a;		H1+=a;
		L2+=a;		H2+=a;		L3+=a;		H3+=a;
		if(!zzFill){
			for(i=barz; i>=a; i--) {zzH[i]=zzH[i-a];	zzL[i]=zzL[i-a];}
			for(;i>=0;i--) {zzH[i]=0;	zzL[i]=0;}
		}
	  }
	else
	  {
		ii=barz;
		H1=ii+1; L1=ii;
		H2=ii+3; L2=ii+2;
		L2p=Low[L2];H2p=High[H2];	
		L1p=Low[L1];H1p=High[H1];
		H3=H2;	H3p=H2p;
		L3=L2;	L3p=L2p;
     }
	act_time=Time[1];

	for(c=0; ii>=0; c++, ii--)
	  {
//		if(c>tb) if(zzFill)	zz[ii+mnm]=MathMax(zzL[ii+mnm],zzH[ii+mnm]);
//		if(c>tb) if(zzFill)	zz[ii]=MathMax(zzL[ii],zzH[ii]);
		H=ii; L=ii;		Hp=	High[H];	Lp=	Low[L];
		//-------------------------------------------------------------------------------------
		if(H2<L2)
		  {// хай уже есть готовый
			if( Hp>=H1p )
			  {
			   H1=H;	H1p=Hp;
				if( H1p>H2p )
				  {
					zzH[H2]=0;
					H1=H;	H1p=Hp;
					H2=H1;	H2p=H1p;
					L1=H1;	L1p=H1p;
					zzH[H2]=H2p;
				  }
			  }
			else if( Lp<=L1p )
			  {
			   L1=L;	L1p=Lp;
				x=ray_value(L2,L2p,H2+(L2-H3)*0.5,H2p+(L2p-H3p)*0.5,L1);
				if( L1p<=L2p//также работает L1p<=L2p*0.75+H2p*0.25 или любые другие условия
				    || tb*tb*Point<(H2p-L1p)*(H2-L1))
				  { //сдвигаем все Low
					L4=L3;	L4p=L3p;
					L3=L2;	L3p=L2p;
					L2=L1;	L2p=L1p;
					H1=L1;	H1p=L1p;
					zzL[L2]=L2p;
				  }
			  }
	     }
		//--------------------------------------------------------------
		if(L2<H2) {// лоу уже есть готовый
			if( Lp<=L1p )
			  {L1=L;	L1p=Lp;
				if( L1p<=L2p )
				  {
					zzL[L2]=0;
					L1=L;	L1p=Lp;
					L2=L1;	L2p=L1p;
					H1=L1;	H1p=L1p;
					zzL[L2]=L2p;
				  }
			  }
			else if( Hp>=H1p )
			  {
			   H1=H;	H1p=Hp;
				x=ray_value(H2,H2p,L2+0.5*(H2-L3),L2p+0.5*(H2p-L3p),H1);
				if( H1p>=H2p//можно и так: H1p>=H2p*0.75+L2p*0.25
				    || tb*tb*Point<(H1p-L2p)*(L2-H1))
				  { //сдвигаем все High
					H4=H3;	H4p=H3p;
					H3=H2;	H3p=H2p;
					H2=H1;	H2p=H1p;
					L1=H1;	L1p=H1p;
					zzH[H2]=H2p;
				  }
			   }

    		}//--------------------------------------------------------------------------------
	  }//for
	for(ii=bb-1; ii>=0; ii--) zz[ii]=MathMax(zzL[ii],zzH[ii]);
}//°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
// SQZZ by tovaroved.lv. Конец. 
//--------------------------------------------------------=======================================================================

//--------------------------------------------------------
// ZZ_2L_nen . Начало.
//#property copyright "Copyright © 2007, wellx. ver 0.07 alpha"
//#property link      "aveliks@gmail.com"
//--------------------------------------------------------
void ZZ_2L_nen()
  {
   int count = IndicatorCounted();
   int    k, i,shift,cnt, pos,curhighpos,curlowpos;

   if (Bars-count-1>2) 
     {
      count=0; NewBarTime=0; countbars=0; realcnt=0;
      ArrayInitialize(zz,0); ArrayInitialize(zzL,0); ArrayInitialize(zzH,0);
     }
   
   for (k=(Bars-count-1);k>=0;k--)
     {
   
      if(( NewBarTime==Time[0]) || (realcnt==Bars))
           first=false; 
      else first=true;
     
   
      //--------------------------------------------------------------------  
      //Находим первую точку индикатора
      //--------------------------------------------------------------------
      if (first)    
       {
         lastlowpos=Bars-1;
         lasthighpos=Bars-1;
         zzL[Bars-1]=0.0;
         zzH[Bars-1]=0.0;
         zz[Bars-1]=0.0;
         realcnt=2;
      
         for(shift=(Bars-2); shift>=0; shift--)
          {
            if ((High[shift]>High[shift+1]) && (Low[shift]>=Low[shift+1])) 
               {
                  zzL[shift]=0.0;
                  zzH[shift]=High[shift];
                  zz[shift]=High[shift];
                  lasthighpos=shift;
                  lasthigh=High[shift];
                  lastlow=Low[Bars-1];
                  pos=shift;
                  first=false;
                  break;          
               }
            if ((High[shift]<=High[shift+1]) && (Low[shift]<Low[shift+1])) 
               {
                  zzL[shift]=Low[shift];
                  zzH[shift]=0.0;
                  zz[shift]=Low[shift];
                  lasthigh=High[Bars-1];
                  lastlowpos=shift;
                  lastlow=Low[shift];
                  pos=shift;
                  first=false;
                  break;
               }
            if ((High[shift]>High[shift+1]) && (Low[shift]<Low[shift+1])) 
               {
                 if ((High[shift]-High[shift+1])>(Low[shift+1]-Low[shift]))
                  {
                     zzL[shift]=0.0;
                     zzH[shift]=High[shift];
                     zz[shift]=High[shift];
                     zzL[shift]=0.0;
                     lasthighpos=shift;
                     lasthigh=High[shift];
                     lastlow=Low[Bars-1];
                     pos=shift;
                     first=false;
                     break;
                  }
            if ((High[shift]-High[shift+1])<(Low[shift+1]-Low[shift]))
               {
                  zzL[shift]=Low[shift];
                  zzH[shift]=0.0;
                  zz[shift]=Low[shift];
                  lasthighpos=shift;
                  lasthigh=High[shift];
                  lastlow=Low[Bars-1];
                  pos=shift;
                  first=false;
                  break;
               } 
            if ((High[shift]-High[shift+1])==(Low[shift+1]-Low[shift]))
               {
                  zzL[shift]=0.0;
                  zzH[shift]=0.0;
                  zz[shift]=0.0;
               } 
         }   
         if  ((High[shift]<High[shift+1]) && (Low[shift]>Low[shift+1])) 
           {
              zzL[shift]=0.0;
              zzH[shift]=0.0;
              zz[shift]=0.0;
         }  
         pos=shift;
         realcnt=realcnt+1;   
         }
      
         //-------------------------------------------------------------------------
         // здесь начинается отработка основного цикла ЗЗ
         //-------------------------------------------------------------------------
          
         for(shift=pos-1; shift>=0; shift--)
          {
           if ((High[shift]>High[shift+1]) && (Low[shift]>=Low[shift+1]))
            {
               if (lasthighpos<lastlowpos)
                {
                  if (High[shift]>High[lasthighpos])
                    {
                     zzL[shift]=0.0;
                     zzH[shift]=High[shift];
                     zz[shift]=High[shift];
                     zz[lasthighpos]=0.0;
                     if (shift!=0)
                        lasthighpos=shift;
                     lasthigh=High[shift];
                     if (lastlowpos!=Bars) 
                        {
                        // Надо рассчитать позднее длины лучей
                        }
                  }  
               } 
               if (lasthighpos>lastlowpos) 
                  {
                     if ((((High[shift]-Low[lastlowpos])>(StLevel*Point)) && ((lastlowpos-shift)>=minBars))  ||
                          ((High[shift]-Low[lastlowpos])>=(BigLevel*Point))) 
                     {
                        zzL[shift]=0.0;
                        zzH[shift]=High[shift];
                        zz[shift]=High[shift];
                        //zz[lasthighpos]=0.0;
                        if (shift!=0)
                           lasthighpos=shift;
                        lasthigh=High[shift]; 
                     }
                  }    
            }
           if ((High[shift]<=High[shift+1]) && (Low[shift]<Low[shift+1]))
            {
             if (lastlowpos<lasthighpos)
              {
               if (Low[shift]<Low[lastlowpos])
                { 
                  zzL[shift]=Low[shift];
                  zzH[shift]=0.0;
                  zz[shift]=Low[shift];
                  zz[lastlowpos]=0.0;
                  if (shift!=0)
                     lastlowpos=shift;
                  lastlow=Low[shift];
                }
             }
             if (lastlowpos>lasthighpos)
              {
               if ((((High[lasthighpos]-Low[shift])>(StLevel*Point)) && ((lasthighpos-shift)>=minBars))  ||
                    ((High[lasthighpos]-Low[shift])>=(BigLevel*Point))) 
                {
                  zzL[shift]=Low[shift];
                  zzH[shift]=0.0;
                  zz[shift]=Low[shift];
                  //zz[lastlowpos]=0.0;
                  if (shift!=0)
                     lastlowpos=shift;
                  lastlow=Low[shift]; 
               }
             } 
           }
           if ((High[shift]>High[shift+1]) && (Low[shift]<Low[shift+1]))
            {
             if (lastlowpos<lasthighpos)
              {
               if (Low[shift]<Low[lastlowpos])
                {
                  zzL[shift]=Low[shift];
                  zzH[shift]=0.0;
                  zz[shift]=Low[shift];
                  zz[lastlowpos]=0.0;
                  if (shift!=0) 
                     lastlowpos=shift;
                  lastlow=Low[shift];
               } 
             }
             if (lasthighpos<lastlowpos) 
              {
               if (High[shift]>High[lasthighpos])
                {
                  zzL[shift]=0.0;
                  zzH[shift]=High[shift];
                  zz[shift]=High[shift];
                  zz[lasthighpos]=0.0;
                  if (shift!=0)
                     lasthighpos=shift;
                  lasthigh=High[shift];
               }
             }
           } 
           realcnt=realcnt+1; 
           // if (shift<=0)
        }
        
       first=false; 
       countbars=Bars;
       NewBarTime=Time[0];
    }
    
    //****************************************************************************************************
    //
    //   Обработка нулевого бара
    //
    //****************************************************************************************************    
    else
    //if (!first) 
    
    { 
     if (realcnt!=Bars)
     {
      first=True;
      return(0);
     } 
        
     if (Close[0]>=lasthigh) 
      {
       if (lastlowpos<lasthighpos)
        {
          if (Low[0]>lastlow)
           {
            if ((((High[0]-Low[lastlowpos])>(StLevel*Point)) && ((lastlowpos)>=minBars))  ||
                 ((High[0]-Low[lastlowpos])>(BigLevel*Point))) 
              {
               zzL[0]=0.0;
               zzH[0]=High[0];
               zz[0]=High[0]; 
               lasthigh=High[0];
               // lasthighpos=0;
              }
           }
        }
       if (lastlowpos>lasthighpos)
        {
         if (High[0]>=lasthigh)
          {
           zz[lasthighpos]=0.0;
           zz[0]=High[0];
           zzL[0]=0.0;
           zzH[0]=High[0];
           lasthighpos=0;
           lasthigh=High[0];
          }
        }  
       //lasthigh=High[0];
      }
     if (Close[0]<=lastlow) 
      {
       if (lastlowpos<lasthighpos)
        {
           zz[lastlowpos]=0.0;
           zz[0]=Low[0];
           zzL[0]=Low[0];
           zzH[0]=0.0;
           lastlow=Low[0];
           lastlowpos=0;  
        //  }
        }
       if (lastlowpos>lasthighpos)
        {
         if (High[0]<lasthigh)
          {
           if ((((High[lasthighpos]-Low[shift])>(StLevel*Point)) && ((lasthighpos-shift)>=minBars))  ||
                  ((High[lasthighpos]-Low[shift])>(BigLevel*Point)))
            {
             zz[0]=Low[0];
             zzL[0]=Low[0];
             zzH[0]=0.0;
             lastlow=Low[0];
             // lastlowpos=0;
            } 
          }
        }  
       //lastlow=Low[0];
      }
    }  
     
 return(0);
  }

  }
//--------------------------------------------------------
// ZZ_2L_nen . Конец.
//#property copyright "Copyright © 2007, wellx. ver 0.07 alpha"
//#property link      "aveliks@gmail.com"
//--------------------------------------------------------

//--------------------------------------------------------
// Индикатор i-vts . Начало. 
//--------------------------------------------------------
//+------------------------------------------------------------------+
//|                                                        i-VTS.mq4 |
//|                                                    Тахир & KimIV |
//|                                              http://www.kimiv.ru |
//|                                                                  |
//|  06.12.2005  Индикатор VTS                                       |
//+------------------------------------------------------------------+
//
// Этот индикатор Игорь Ким перевел с MQL на MQ4
//
void i_vts() //
  {
   int    LoopBegin, sh;

 	if (NumberOfBars==0) LoopBegin=Bars-1;
   else LoopBegin=NumberOfBars-1;
   LoopBegin=MathMin(Bars-25, LoopBegin);

   for (sh=LoopBegin; sh>=0; sh--)
     {
      GetValueVTS("", 0, NumberOfVTS, sh);
      ha[sh]=ms[0];
      la[sh]=ms[1];
     }
  }

void i_vts1() //
  {
   int    LoopBegin, sh;

 	if (NumberOfBars==0) LoopBegin=Bars-1;
   else LoopBegin=NumberOfBars-1;
   LoopBegin=MathMin(Bars-25, LoopBegin);

   for (sh=LoopBegin; sh>=0; sh--)
     {
      GetValueVTS("", 0, NumberOfVTS1, sh);
      ham[sh]=ms[0];
      lam[sh]=ms[1];
     }
  }
//+------------------------------------------------------------------+
//------- Поключение внешних модулей ---------------------------------
//+------------------------------------------------------------------+
//| Параметры:                                                       |
//|   sym - наименование инструмента                                 |
//|   tf  - таймфрейм (количество минут)                             |
//|   ng  - номер группы                                             |
//|   nb  - номер бара                                               |
//|   ms  - массив сигналов                                          |
//+------------------------------------------------------------------+
void GetValueVTS(string sym, int tf, int ng, int nb)
  {
   if (sym=="") sym=Symbol();
   double f1, f2, s1, s2;

   f1=iClose(sym, tf, nb)-3*iATR(sym, tf, 10, nb);
   f2=iClose(sym, tf, nb)+3*iATR(sym, tf, 10, nb);
   for (int i=1; i<=ng; i++)
     {
      s1=iClose(sym, tf, nb+i)-3*iATR(sym, tf, 10, nb+i);
      s2=iClose(sym, tf, nb+i)+3*iATR(sym, tf, 10, nb+i);
      if (f1<s1) f1=s1;
      if (f2>s2) f2=s2;
     }
    ms[0]=f2;   // верхняя линия
    ms[1]=f1;   // нижняя линия
  }
//+------------------------------------------------------------------+
//--------------------------------------------------------
// Индикатор i-vts . Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Параметры разных таймфреймов и другая информация. Начало. 
//--------------------------------------------------------
void info_TF()
  {
   string info, info1="", info2="", info3="", info4="", txt, txt0="", txt1="", regim, perc, mp0="", mp1="";
   int i, j=0, k;
   double pips;

   openTF[0]=iOpen(NULL,PERIOD_MN1,0);
   closeTF[0]=iClose(NULL,PERIOD_MN1,0);
   lowTF[0]=iLow(NULL,PERIOD_MN1,0);
   highTF[0]=iHigh(NULL,PERIOD_MN1,0);
   
   openTF[1]=iOpen(NULL,PERIOD_W1,0);
   closeTF[1]=iClose(NULL,PERIOD_W1,0);
   lowTF[1]=iLow(NULL,PERIOD_W1,0);
   highTF[1]=iHigh(NULL,PERIOD_W1,0);
   
   openTF[2]=iOpen(NULL,PERIOD_D1,0);
   closeTF[2]=iClose(NULL,PERIOD_D1,0);
   lowTF[2]=iLow(NULL,PERIOD_D1,0);
   highTF[2]=iHigh(NULL,PERIOD_D1,0);
   
   openTF[3]=iOpen(NULL,PERIOD_H4,0);
   closeTF[3]=iClose(NULL,PERIOD_H4,0);
   lowTF[3]=iLow(NULL,PERIOD_H4,0);
   highTF[3]=iHigh(NULL,PERIOD_H4,0);
   
   openTF[4]=iOpen(NULL,PERIOD_H1,0);
   closeTF[4]=iClose(NULL,PERIOD_H1,0);
   lowTF[4]=iLow(NULL,PERIOD_H1,0);
   highTF[4]=iHigh(NULL,PERIOD_H1,0);
   
   if (StringSubstr(info_comment,2,1)=="1")
     {
      if (minPercent>0) perc=DoubleToStr(MathAbs(minPercent),1); else perc="0.0";
      switch (ExtIndicator)
        {
         case 0     : {regim=" | "+ ExtIndicator + " / " + minBars + " / " + ExtDeviation + " / " + ExtBackstep;      break;}
         case 1     : {regim=" | "+ ExtIndicator + " / " + minSize + " / " + perc+" %";     break;}
         case 2     : {regim=" | "+ ExtIndicator + " / " + minBars + "/" + minSize;    break;}
         case 3     : {regim=" | "+ ExtIndicator + " / " + minBars;    break;}
         case 4     : {regim=" | "+ ExtIndicator + " / " + minSize;    break;}
         case 5     : {regim=" | "+ ExtIndicator + " / " + minBars;    break;}
         case 6     : {regim=" | "+ ExtIndicator + " / " + GrossPeriod + " / " + minBars + " / " + ExtDeviation + " / " + ExtBackstep;      break;}
         case 7     : {regim=" | "+ ExtIndicator + " / " + GrossPeriod + " / " + minBars;      break;}
         case 8     : {regim=" | "+ ExtIndicator + " / " + GrossPeriod + " / " + minBars + " / " + ExtDeviation;      break;}
         case 10    : {regim=" | "+ ExtIndicator + " / " + GrossPeriod + " / " + minBars;      break;}
         case 11    : {regim=" | "+ ExtIndicator + " / " + Depth + " / " + ExtDeviation + " / " + ExtBackstep;    break;}
         case 12    : {regim=" | "+ ExtIndicator + " / " + minSize;    break;}
         case 13    : {regim=" | "+ ExtIndicator + " / " + minBars + " / " + minSize;    break;}
         case 14    : {regim=" | "+ ExtIndicator + " / " + StLevel + " / " + BigLevel + " / "  + minBars;    break;}
        }
     }
   if (ExtPitchforkStatic>0)
     {
      if (ExtCustomStaticAP)
        {
          regim=regim + " / APm";
        }
      else
        {
         if (ExtPitchforkCandle) regim=regim + " / APs-bars";
         else regim=regim + " / APs-" + ExtPitchforkStaticNum;
        }
     }
 
   info="";

   if (StringSubstr(info_comment,0,1)=="1")
     {
      for (i=0;i<5;i++)
        {
         pips=(highTF[i]-lowTF[i])/Point;
         if (pips>0)
           {
            if (openTF[i]==closeTF[i]) {txt=" = ";}
            else if (openTF[i]!=closeTF[i] && MathAbs((highTF[i]-lowTF[i])/(openTF[i]-closeTF[i]))>=6.6) {txt=" -|- ";}
            else if (openTF[i]>closeTF[i]) {txt=" \/ ";}
            else if (openTF[i]<closeTF[i]) {txt=" /\ ";}
            info=info + TF[i] + txt + DoubleToStr(pips,0) + "   " +  DoubleToStr((closeTF[i]-lowTF[i])/(pips*Point),3) + " |  ";
           }
         else if (pips==0)
           {
            txt=" -|- ";
            info=info + TF[i] + txt + DoubleToStr(pips,0) + " |  ";
           }
        }
      info1=info;
     }

   if (StringSubstr(info_comment,1,1)=="1")
     {
      info1=info1+Period_tf;
      if (afrl[0]>0)
        {
         if (afrh[1]!=0) info1=info1+"  "+DoubleToStr(100*MathAbs(afrh[1]-afrl[0])/afrh[1],2)+" %";
        }
      else
        {
         if (afrl[1]!=0) info1=info1+"  "+DoubleToStr(100*MathAbs(afrh[0]-afrl[1])/afrl[1],2)+" %";
        }
     }
     info1=info1+regim;

   if (StringSubstr(info_comment,3,1)=="1")
     {
      if (StringLen(vNamePatternToNumberPattern)>0)
        {
         info2="It is found " + countGartley + " patterns  -  for pattern N " + NumberPattern + " - " + vBullBearToNumberPattern + " " + vNamePatternToNumberPattern + " - " + DoubleToStr(LevelForDminToNumberPattern,Digits) + " < Range of the prices D < " + DoubleToStr(LevelForDmaxToNumberPattern,Digits) + "";
        }
      else info2="";
     }

   if (StringSubstr(info_comment,4,1)=="1")
     {
      if (info_RZS_RL=="")
        {
         info="";
        }
      else
        {
         info="RL_Static="+info_RZS_RL + "    ";
        }

      info3=info;

      if (info_RZD_RL=="")
        {
         info3=info;
        }
      else
        {
         info3=info+"RL_Dinamic="+info_RZD_RL;
        }
     }

   if (infoMerrillPattern)
     {
      for (k=4;k>=0;k--)
        {
         j=mPeak0[k][1];
         txt0=txt0+j;
         j=mPeak1[k][1];
         txt1=txt1+j;
        }

      for (k=0;k<32;k++)
        {
         if (txt0==mMerrillPatterns[k][0]) {mp0=mMerrillPatterns[k][1]+"   "+mMerrillPatterns[k][2];}
         if (txt1==mMerrillPatterns[k][0]) {mp1=mMerrillPatterns[k][1]+"   "+mMerrillPatterns[k][2];}
        }

      if (StringLen(mp1)>0 && StringLen(mp0)>0) info4="Static  "+mp1+"  /  "+"Dinamic  "+mp0;
      else if (StringLen(mp1)>0) info4="Static  "+mp1;
      else if (StringLen(mp0)>0) info4="Dinamic  "+mp0;
     }

   //Comment(info1,"\n",info2,"\n",""+info3,"\n",""+info4);
//      if (RangeForPointD>0 && vNamePatternToNumberPattern != "")
   if (bigTetx)
     {
      nameObj="#_TextPattern_#" + ExtComplekt+"_";
      ObjectDelete(nameObj);
      ObjectCreate(nameObj,OBJ_LABEL,0,0,0);

      ObjectSetText(nameObj,vBullBearToNumberPattern + " " + vNamePatternToNumberPattern);
      ObjectSet(nameObj, OBJPROP_FONTSIZE, bigTetxSize);
      ObjectSet(nameObj, OBJPROP_COLOR, bigTetxColor);

      ObjectSet(nameObj, OBJPROP_CORNER, 1);
      ObjectSet(nameObj, OBJPROP_XDISTANCE, bigTetxX);
      ObjectSet(nameObj, OBJPROP_YDISTANCE, bigTetxY);

      if (infoMerrillPattern)
        {
         nameObj="#_TextPatternMP_#" + ExtComplekt+"_";
         ObjectDelete(nameObj);
         ObjectCreate(nameObj,OBJ_LABEL,0,0,0);

         ObjectSetText(nameObj,info4);
         ObjectSet(nameObj, OBJPROP_FONTSIZE, bigTetxSize);
         ObjectSet(nameObj, OBJPROP_COLOR, bigTetxColor);

         ObjectSet(nameObj, OBJPROP_CORNER, 1);
         ObjectSet(nameObj, OBJPROP_XDISTANCE, bigTetxX);
         ObjectSet(nameObj, OBJPROP_YDISTANCE, bigTetxY+2+bigTetxSize);
        }
     }
   
   // hmaryawan@gmail.com
   string tabs = "\n   ";
   string _sprt ="-------------------------------------------------------------";
   string text;
   text = text + tabs + "Symbol-Period : " + Symbol() +" - "+ Period_tf;
   text = text + tabs + "Spread            : "+ fixDigit(MarketInfo(Symbol(), MODE_SPREAD),0) + " pips";
   text = text + tabs + "Stop Level       : "+ fixDigit(MarketInfo(Symbol(), MODE_STOPLEVEL),0) + " pips";
   text = text + tabs + _sprt;
   text = text + tabs + "Pattern Found  : "+ vBullBear + " " + vNamePattern;
   text = text + tabs + _sprt;
   
   Comment(text);
   
   AlertSound(vBullBear + " " + vNamePattern);
   
   close_TF=Close[0];
  }
//--------------------------------------------------------
// Параметры разных таймфреймов и другая информация. Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Изменение размера массивов. Начало. 
//--------------------------------------------------------
void arrResize(int size)
  {
   ArrayResize(fi,size);
   ArrayResize(fitxt,size);
   ArrayResize(fitxt100,size);
  }
//--------------------------------------------------------
// Изменение размера массивов. Начало. 
//--------------------------------------------------------

//--------------------------------------------------------
// Создаем массивы с числами. Начало. 
//--------------------------------------------------------
void array_()
  {
   for (int i=0; i<65; i++)
     {
      numberFibo            [i]=0;
      numberPesavento       [i]=0;
      numberGartley         [i]=0;
      numberGilmorQuality   [i]=0;
      numberGilmorGeometric [i]=0;
      numberGilmorHarmonic  [i]=0;
      numberGilmorArithmetic[i]=0;
      numberGilmorGoldenMean[i]=0;
      numberSquare          [i]=0;
      numberCube            [i]=0;
      numberRectangle       [i]=0;
      numberExt             [i]=0;
     }

   number                [0]=0.111;
   numbertxt             [0]=".111";
   numberCube            [0]=1;

   number                [1]=0.125;
   numbertxt             [1]=".125";
   numberMix             [1]=1;
   numberGilmorHarmonic  [1]=1;

   number                [2]=0.146;
   numbertxt             [2]=".146";
   numberFibo            [2]=1;
   numberGilmorGeometric [2]=1;

   number                [3]=0.167;
   numbertxt             [3]=".167";
   numberGilmorArithmetic[3]=1;

   number                [4]=0.177;
   numbertxt             [4]=".177";
   numberGilmorHarmonic  [4]=1;
   numberSquare          [4]=1;

   number                [5]=0.186;
   numbertxt             [5]=".186";
   numberGilmorGeometric [5]=1;

   number                [6]=0.192;
   numbertxt             [6]=".192";
   numberCube            [6]=1;

   number                [7]=0.2;
   numbertxt             [7]=".2";
   numberRectangle       [7]=1;

   number                [8]=0.236;
   numbertxt             [8]=".236";
   numberFibo            [8]=1;
   numberMix             [8]=1;
   numberGilmorGeometric [8]=1;
   numberGilmorGoldenMean[8]=1;

   number                [9]=0.25;
   numbertxt             [9]=".25";
   numberPesavento       [9]=1;
   numberGilmorQuality   [9]=1;
   numberGilmorHarmonic  [9]=1;
   numberSquare          [9]=1;

   number                [10]=0.3;
   numbertxt             [10]=".3";
   numberGilmorGeometric [10]=1;
   numberGilmorGoldenMean[10]=1;

   number                [11]=0.333;
   numbertxt             [11]=".333";
   numberGilmorArithmetic[11]=1;
   numberCube            [11]=1;

   number                [12]=0.354;
   numbertxt             [12]=".354";
   numberGilmorHarmonic  [12]=1;
   numberSquare          [12]=1;

   number                [13]=0.382;
   numbertxt             [13]=".382";
   numberFibo            [13]=1;
   numberPesavento       [13]=1;
   numberGartley         [13]=1;
   numberGilmorQuality   [13]=1;
   numberGilmorGeometric [13]=1;

   number                [14]=0.447;
   numbertxt             [14]=".447";
   numberGartley         [14]=1;
   numberRectangle       [14]=1;

   number                [15]=0.486;
   numbertxt             [15]=".486";
   numberGilmorGeometric [15]=1;
   numberGilmorGoldenMean[15]=1;

   number                [16]=0.5;
   numbertxt             [16]=".5";
   numberFibo            [16]=1;
   numberPesavento       [16]=1;
   numberGartley         [16]=1;
   numberGilmorQuality   [16]=1;
   numberGilmorHarmonic  [16]=1;
   numberSquare          [16]=1;

   number                [17]=0.526;
   numbertxt             [17]=".526";
   numberGilmorGeometric [17]=1;

   number                [18]=0.577;
   numbertxt             [18]=".577";
   numberGilmorArithmetic[18]=1;
   numberCube            [18]=1;

   number                [19]=0.618;
   numbertxt             [19]=".618";
   numberFibo            [19]=1;
   numberPesavento       [19]=1;
   numberGartley         [19]=1;
   numberGilmorQuality   [19]=1;
   numberGilmorGeometric [19]=1;
   numberGilmorGoldenMean[19]=1;

   number                [20]=0.667;
   numbertxt             [20]=".667";
   numberGilmorQuality   [20]=1;
   numberGilmorArithmetic[20]=1;

   number                [21]=0.707;
   numbertxt             [21]=".707";
   numberPesavento       [21]=1;
   numberGartley         [21]=1;
   numberGilmorHarmonic  [21]=1;
   numberSquare          [21]=1;

   number                [22]=0.764;
   numbertxt             [22]=".764";
   numberFibo            [22]=1;

   number                [23]=0.786;
   numbertxt             [23]=".786";
   numberPesavento       [23]=1;
   numberGartley         [23]=1;
   numberGilmorQuality   [23]=1;
   numberGilmorGeometric [23]=1;
   numberGilmorGoldenMean[23]=1;

   number                [24]=0.809;
   numbertxt             [24]=".809";
   numberExt             [24]=1;

   number                [25]=0.841;
   numbertxt             [25]=".841";
   numberPesavento       [25]=1;

   number                [26]=0.854;
   numbertxt             [26]=".854";
   numberFibo            [26]=1;
   numberMix             [26]=1;

   number                [27]=0.874;
   numbertxt             [27]=".874";
   numberExt             [27]=1;

   number                [28]=0.886;
   numbertxt             [28]=".886";
   numberGartley         [28]=1;

   number                [29]=1.0;
   numbertxt             [29]="1.";
   numberFibo            [29]=1;
   numberPesavento       [29]=1;
   numberGartley         [29]=1;
   numberGilmorQuality   [29]=1;
   numberGilmorGeometric [29]=1;

   number                [30]=1.128;
   numbertxt             [30]="1.128";
   numberPesavento       [30]=1;
   numberGartley         [30]=1;

   number                [31]=1.236;
   numbertxt             [31]="1.236";
   numberFibo            [31]=1;

   number                [32]=1.272;
   numbertxt             [32]="1.272";
   numberPesavento       [32]=1;
   numberGartley         [32]=1;
   numberGilmorQuality   [32]=1;
   numberGilmorGeometric [32]=1;
   numberGilmorGoldenMean[32]=1;

   number                [33]=1.309;
   numbertxt             [33]="1.309";
   numberExt             [33]=1;

   number                [34]=1.414;
   numbertxt             [34]="1.414";
   numberPesavento       [34]=1;
   numberGartley         [34]=1;
   numberGilmorHarmonic  [34]=1;
   numberSquare          [34]=1;

   number                [35]=1.5;
   numbertxt             [35]="1.5";
//   numberPesavento       [35]=1;
   numberGilmorArithmetic[35]=1;

   number                [36]=phi;
   numbertxt             [36]="1.618";
   numberFibo            [36]=1;
   numberPesavento       [36]=1;
   numberGartley         [36]=1;
   numberGilmorQuality   [36]=1;
   numberGilmorGeometric [36]=1;
   numberGilmorGoldenMean[36]=1;

   number                [37]=1.732;
   numbertxt             [37]="1.732";
   numberMix             [37]=1;
   numberGilmorQuality   [37]=1;
   numberGilmorArithmetic[37]=1;
   numberCube            [37]=1;

   number                [38]=1.75;
   numbertxt             [38]="1.75";
   numberGilmorQuality   [38]=1;

   number                [39]=1.902;
   numbertxt             [39]="1.902";
   numberMix             [39]=1;
   numberGilmorGeometric [39]=1;

   number                [40]=2.0;
   numbertxt             [40]="2.";
   numberPesavento       [40]=1;
   numberGartley         [40]=1;
   numberGilmorQuality   [40]=1;
   numberGilmorHarmonic  [40]=1;
   numberSquare          [40]=1;

   number                [41]=2.058;
   numbertxt             [41]="2.058";
   numberGilmorGeometric [41]=1;
   numberGilmorGoldenMean[41]=1;

   number                [42]=2.236;
   numbertxt             [42]="2.236";
   numberGartley         [42]=1;
   numberGilmorQuality   [42]=1;
   numberRectangle       [42]=1;

   number                [43]=2.288;
   numbertxt             [43]="2.288";
   numberExt             [43]=1;

   number                [44]=2.5;
   numbertxt             [44]="2.5";
   numberGilmorQuality   [44]=1;

   number                [45]=2.618;
   numbertxt             [45]="2.618";
   numberPesavento       [45]=1;
   numberGartley         [45]=1;
   numberGilmorQuality   [45]=1;
   numberGilmorGeometric [45]=1;
   numberGilmorGoldenMean[45]=1;

   number                [46]=2.828;
   numbertxt             [46]="2.828";
   numberGilmorHarmonic  [46]=1;
   numberSquare          [46]=1;

   number                [47]=3.0;
   numbertxt             [47]="3.0";
   numberGilmorQuality   [47]=1;
   numberGilmorArithmetic[47]=1;
   numberCube            [47]=1;

   number                [48]=3.142;
   numbertxt             [48]="3.142";
   numberGartley         [48]=1;

   number                [49]=3.236;
   numbertxt             [49]="3.236";
   numberExt             [49]=1;

   number                [50]=3.33;
   numbertxt             [50]="3.33";
   numberGilmorQuality   [50]=1;
   numberGilmorGeometric [50]=1;
   numberGilmorGoldenMean[50]=1;
   numberExt             [50]=1;

   number                [51]=3.464;
   numbertxt             [51]="3.464";
   numberExt             [51]=1;

   number                [52]=3.618;
   numbertxt             [52]="3.618";
   numberGartley         [52]=1;

   number                [53]=4.0;
   numbertxt             [53]="4.";
   numberPesavento       [53]=1;
   numberGilmorHarmonic  [53]=1;
   numberSquare          [53]=1;

   number                [54]=4.236;
   numbertxt             [54]="4.236";
   numberFibo            [54]=1;
   numberGilmorQuality   [54]=1;
   numberGilmorGeometric [54]=1;
   numberExt             [54]=1;

   number                [55]=4.472;
   numbertxt             [55]="4.472";
   numberExt             [55]=1;

   number                [56]=5.0;
   numbertxt             [56]="5.";
   numberRectangle       [56]=1;

   number                [57]=5.2;
   numbertxt             [57]="5.2";
   numberCube            [57]=1;

   number                [58]=5.388;
   numbertxt             [58]="5.388";
   numberGilmorGeometric [58]=1;

   number                [59]=5.657;
   numbertxt             [59]="5.657";
   numberGilmorHarmonic  [59]=1;
   numberSquare          [59]=1;

   number                [60]=6.0;
   numbertxt             [60]="6.";
   numberGilmorArithmetic[60]=1;

   number                [61]=6.854;
   numbertxt             [61]="6.854";
   numberGilmorQuality   [61]=1;
   numberGilmorGeometric [61]=1;

   number                [62]=8.0;
   numbertxt             [62]="8.";
   numberGilmorHarmonic  [62]=1;

   number                [63]=9.0;
   numbertxt             [63]="9.";
   numberCube            [63]=1;
/*
   number                []=;
   numbertxt             []=;

// ExtFiboType=0
   numberFibo            []=;
// 0
   numberPesavento       []=;
// 1
   numberGartley         []=;
// 2
   numberMix             []=;
// 3
   numberGilmorQuality   []=;
// 4
   numberGilmorGeometric []=;
// 5
   numberGilmorHarmonic  []=;
// 6
   numberGilmorArithmetic[]=;
// 7
   numberGilmorGoldenMean[]=;
// 8
   numberSquare          []=;
// 9
   numberCube            []=;
// 10
   numberRectangle       []=;
// 11
   numberExt             []=;
*/
  }
//--------------------------------------------------------
// Создаем массивы с числами. Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Определение значений и цвета чисел для паттернов Песавенто. Начало. 
//--------------------------------------------------------
void Pesavento_patterns()
  {
   if (ExtFiboType==1)
     {
      switch (ExtFiboChoice)
        {
         case 0  : {search_number(numberPesavento, ExtPesavento)        ;break;}
         case 1  : {search_number(numberGartley, ExtGartley886)         ;break;}
         case 2  : {search_number(numberGartley, ExtGartley886)         ;break;}
         case 3  : {search_number(numberGilmorQuality, ExtPesavento)    ;break;}
         case 4  : {search_number(numberGilmorGeometric, ExtPesavento)  ;break;}
         case 5  : {search_number(numberGilmorHarmonic, ExtPesavento)   ;break;}
         case 6  : {search_number(numberGilmorArithmetic, ExtPesavento) ;break;}
         case 7  : {search_number(numberGilmorGoldenMean, ExtPesavento) ;break;}
         case 8  : {search_number(numberSquare, ExtPesavento)           ;break;}
         case 9  : {search_number(numberCube, ExtPesavento)             ;break;}
         case 10 : {search_number(numberRectangle, ExtPesavento)        ;break;}
         case 11 : {search_number(numberExt, ExtPesavento)              ;break;}
        }
      }
    else
      {
       search_number(numberFibo, ExtPesavento);
      }

  }
//--------------------------------------------------------
// Определение значений и цвета чисел для паттернов Песавенто. Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Поиск числа для паттернов Песавенто. Начало. 
//--------------------------------------------------------
void search_number(int arr[], color cPattern)
  {
   int ki;
   colorPPattern=ExtNotFibo;
   if (ExtFiboChoice!=2)
     {
      if (ExtDeltaType==2) for (ki=kiPRZ;ki<=63;ki++)
                             {
                              if (arr[ki]>0)
                                {
                                 if (MathAbs((number[ki]-kj)/number[ki])<=ExtDelta)
                                   {kk=number[ki]; txtkk=numbertxt[ki]; k2=-1; colorPPattern=cPattern; break;}
                                }
                             }

      if (ExtDeltaType==1) for (ki=kiPRZ;ki<=63;ki++)
                             {
                              if (arr[ki]>0)
                                {
                                 if (MathAbs(number[ki]-kj)<=ExtDelta)
                                   {kk=number[ki]; txtkk=numbertxt[ki]; k2=-1; colorPPattern=cPattern; break;}
                                }
                             }
     }
   else
     {
      if (ExtDeltaType==2) for (ki=kiPRZ;ki<=63;ki++)
                             {
                              if (arr[ki]>0)
                                {
                                 if (MathAbs((number[ki]-kj)/number[ki])<=ExtDelta)
                                   {kk=number[ki]; txtkk=numbertxt[ki]; k2=-1; colorPPattern=cPattern; break;}
                                }
                              else if (numberMix[ki]>0)
                                     if (MathAbs((number[ki]-kj)/number[ki])<=ExtDelta)
                                       {kk=number[ki]; txtkk=numbertxt[ki]; k2=-1; colorPPattern=ExtPesavento; break;}
                             }

      if (ExtDeltaType==1) for (ki=kiPRZ;ki<=63;ki++)
                             {
                              if (arr[ki]>0)
                                {
                                 if (MathAbs(number[ki]-kj)<=ExtDelta)
                                   {kk=number[ki]; txtkk=numbertxt[ki]; k2=-1; colorPPattern=cPattern; break;}
                                }
                              else if (numberMix[ki]>0)
                                     if (MathAbs(number[ki]-kj)<=ExtDelta)
                                       {kk=number[ki]; txtkk=numbertxt[ki]; k2=-1; colorPPattern=ExtPesavento; break;}
                             }
     }
  }
//--------------------------------------------------------
// Поиск числа для паттернов Песавенто. Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Отправка сообщения на электронную почту. Начало. 
//--------------------------------------------------------
void _SendMail(string subject, string some_text)
  {
   SendMail(subject, some_text);
  }
//--------------------------------------------------------
// Отправка сообщения на электронную почту. Конец. 
//--------------------------------------------------------

//--------------------------------------------------------
// Преобразование строки в цвет. Начало.
// Функцию написал Integer.  http://forum.mql4.com/ru/7134
//--------------------------------------------------------
color fStrToColor(string aName){
 
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
                     "Ivory", "Honeydew", "AliceBlue", "LavenderBlush", "MintCream", "Snow", "White", "CLR_NONE"
                  };
      aName=StringTrimLeft(StringTrimRight(aName));      
         for(int i=0;i<ArraySize(tName);i++){
            if(aName==tName[i])return(tColor[i]);
         }
      return(Red);                                     
                  
}
//--------------------------------------------------------
// Преобразование строки в цвет. Конец.
// Функцию написал Integer.  http://forum.mql4.com/ru/7134
//--------------------------------------------------------

/*
Отладочный аппендикс

/*
Print("1  ExtCustomStaticAP = ",ExtCustomStaticAP,"  UninitializeReason() = ",UninitializeReason());

   string file="\\Отладка\\ ";
   file=StringTrimRight(file)+Symbol()+"_"+Period()+"_"+ExtComplekt+".csv";
   int handle=FileOpen(file,FILE_CSV|FILE_WRITE,';');
   FileSeek(handle, 0, SEEK_END);
   FileWrite(handle, "1  ExtCustomStaticAP = ", ExtCustomStaticAP, "  UninitializeReason() = ",UninitializeReason());
   FileClose(handle);
*/
void AlertSound(string s_sign) {
   
   if (s_sign != s_last_signal) {
      s_last_signal = s_sign;
      
      if (StringFind(s_last_signal,"Bullish")!=-1) PlaySound("buysignal"); 
      if (StringFind(s_last_signal,"Bearish")!=-1) PlaySound("sellsignal");
      
   }
   
}

string fixDigit(double value, int digits=MODE_DIGITS) {
   if (digits!=MODE_DIGITS) {
      return(DoubleToStr(value,digits));
   }else{
      return(DoubleToStr(value,MarketInfo(Symbol(),digits)));
   }
}