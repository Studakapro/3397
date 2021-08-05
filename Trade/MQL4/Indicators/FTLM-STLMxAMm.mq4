//+------------------------------------------------------------------+
//| 
//+------------------------------------------------------------------+


#property indicator_separate_window
#property indicator_buffers 4
#property indicator_color1 Green
#property indicator_color2 Red
#property indicator_color3 Green
#property indicator_color4 Red


#property  indicator_width1  2
#property  indicator_width2  2
#property  indicator_width3  2
#property  indicator_width4  2


extern int CountBars=3000;
//---- buffers
double Up1[];
double Down1[];
double Up2[];
double Down2[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;
//---- indicator line
   IndicatorBuffers(5);
   SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(0,Up2);
   SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexBuffer(1,Down2);
   SetIndexStyle(2,DRAW_ARROW);
   SetIndexArrow(2,159);
   SetIndexBuffer(2,Up1);
   SetIndexStyle(3,DRAW_ARROW);
   SetIndexArrow(3,159);
   SetIndexBuffer(3,Down1);

   SetIndexLabel(0,"STLM+");
   SetIndexLabel(1,"STLM-");
   SetIndexLabel(2,"FTLM+");
   SetIndexLabel(3,"FTLM-");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| FTLM                                                             |
//+------------------------------------------------------------------+
int start()
  {
   SetIndexDrawBegin(0,Bars-CountBars+43);
   SetIndexDrawBegin(1,Bars-CountBars+43);
   int i,i2;
   double FTLM,FTLM1,value11,value21,value31,value41;
   double STLM,STLM1,value12,value22,value32,value42;
//----
   if(Bars<=90) return(0);
   
   int counted_bars=IndicatorCounted();
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
   i=Bars-counted_bars;
   if(counted_bars==0) i-=1+91;

   while(i>=0)
     {

      value11=
              0.4360409450*Close[i+0]
              +0.3658689069*Close[i+1]
              +0.2460452079*Close[i+2]
              +0.1104506886*Close[i+3]
              -0.0054034585*Close[i+4]
              -0.0760367731*Close[i+5]
              -0.0933058722*Close[i+6]
              -0.0670110374*Close[i+7]
              -0.0190795053*Close[i+8]
              +0.0259609206*Close[i+9]
              +0.0502044896*Close[i+10]
              +0.0477818607*Close[i+11]
              +0.0249252327*Close[i+12]
              -0.0047706151*Close[i+13]
              -0.0272432537*Close[i+14]
              -0.0338917071*Close[i+15]
              -0.0244141482*Close[i+16]
              -0.0055774838*Close[i+17]
              +0.0128149838*Close[i+18]
              +0.0226522218*Close[i+19]
              +0.0208778257*Close[i+20]
              +0.0100299086*Close[i+21]
              -0.0036771622*Close[i+22]
              -0.0136744850*Close[i+23]
              -0.0160483392*Close[i+24]
              -0.0108597376*Close[i+25]
              -0.0016060704*Close[i+26]
              +0.0069480557*Close[i+27]
              +0.0110573605*Close[i+28]
              +0.0095711419*Close[i+29]
              +0.0040444064*Close[i+30]
              -0.0023824623*Close[i+31]
              -0.0067093714*Close[i+32]
              -0.0072003400*Close[i+33]
              -0.0047717710*Close[i+34]
              +0.0005541115*Close[i+35]
              +0.0007860160*Close[i+36]
              +0.0130129076*Close[i+37]
              +0.0040364019*Close[i+38];

      value21=
              -0.0025097319*Close[i+0]
              +0.0513007762*Close[i+1]
              +0.1142800493*Close[i+2]
              +0.1699342860*Close[i+3]
              +0.2025269304*Close[i+4]
              +0.2025269304*Close[i+5]
              +0.1699342860*Close[i+6]
              +0.1142800493*Close[i+7]
              +0.0513007762*Close[i+8]
              -0.0025097319*Close[i+9]
              -0.0353166244*Close[i+10]
              -0.0433375629*Close[i+11]
              -0.0311244617*Close[i+12]
              -0.0088618137*Close[i+13]
              +0.0120580088*Close[i+14]
              +0.0233183633*Close[i+15]
              +0.0221931304*Close[i+16]
              +0.0115769653*Close[i+17]
              -0.0022157966*Close[i+18]
              -0.0126536111*Close[i+19]
              -0.0157416029*Close[i+20]
              -0.0113395830*Close[i+21]
              -0.0025905610*Close[i+22]
              +0.0059521459*Close[i+23]
              +0.0105212252*Close[i+24]
              +0.0096970755*Close[i+25]
              +0.0046585685*Close[i+26]
              -0.0017079230*Close[i+27]
              -0.0063513565*Close[i+28]
              -0.0074539350*Close[i+29]
              -0.0050439973*Close[i+30]
              -0.0007459678*Close[i+31]
              +0.0032271474*Close[i+32]
              +0.0051357867*Close[i+33]
              +0.0044454862*Close[i+34]
              +0.0018784961*Close[i+35]
              -0.0011065767*Close[i+36]
              -0.0031162862*Close[i+37]
              -0.0033443253*Close[i+38]
              -0.0022163335*Close[i+39]
              +0.0002573669*Close[i+40]
              +0.0003650790*Close[i+41]
              +0.0060440751*Close[i+42]
              +0.0018747783*Close[i+43];



      value31=
              0.4360409450*Close[i+0+1]
              +0.3658689069*Close[i+1+1]
              +0.2460452079*Close[i+2+1]
              +0.1104506886*Close[i+3+1]
              -0.0054034585*Close[i+4+1]
              -0.0760367731*Close[i+5+1]
              -0.0933058722*Close[i+6+1]
              -0.0670110374*Close[i+7+1]
              -0.0190795053*Close[i+8+1]
              +0.0259609206*Close[i+9+1]
              +0.0502044896*Close[i+10+1]
              +0.0477818607*Close[i+11+1]
              +0.0249252327*Close[i+12+1]
              -0.0047706151*Close[i+13+1]
              -0.0272432537*Close[i+14+1]
              -0.0338917071*Close[i+15+1]
              -0.0244141482*Close[i+16+1]
              -0.0055774838*Close[i+17+1]
              +0.0128149838*Close[i+18+1]
              +0.0226522218*Close[i+19+1]
              +0.0208778257*Close[i+20+1]
              +0.0100299086*Close[i+21+1]
              -0.0036771622*Close[i+22+1]
              -0.0136744850*Close[i+23+1]
              -0.0160483392*Close[i+24+1]
              -0.0108597376*Close[i+25+1]
              -0.0016060704*Close[i+26+1]
              +0.0069480557*Close[i+27+1]
              +0.0110573605*Close[i+28+1]
              +0.0095711419*Close[i+29+1]
              +0.0040444064*Close[i+30+1]
              -0.0023824623*Close[i+31+1]
              -0.0067093714*Close[i+32+1]
              -0.0072003400*Close[i+33+1]
              -0.0047717710*Close[i+34+1]
              +0.0005541115*Close[i+35+1]
              +0.0007860160*Close[i+36+1]
              +0.0130129076*Close[i+37+1]
              +0.0040364019*Close[i+38+1];

      value41=
              -0.0025097319*Close[i+0+1]
              +0.0513007762*Close[i+1+1]
              +0.1142800493*Close[i+2+1]
              +0.1699342860*Close[i+3+1]
              +0.2025269304*Close[i+4+1]
              +0.2025269304*Close[i+5+1]
              +0.1699342860*Close[i+6+1]
              +0.1142800493*Close[i+7+1]
              +0.0513007762*Close[i+8+1]
              -0.0025097319*Close[i+9+1]
              -0.0353166244*Close[i+10+1]
              -0.0433375629*Close[i+11+1]
              -0.0311244617*Close[i+12+1]
              -0.0088618137*Close[i+13+1]
              +0.0120580088*Close[i+14+1]
              +0.0233183633*Close[i+15+1]
              +0.0221931304*Close[i+16+1]
              +0.0115769653*Close[i+17+1]
              -0.0022157966*Close[i+18+1]
              -0.0126536111*Close[i+19+1]
              -0.0157416029*Close[i+20+1]
              -0.0113395830*Close[i+21+1]
              -0.0025905610*Close[i+22+1]
              +0.0059521459*Close[i+23+1]
              +0.0105212252*Close[i+24+1]
              +0.0096970755*Close[i+25+1]
              +0.0046585685*Close[i+26+1]
              -0.0017079230*Close[i+27+1]
              -0.0063513565*Close[i+28+1]
              -0.0074539350*Close[i+29+1]
              -0.0050439973*Close[i+30+1]
              -0.0007459678*Close[i+31+1]
              +0.0032271474*Close[i+32+1]
              +0.0051357867*Close[i+33+1]
              +0.0044454862*Close[i+34+1]
              +0.0018784961*Close[i+35+1]
              -0.0011065767*Close[i+36+1]
              -0.0031162862*Close[i+37+1]
              -0.0033443253*Close[i+38+1]
              -0.0022163335*Close[i+39+1]
              +0.0002573669*Close[i+40+1]
              +0.0003650790*Close[i+41+1]
              +0.0060440751*Close[i+42+1]
              +0.0018747783*Close[i+43+1];

      value12=
              0.0982862174*Close[i+0]
              +0.0975682269*Close[i+1]
              +0.0961401078*Close[i+2]
              +0.0940230544*Close[i+3]
              +0.0912437090*Close[i+4]
              +0.0878391006*Close[i+5]
              +0.0838544303*Close[i+6]
              +0.0793406350*Close[i+7]
              +0.0743569346*Close[i+8]
              +0.0689666682*Close[i+9]
              +0.0632381578*Close[i+10]
              +0.0572428925*Close[i+11]
              +0.0510534242*Close[i+12]
              +0.0447468229*Close[i+13]
              +0.0383959950*Close[i+14]
              +0.0320735368*Close[i+15]
              +0.0258537721*Close[i+16]
              +0.0198005183*Close[i+17]
              +0.0139807863*Close[i+18]
              +0.0084512448*Close[i+19]
              +0.0032639979*Close[i+20]
              -0.0015350359*Close[i+21]
              -0.0059060082*Close[i+22]
              -0.0098190256*Close[i+23]
              -0.0132507215*Close[i+24]
              -0.0161875265*Close[i+25]
              -0.0186164872*Close[i+26]
              -0.0205446727*Close[i+27]
              -0.0219739146*Close[i+28]
              -0.0229204861*Close[i+29]
              -0.0234080863*Close[i+30]
              -0.0234566315*Close[i+31]
              -0.0231017777*Close[i+32]
              -0.0223796900*Close[i+33]
              -0.0213300463*Close[i+34]
              -0.0199924534*Close[i+35]
              -0.0184126992*Close[i+36]
              -0.0166377699*Close[i+37]
              -0.0147139428*Close[i+38]
              -0.0126796776*Close[i+39]
              -0.0105938331*Close[i+40]
              -0.0084736770*Close[i+41]
              -0.0063841850*Close[i+42]
              -0.0043466731*Close[i+43]
              -0.0023956944*Close[i+44]
              -0.0005535180*Close[i+45]
              +0.0011421469*Close[i+46]
              +0.0026845693*Close[i+47]
              +0.0040471369*Close[i+48]
              +0.0052380201*Close[i+49]
              +0.0062194591*Close[i+50]
              +0.0070340085*Close[i+51]
              +0.0076266453*Close[i+52]
              +0.0080376628*Close[i+53]
              +0.0083037666*Close[i+54]
              +0.0083694798*Close[i+55]
              +0.0082901022*Close[i+56]
              +0.0080741359*Close[i+57]
              +0.0077543820*Close[i+58]
              +0.0073260526*Close[i+59]
              +0.0068163569*Close[i+60]
              +0.0062325477*Close[i+61]
              +0.0056078229*Close[i+62]
              +0.0049516078*Close[i+63]
              +0.0161380976*Close[i+64];

      value22=
              -0.0074151919*Close[i+0]
              -0.0060698985*Close[i+1]
              -0.0044979052*Close[i+2]
              -0.0027054278*Close[i+3]
              -0.0007031702*Close[i+4]
              +0.0014951741*Close[i+5]
              +0.0038713513*Close[i+6]
              +0.0064043271*Close[i+7]
              +0.0090702334*Close[i+8]
              +0.0118431116*Close[i+9]
              +0.0146922652*Close[i+10]
              +0.0175884606*Close[i+11]
              +0.0204976517*Close[i+12]
              +0.0233865835*Close[i+13]
              +0.0262218588*Close[i+14]
              +0.0289681736*Close[i+15]
              +0.0315922931*Close[i+16]
              +0.0340614696*Close[i+17]
              +0.0363444061*Close[i+18]
              +0.0384120882*Close[i+19]
              +0.0402373884*Close[i+20]
              +0.0417969735*Close[i+21]
              +0.0430701377*Close[i+22]
              +0.0440399188*Close[i+23]
              +0.0446941124*Close[i+24]
              +0.0450230100*Close[i+25]
              +0.0450230100*Close[i+26]
              +0.0446941124*Close[i+27]
              +0.0440399188*Close[i+28]
              +0.0430701377*Close[i+29]
              +0.0417969735*Close[i+30]
              +0.0402373884*Close[i+31]
              +0.0384120882*Close[i+32]
              +0.0363444061*Close[i+33]
              +0.0340614696*Close[i+34]
              +0.0315922931*Close[i+35]
              +0.0289681736*Close[i+36]
              +0.0262218588*Close[i+37]
              +0.0233865835*Close[i+38]
              +0.0204976517*Close[i+39]
              +0.0175884606*Close[i+40]
              +0.0146922652*Close[i+41]
              +0.0118431116*Close[i+42]
              +0.0090702334*Close[i+43]
              +0.0064043271*Close[i+44]
              +0.0038713513*Close[i+45]
              +0.0014951741*Close[i+46]
              -0.0007031702*Close[i+47]
              -0.0027054278*Close[i+48]
              -0.0044979052*Close[i+49]
              -0.0060698985*Close[i+50]
              -0.0074151919*Close[i+51]
              -0.0085278517*Close[i+52]
              -0.0094111161*Close[i+53]
              -0.0100658241*Close[i+54]
              -0.0104994302*Close[i+55]
              -0.0107227904*Close[i+56]
              -0.0107450280*Close[i+57]
              -0.0105824763*Close[i+58]
              -0.0102517019*Close[i+59]
              -0.0097708805*Close[i+60]
              -0.0091581551*Close[i+61]
              -0.0084345004*Close[i+62]
              -0.0076214397*Close[i+63]
              -0.0067401718*Close[i+64]
              -0.0058083144*Close[i+65]
              -0.0048528295*Close[i+66]
              -0.0038816271*Close[i+67]
              -0.0029244713*Close[i+68]
              -0.0019911267*Close[i+69]
              -0.0010974211*Close[i+70]
              -0.0002535559*Close[i+71]
              +0.0005231953*Close[i+72]
              +0.0012297491*Close[i+73]
              +0.0018539149*Close[i+74]
              +0.0023994354*Close[i+75]
              +0.0028490136*Close[i+76]
              +0.0032221429*Close[i+77]
              +0.0034936183*Close[i+78]
              +0.0036818974*Close[i+79]
              +0.0038037944*Close[i+80]
              +0.0038338964*Close[i+81]
              +0.0037975350*Close[i+82]
              +0.0036986051*Close[i+83]
              +0.0035521320*Close[i+84]
              +0.0033559226*Close[i+85]
              +0.0031224409*Close[i+86]
              +0.0028550092*Close[i+87]
              +0.0025688349*Close[i+88]
              +0.0022682355*Close[i+89]
              +0.0073925495*Close[i+90];

      value32=
              0.0982862174*Close[i+0+1]
              +0.0975682269*Close[i+1+1]
              +0.0961401078*Close[i+2+1]
              +0.0940230544*Close[i+3+1]
              +0.0912437090*Close[i+4+1]
              +0.0878391006*Close[i+5+1]
              +0.0838544303*Close[i+6+1]
              +0.0793406350*Close[i+7+1]
              +0.0743569346*Close[i+8+1]
              +0.0689666682*Close[i+9+1]
              +0.0632381578*Close[i+10+1]
              +0.0572428925*Close[i+11+1]
              +0.0510534242*Close[i+12+1]
              +0.0447468229*Close[i+13+1]
              +0.0383959950*Close[i+14+1]
              +0.0320735368*Close[i+15+1]
              +0.0258537721*Close[i+16+1]
              +0.0198005183*Close[i+17+1]
              +0.0139807863*Close[i+18+1]
              +0.0084512448*Close[i+19+1]
              +0.0032639979*Close[i+20+1]
              -0.0015350359*Close[i+21+1]
              -0.0059060082*Close[i+22+1]
              -0.0098190256*Close[i+23+1]
              -0.0132507215*Close[i+24+1]
              -0.0161875265*Close[i+25+1]
              -0.0186164872*Close[i+26+1]
              -0.0205446727*Close[i+27+1]
              -0.0219739146*Close[i+28+1]
              -0.0229204861*Close[i+29+1]
              -0.0234080863*Close[i+30+1]
              -0.0234566315*Close[i+31+1]
              -0.0231017777*Close[i+32+1]
              -0.0223796900*Close[i+33+1]
              -0.0213300463*Close[i+34+1]
              -0.0199924534*Close[i+35+1]
              -0.0184126992*Close[i+36+1]
              -0.0166377699*Close[i+37+1]
              -0.0147139428*Close[i+38+1]
              -0.0126796776*Close[i+39+1]
              -0.0105938331*Close[i+40+1]
              -0.0084736770*Close[i+41+1]
              -0.0063841850*Close[i+42+1]
              -0.0043466731*Close[i+43+1]
              -0.0023956944*Close[i+44+1]
              -0.0005535180*Close[i+45+1]
              +0.0011421469*Close[i+46+1]
              +0.0026845693*Close[i+47+1]
              +0.0040471369*Close[i+48+1]
              +0.0052380201*Close[i+49+1]
              +0.0062194591*Close[i+50+1]
              +0.0070340085*Close[i+51+1]
              +0.0076266453*Close[i+52+1]
              +0.0080376628*Close[i+53+1]
              +0.0083037666*Close[i+54+1]
              +0.0083694798*Close[i+55+1]
              +0.0082901022*Close[i+56+1]
              +0.0080741359*Close[i+57+1]
              +0.0077543820*Close[i+58+1]
              +0.0073260526*Close[i+59+1]
              +0.0068163569*Close[i+60+1]
              +0.0062325477*Close[i+61+1]
              +0.0056078229*Close[i+62+1]
              +0.0049516078*Close[i+63+1]
              +0.0161380976*Close[i+64+1];

      value42=
              -0.0074151919*Close[i+0+1]
              -0.0060698985*Close[i+1+1]
              -0.0044979052*Close[i+2+1]
              -0.0027054278*Close[i+3+1]
              -0.0007031702*Close[i+4+1]
              +0.0014951741*Close[i+5+1]
              +0.0038713513*Close[i+6+1]
              +0.0064043271*Close[i+7+1]
              +0.0090702334*Close[i+8+1]
              +0.0118431116*Close[i+9+1]
              +0.0146922652*Close[i+10+1]
              +0.0175884606*Close[i+11+1]
              +0.0204976517*Close[i+12+1]
              +0.0233865835*Close[i+13+1]
              +0.0262218588*Close[i+14+1]
              +0.0289681736*Close[i+15+1]
              +0.0315922931*Close[i+16+1]
              +0.0340614696*Close[i+17+1]
              +0.0363444061*Close[i+18+1]
              +0.0384120882*Close[i+19+1]
              +0.0402373884*Close[i+20+1]
              +0.0417969735*Close[i+21+1]
              +0.0430701377*Close[i+22+1]
              +0.0440399188*Close[i+23+1]
              +0.0446941124*Close[i+24+1]
              +0.0450230100*Close[i+25+1]
              +0.0450230100*Close[i+26+1]
              +0.0446941124*Close[i+27+1]
              +0.0440399188*Close[i+28+1]
              +0.0430701377*Close[i+29+1]
              +0.0417969735*Close[i+30+1]
              +0.0402373884*Close[i+31+1]
              +0.0384120882*Close[i+32+1]
              +0.0363444061*Close[i+33+1]
              +0.0340614696*Close[i+34+1]
              +0.0315922931*Close[i+35+1]
              +0.0289681736*Close[i+36+1]
              +0.0262218588*Close[i+37+1]
              +0.0233865835*Close[i+38+1]
              +0.0204976517*Close[i+39+1]
              +0.0175884606*Close[i+40+1]
              +0.0146922652*Close[i+41+1]
              +0.0118431116*Close[i+42+1]
              +0.0090702334*Close[i+43+1]
              +0.0064043271*Close[i+44+1]
              +0.0038713513*Close[i+45+1]
              +0.0014951741*Close[i+46+1]
              -0.0007031702*Close[i+47+1]
              -0.0027054278*Close[i+48+1]
              -0.0044979052*Close[i+49+1]
              -0.0060698985*Close[i+50+1]
              -0.0074151919*Close[i+51+1]
              -0.0085278517*Close[i+52+1]
              -0.0094111161*Close[i+53+1]
              -0.0100658241*Close[i+54+1]
              -0.0104994302*Close[i+55+1]
              -0.0107227904*Close[i+56+1]
              -0.0107450280*Close[i+57+1]
              -0.0105824763*Close[i+58+1]
              -0.0102517019*Close[i+59+1]
              -0.0097708805*Close[i+60+1]
              -0.0091581551*Close[i+61+1]
              -0.0084345004*Close[i+62+1]
              -0.0076214397*Close[i+63+1]
              -0.0067401718*Close[i+64+1]
              -0.0058083144*Close[i+65+1]
              -0.0048528295*Close[i+66+1]
              -0.0038816271*Close[i+67+1]
              -0.0029244713*Close[i+68+1]
              -0.0019911267*Close[i+69+1]
              -0.0010974211*Close[i+70+1]
              -0.0002535559*Close[i+71+1]
              +0.0005231953*Close[i+72+1]
              +0.0012297491*Close[i+73+1]
              +0.0018539149*Close[i+74+1]
              +0.0023994354*Close[i+75+1]
              +0.0028490136*Close[i+76+1]
              +0.0032221429*Close[i+77+1]
              +0.0034936183*Close[i+78+1]
              +0.0036818974*Close[i+79+1]
              +0.0038037944*Close[i+80+1]
              +0.0038338964*Close[i+81+1]
              +0.0037975350*Close[i+82+1]
              +0.0036986051*Close[i+83+1]
              +0.0035521320*Close[i+84+1]
              +0.0033559226*Close[i+85+1]
              +0.0031224409*Close[i+86+1]
              +0.0028550092*Close[i+87+1]
              +0.0025688349*Close[i+88+1]
              +0.0022682355*Close[i+89+1]
              +0.0073925495*Close[i+90+1];

      FTLM=(value11-value21);
      FTLM1=(value31-value41);
      STLM=(value12-value22);
      STLM1=(value32-value42);

      if(FTLM>FTLM1) {Up1[i]=FTLM;Down1[i]=EMPTY_VALUE;} else {Down1[i]=FTLM;Up1[i]=EMPTY_VALUE;}
      if(STLM>STLM1) {Up2[i]=STLM;Down2[i]=EMPTY_VALUE;} else {Down2[i]=STLM;Up2[i]=EMPTY_VALUE;}

      i--;
     }
   return(0);
  }
//+------------------------------------------------------------------+
