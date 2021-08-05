//+--------------------------------------------------------------------------------------------+
//|   A omplete re-write of DWMRanges.mq4, original posted:                                    |
//|    http://www.forexfactory.com/showthread.php?p=9158963#post9158963                        | 
//|                                                                                            |
//+--------------------------------------------------------------------------------------------+ 
#property copyright "LukeB"
#property link      "http://www.forexfactory.com/lukeb" 
#property indicator_chart_window
string IndicatorName = "D1_W1_MN1_Ranges";
#property strict
//------- Constants for common values ------------------
const int ZEROSTART   = 0;
const int NOSHIFT     = 0;
const int CHARTWINDOW = 0;
const int NOTIME      = NULL;  // Same as zero
const string  NL      = "\n";
//Global External Inputs------------------------------------------------------------------------ 
enum BAR_SHIFT { BAR_ZERO, BAR_ONE };
extern bool   Daily_Line_On                   = true;   // Turn the line on and off
extern int    Daily_Range_Period              = 24;
extern bool   Weekly_Line_On                  = true;   // Turn the line on and off
extern int    Weekly_Range_Period             = 24;
extern bool   Monthly_Line_On                 = true;   // Turn the line on and off
extern int    Monthly_Range_Period            = 24;
extern BAR_SHIFT BAR_TO_USE                   = BAR_ONE;  // Use the forming bar, or the first complete bar
extern string Lines_Settings                  = "Lines Settings:"; 
extern color  dayHighLineClr                  = clrSalmon;
extern color  dayLowLineClr                   = clrSkyBlue;
extern color  weekHighLineClr                 = clrCrimson;
extern color  weekLowLineClr                  = clrRoyalBlue;
extern color  monthHighLineClr                = clrIndianRed;
extern color  monthLowLineClr                 = clrLightCoral;
extern ENUM_LINE_STYLE Line_Style             = STYLE_SOLID;    
extern int    LineThickness                   = 2;
extern string Line_Labels_FontStyle    = "Verdana";
extern int    Line_Labels_FontSize     = 10;
//
//+-------------------------------------------------------------------------------------------+
//| ------- Draw Lines -------------                                                          |                                                        
//+-------------------------------------------------------------------------------------------+
enum           LINEOBJECTS            { HI_TODAY,    LOW_TODAY,  HI_WEEK,    LOW_WEEK,  HI_MONTH,    LOW_MONTH, endLineObjects};  // Array Index to the 6 lines input properties
enum  LINE_MODE { LOW_LINE, HIGH_LINE };  // The lines can either show the high or the low of the range
const string   lineNames[]          = {"High_Today","Low_Today","High_Week","Low_Week","High_Month","Low_Month"};  // Give the lines nanmes
bool  lineSwitch[endLineObjects];   // Controls if a line is displayed or not.  Take the use input for a line being on or off
color lineColors[endLineObjects];   // Controls each lines color.  Take the use input for the line colors             
int   rangeBars[endLineObjects];    // Number of Bars to average for Range Average.
const ENUM_TIMEFRAMES linePeriods[] = { PERIOD_D1,   PERIOD_D1,  PERIOD_W1,  PERIOD_W1, PERIOD_MN1,  PERIOD_MN1};  // Array to store the timeframes for the lines
const LINE_MODE seriesMode[]        = { HIGH_LINE,   LOW_LINE,   HIGH_LINE,  LOW_LINE,  HIGH_LINE,   LOW_LINE};    // Array to indicate if the line is to be at the top of the range, or at the bottom
//
class RangeLine  // There will be an instance of this class for each range line (6 if all the lines are on)
 {
   private:
      static int      uniqueNumber;         // A Number to ensure names are unique to this indicator
      string          lineName;             // Name of the line
      color           lineColor;            // Color of ghe line
      int             lineWeight;           // weight of the line
      ENUM_LINE_STYLE lineStyle;            // The style of he line
      ENUM_TIMEFRAMES rangePeriod;          // Period for Locating the line
      LINE_MODE       lineMode;             // HIGH_LINE or LOW_LINE
      BAR_SHIFT       rangeBar;             // Bar to use to find a range on 
      datetime        startTime, endTime;   // Time for the line to start and end
      double          startPrice,endPrice;  // Price for the line to start ane end
      datetime        barZeroTime;          // New Bar Detection for updateing line endpoints and numbers.
      //
      string          lineLabelText;  // Text to display on the line
      ENUM_ANCHOR_POINT anchorPoint;        // Where to anchor the line text
      string          labelName;            // Name of the label objet
      int             labelSize;            // Font size of the label object
      string          labelStyle;           // Font style of the label object.
      int             barsToAverage;        // Number of bar' High or Lows to aveage.
      double          barsAverage;          // Hold the average High or Low for the bars. 
      ENUM_ANCHOR_POINT SetlabelAnchor(void);       // Sent the anchorPoint value
      void GetLabelAnchorPoint(datetime&, double&); // create the time and price values to anchor the lable object
      string CreateLineLabelText(void);             // set lineLabelText
      double          GetBarsAverage(void); // find the average of barsToAverage bars, and store it in barsAverage.
   protected:
      void PeriodBarZeroUpdates(void);      // Set the start and end point values
      void CreateLine(void);                // Create the line and set it's attributes
      void MoveLine(void);                  // Put the line in positions
      string MakeLabelText(void);           // Make the label text that will be displayed
      void CreateLineLabel(void);           // Place the label on the display
      void UpdateLineLabel(void);           // Move the lable to the current position
      void SetTheEndTime(void);             // Sets line End Point based on the Chart (not range period) timeframe.
   public:
      void ~RangeLine(void); // A Public Destructor
      void RangeLine(string objName, color objColor, int strokeWeight, ENUM_LINE_STYLE lineType,
                     ENUM_TIMEFRAMES workingPeriod, LINE_MODE HIGH_LOW, BAR_SHIFT aBar,
                     string textStyle, int textSize, int barsToCount);                             // A Pulblic Constructor
      void UpdateLine(void);                // update the line
      string GetInstanceInfo(void);         // Get an instance information string
 };
static int RangeLine::uniqueNumber = 863;   // Initialize static (global) class unique number
RangeLine *managedLines[];                  // Make an array of the lines
//+-------------------------------------------------------------------------------------------+
//| Indicator Initialization                                                                  |
//+-------------------------------------------------------------------------------------------+
int OnInit()
 {
   IndicatorShortName(IndicatorName);
   EventSetTimer(5);                      // create timer events / set frequency of timer events in seconds
   //  Load array indicating user selectable colors for each line.
   lineColors[HI_TODAY]  = dayHighLineClr;
   lineColors[LOW_TODAY] = dayLowLineClr;
   lineColors[HI_WEEK]   = weekHighLineClr;
   lineColors[LOW_WEEK]  = weekLowLineClr;
   lineColors[HI_MONTH]  = monthHighLineClr;
   lineColors[LOW_MONTH] = monthLowLineClr;
   // Load array indicating which lines are on and which are off.
   lineSwitch[HI_TODAY]  = Daily_Line_On;
   lineSwitch[LOW_TODAY] = Daily_Line_On;
   lineSwitch[HI_WEEK]   = Weekly_Line_On;
   lineSwitch[LOW_WEEK]  = Weekly_Line_On;
   lineSwitch[HI_MONTH]  = Monthly_Line_On;
   lineSwitch[LOW_MONTH] = Monthly_Line_On;
   // Load Number of Bars to average
   rangeBars[HI_TODAY]  = Daily_Range_Period;
   rangeBars[LOW_TODAY] = Daily_Range_Period;
   rangeBars[HI_WEEK]   = Weekly_Range_Period;
   rangeBars[LOW_WEEK]  = Weekly_Range_Period;
   rangeBars[HI_MONTH]  = Monthly_Range_Period;
   rangeBars[LOW_MONTH] = Monthly_Range_Period;
   //  Make a line object for each line to draw.
   int entryIndex = 0;
   for(int i = 0; i < endLineObjects; i++)  // Loop through all the possible line objects
    {
      if( lineSwitch[i] )   // Make the indicated line, else, skip it
       {  // you can check to see if resize and new work, however, the user will know if their PC has no memory and fails without trying to get the program to tell them.
         ArrayResize(managedLines,entryIndex+1);  // Make the array large enough to hold the new instance of RangeLine.
         managedLines[entryIndex] = new RangeLine(lineNames[i], lineColors[i], LineThickness, Line_Style, linePeriods[i], 
                      seriesMode[i], BAR_TO_USE, Line_Labels_FontStyle, Line_Labels_FontSize, rangeBars[i]);  // Make an instance of RangeLine for the line
         entryIndex++;
       }
    }
   //
   return(INIT_SUCCEEDED);
 }
//+-------------------------------------------------------------------------------------------+
//| Indicator De-initialization                                                               |
//+-------------------------------------------------------------------------------------------+ 
void OnDeinit(const int reason)
 {
   EventKillTimer();                   //--- destroy timer
   int arraySize = ArraySize(managedLines);  // Find the number of line instances
   for ( int i = 0; i < arraySize; i++ )  
    {
      delete(managedLines[i]);  // delete the line objects
    }
 }
//+-------------------------------------------------------------------------------------------+
//| Timer Events                                                                              |
//+-------------------------------------------------------------------------------------------+
void OnTimer()
 {
   for ( int i = 0; i < ArraySize(managedLines); i++ )
    {
      managedLines[i].UpdateLine();  // Update on timer; If a new bar occurs without a tick, it will still be updated at 'timer' frequency.
    }
 }
//+-------------------------------------------------------------------------------------------+
//| Indicator Main Loop Events                                                                |
//+-------------------------------------------------------------------------------------------+
int OnCalculate(const int rates_total, const int prev_calculated, const datetime &time[], const double &open[], const double &high[],
                const double &low[], const double &close[], const long& tick_volume[], const long& volume[], const int& spread[] )
 {
   if( prev_calculated == rates_total)  // When there is a new price quote inside an existing bar
    {
      for ( int i = 0; i < ArraySize(managedLines); i++ )  // update the lable on each range line
       {
         managedLines[i].UpdateLine();  // makes new text for the range line labels
       }
    }
   return(rates_total);
 }
//+-------------------------------------------------------------------------------------------+
//| --------- RangeLine Class Function Definitions -----------                                |
//+-------------------------------------------------------------------------------------------+
ENUM_ANCHOR_POINT RangeLine::SetlabelAnchor(void)  // select the anchor type for the range line description text.
 {
    ENUM_ANCHOR_POINT anchorValue;
    switch (rangePeriod)
    {
      case PERIOD_D1:
         switch (lineMode)
          {
            case HIGH_LINE:
               anchorValue = ANCHOR_RIGHT_UPPER;
               break;
            case LOW_LINE:
               anchorValue = ANCHOR_RIGHT_LOWER;
               break;
            default:
               anchorValue = ANCHOR_RIGHT;
               break;
          }
         break;
      case PERIOD_W1:
         switch (lineMode)
          {
            case HIGH_LINE:
               anchorValue = ANCHOR_RIGHT_UPPER;
               break;
            case LOW_LINE:
               anchorValue = ANCHOR_RIGHT_LOWER;
               break;
            default:
               anchorValue = ANCHOR_RIGHT;
               break;
          }
         break;
      case PERIOD_MN1:
         switch (lineMode)
          {
            case HIGH_LINE:
               anchorValue = ANCHOR_LEFT_UPPER;
               break;
            case LOW_LINE:
               anchorValue = ANCHOR_LEFT_LOWER;
               break;
            default:
               anchorValue = ANCHOR_RIGHT;
               break;
          }
         break;
      default:
         anchorValue = ANCHOR_RIGHT;
         Print("Text Anchor Defalted to ANCHOR_RIGHT, due to invalid Period value: ", IntegerToString(rangePeriod)); 
         break;
    }
   return(anchorValue);
 }
void RangeLine::GetLabelAnchorPoint(datetime& anchorTime, double& anchorPrice)  // Set the values for the Anchor Point (where the line label text will be displayed)
 {
    datetime timeFirstVisibleBar = iTime(Symbol(),Period(),WindowFirstVisibleBar()-1);  // find the time of the first visible time on the chart
    switch (rangePeriod)
    {
      case PERIOD_D1:
         switch (lineMode)
          {
            case HIGH_LINE:
               anchorTime  = endTime;
               anchorPrice = endPrice-(5*Point);
               break;
            case LOW_LINE:
               anchorTime  = endTime;
               anchorPrice = endPrice+(5*Point);
               break;
            default:
               anchorTime  = endTime;
               anchorPrice = endPrice;
               break;
          }
         break;
      case PERIOD_W1:
         switch (lineMode)
          {
            case HIGH_LINE:
             {
               anchorTime  = (startTime+endTime)/2;  // find the halfway time on the line
               datetime halfTime = (timeFirstVisibleBar + Time[0])/2; // find the halfway time on the chart
               if ( halfTime > anchorTime ) // anchorTime is more that 1/2 way to the left
                {
                  anchorTime = halfTime;
                }
               anchorPrice = endPrice-(5*Point);
             }
               break;
            case LOW_LINE:
             {
               anchorTime  = (startTime+endTime)/2;  // find the halfway time on the line
               datetime halfTime = (timeFirstVisibleBar + Time[0])/2; // find the halfway time on the chart
               if ( halfTime > anchorTime ) // anchorTime is more that 1/2 way to the left
               {
                  anchorTime = halfTime;
               }
               anchorPrice = endPrice+(5*Point);
             }
               break;
            default:
               anchorTime  = endTime;
               anchorPrice = endPrice;
               break;
          }
         break;
      case PERIOD_MN1:
         switch (lineMode)
          {
            case HIGH_LINE:
               if ( timeFirstVisibleBar > startTime ) // would the display start off-screen to the left?
                {
                  anchorTime  = timeFirstVisibleBar;
                } else
                {
                  anchorTime  = startTime;
                }
               anchorPrice = startPrice-(6*Point);
               break;
            case LOW_LINE:
               if ( timeFirstVisibleBar > startTime ) // would the display start off-screen to the left?
                {
                  anchorTime  = timeFirstVisibleBar;
                } else
                {
                  anchorTime  = startTime;
                }
               anchorPrice = startPrice+(5*Point);
               break;
            default:
               anchorTime  = endTime;
               anchorPrice = endPrice;
               break;
          }
         break;
      default:
         anchorTime  = endTime;
         anchorPrice = endPrice;
         Print("Text Anchor Point Defalted to Time: ",TimeToString(anchorTime),", Price: ",DoubleToStr(anchorPrice,Digits)); 
         break;
    }
 }
void RangeLine::PeriodBarZeroUpdates(void)  // Make updates that must be done when there is a new bar zero for the rangePeriod
 {
   if( barZeroTime != iTime(Symbol(),rangePeriod,NOSHIFT) )  // is there a new bar zero?  Only need to update on a new bar zero.
    {
      barZeroTime = iTime(Symbol(),rangePeriod,NOSHIFT);
      int theBar = 0;
      switch (lineMode)
       {
         case HIGH_LINE:
            // theBar     = iHighest(Symbol(),workingPeriod,lineMode,rangeBar,NOSHIFT);
            theBar = rangeBar;
            startPrice = iHigh(Symbol(),rangePeriod,theBar);
            break;
         case LOW_LINE:
            // theBar     = iLowest(Symbol(),workingPeriod,lineMode,rangeBar,NOSHIFT);
            theBar = rangeBar;
            startPrice = iLow(Symbol(),rangePeriod,theBar);
            break;
         default:
            Print("SetHighEndValues called with a wrong LINE_MODE value = ",IntegerToString(lineMode));
            break;
       }
      endPrice  = startPrice;
      startTime = iTime(Symbol(),rangePeriod,theBar);
      SetTheEndTime();  // Beak this out so it can be updated independently from zero bar updates (extend with new bars in the chart timeframe).
      endTime   = TimeCurrent() + (Period()*60*5);
      barsAverage = GetBarsAverage();  // This also has to be updated on new bar zero.  Maybe the function should be named "BarZeroUpdates".
   }
 }
void RangeLine::SetTheEndTime(void)
 {
   endTime   = TimeCurrent() + (Period()*60*5);  // extend the line past tge chart's bar zero (is likely a differet timeframe from rangePeriod).
 }
double RangeLine::GetBarsAverage(void)  // Get the average for the number of bars specified
 {
   double barTotal = 0;
   double barAverage;
   for(int i=barsToAverage; i > 0; i-- )
    {
      if ( lineMode == HIGH_LINE )
       {
         barTotal += iHigh(Symbol(),rangePeriod,i);
       } else  // lineMode == LOW_LINE
       {
         barTotal += iLow(Symbol(),rangePeriod,i);
       }
    }
   if ( barsToAverage > 0 )  // Ensure no zero denominator (it is a user inputable value)
    {
      barAverage = barTotal/barsToAverage;
    } else
    {
      barAverage = Ask;  // What ya gonna do?
    }
   return(barAverage);
 }
void RangeLine::CreateLine(void)   // This actually draws the line.
 {
   long chartID = ChartID();
   if ( ObjectFind(chartID,lineName)<0 )  // ObjectFind returns negative # if no object found
    {
      ObjectCreate(chartID,lineName,OBJ_TREND,CHARTWINDOW,startTime,startPrice,endTime,endPrice); // user will know if there is no line.  But, an error check is common.
      ObjectSetInteger(chartID,lineName,OBJPROP_COLOR,lineColor);
      ObjectSetInteger(chartID,lineName,OBJPROP_STYLE,lineStyle);
      ObjectSetInteger(chartID,lineName,OBJPROP_WIDTH,lineWeight);
      ObjectSetInteger(chartID,lineName,OBJPROP_RAY,false);          //  If you want the line to extend to the right edge, make this true
      ObjectSetInteger(chartID,lineName,OBJPROP_BACK,true);  
      ObjectSetInteger(chartID,lineName,OBJPROP_SELECTED,false); 
      ObjectSetInteger(chartID,lineName,OBJPROP_SELECTABLE,true);
      ObjectSetInteger(chartID,lineName,OBJPROP_HIDDEN,false);
    } else
    {
      MoveLine();   // If it already exists, just move it to its expected position.
    }
 }
void RangeLine::MoveLine(void)   // Function to move the line when there is a new bar - or on timer, restore it to position if user has messed with it.
 {
   bool successZero, successOne;
   if (ObjectFind(lineName)>-1)  // Object find returns 0 or positive # if object is found
    {
      successZero = ObjectMove(lineName,0,startTime,startPrice);  // I've never seen a fail, so doing nothing with the success check.
      successOne = ObjectMove(lineName,1,endTime,endPrice);
    } else
    {
      CreateLine();
    }
 }
string RangeLine::CreateLineLabelText(void)  // This part of the label text is constant
 {
   string periodText;
   switch (rangePeriod)
    {
      case PERIOD_D1:
         periodText = "D";
         break;
      case PERIOD_W1:
         periodText = "W";
         break;
      case PERIOD_MN1:
         periodText = "M";
         break;
      default:
         periodText = IntegerToString(rangePeriod);
         break;
    }
   string highLowTxt = lineMode==HIGH_LINE?"High":"Low";
   return(periodText+" Range "+highLowTxt);
 }
string RangeLine::MakeLabelText(void)  // add variable text to the LineLabelText for display
 {
   string lineLabel;
   switch (lineMode)   // Display the distance from the price action to the line, and to the average of the range bars
    {
      case HIGH_LINE:
         lineLabel = lineLabelText+" (Curr: "+DoubleToStr((startPrice - Ask)/Point,0)+" Avg: "+DoubleToStr((barsAverage-Ask)/Point,0)+" pts)";
         break;
      case LOW_LINE:
         lineLabel = lineLabelText+" (Curr: "+DoubleToStr((Bid - startPrice)/Point,0)+" Avg: "+DoubleToStr((Bid - barsAverage)/Point,0)+" pts}";
         break;
      default:
         lineLabel = lineLabelText+" No Mode (Curr: "+DoubleToStr((startPrice-Bid)/Point,0)+" Avg: "+DoubleToStr((barsAverage-Bid)/Point,0)+" pts}";
         break;
    }
   return(lineLabel);  // return the completed string
 }
void RangeLine::CreateLineLabel(void)  // Draw the label on its line
 {
   long chartID = ChartID();
   if ( ObjectFind(chartID,labelName) < 0 )
    {
      datetime anchorTime;
      double anchorPrice;
      GetLabelAnchorPoint(anchorTime, anchorPrice);
      ObjectCreate(chartID,labelName,OBJ_TEXT,CHARTWINDOW,anchorTime,anchorPrice); // user will know if there is no text.  But, an error check is common.
      ObjectSetString(chartID,labelName,OBJPROP_TEXT,MakeLabelText()); 
      ObjectSetString(chartID,labelName,OBJPROP_FONT,labelStyle); 
      ObjectSetInteger(chartID,labelName,OBJPROP_FONTSIZE,labelSize); 
      ObjectSetDouble(chartID,labelName,OBJPROP_ANGLE,0.0);
      ObjectSetInteger(chartID,labelName,OBJPROP_ANCHOR,anchorPoint);
      ObjectSetInteger(chartID,labelName,OBJPROP_COLOR,lineColor); 
      ObjectSetInteger(chartID,labelName,OBJPROP_BACK,true); 
      ObjectSetInteger(chartID,labelName,OBJPROP_SELECTABLE,false); 
      ObjectSetInteger(chartID,labelName,OBJPROP_SELECTED,false); 
      ObjectSetInteger(chartID,labelName,OBJPROP_HIDDEN,false);
    } else
    {
      UpdateLineLabel();  // If it already exists, just display it
    }
 }
void RangeLine::UpdateLineLabel(void)            // Move the lable to the current position
 {
   long chartID = ChartID();
   if ( ObjectFind(chartID,labelName) < 0 )  // If it doesn't exist, makeit.
    {
      CreateLineLabel();
    } else
    {
      datetime anchorTime;
      double anchorPrice;
      GetLabelAnchorPoint(anchorTime, anchorPrice);
      ObjectSetString(chartID,labelName,OBJPROP_TEXT,MakeLabelText()); // update the text
      ObjectMove(chartID,labelName,CHARTWINDOW,anchorTime,anchorPrice); 
    }
 }
void RangeLine::~RangeLine() // A Public Destructor
 {
   ObjectDelete(lineName);    // Delete the on-chart object
   ObjectDelete(labelName);   // Delete the on-chart object
 }
void RangeLine::RangeLine(string objName, color objColor, int strokeWeight, ENUM_LINE_STYLE lineType, ENUM_TIMEFRAMES workingPeriod,
                          LINE_MODE HIGH_LOW, BAR_SHIFT aBar, string textStyle, int textSize, int barsToCount) // A Pulblic Constructor
 {
   uniqueNumber++;  // each instance will display with its own unique number attached to its objects names.
   lineName = objName+IntegerToString(uniqueNumber);
   lineColor = objColor; lineWeight = strokeWeight; lineStyle = lineType; rangePeriod = workingPeriod;
   lineMode = HIGH_LOW; rangeBar = aBar; labelStyle=textStyle; labelSize=textSize; barsToAverage = barsToCount;
   barZeroTime = NOTIME;           // Initilize time to zero, ensure first time new bar calculations.
   anchorPoint = SetlabelAnchor();
   lineLabelText = CreateLineLabelText();
   labelName = lineLabelText+IntegerToString(uniqueNumber);
   PeriodBarZeroUpdates();
   CreateLine();
   CreateLineLabel();
 }
void RangeLine::UpdateLine(void)  // Update the line.
 {
   static datetime chartBarZeroTime = 0;
   PeriodBarZeroUpdates();                // Ensure updated for new bars and associated info
   if ( chartBarZeroTime != Time[0] )
    {
      SetTheEndTime();
    }
   MoveLine();                    // put the line in the expected location
   UpdateLineLabel();             // Update the line label.
   // Print("UpdateLine: ",lineName,", StartTime: ", TimeToStr(startTime,TIME_DATE|TIME_MINUTES),", End Time: ",TimeToStr(endTime,TIME_DATE|TIME_MINUTES));
 }
string RangeLine::GetInstanceInfo(void)  // no real use for this, but might be usefull in debug for prints.
 {
   return(lineName);
 }
//+-------------------------------------------------------------------------------------------+
//| ---------- End RangeLine Class function definitions                                       |
//+-------------------------------------------------------------------------------------------+
//+-------------------------------------------------------------------------------------------+
//| Indicator End                                                                             |
//+-------------------------------------------------------------------------------------------+

