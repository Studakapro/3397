<chart>
id=132305816628767984
symbol=AUDUSD
period=60
leftpos=2151
digits=5
scale=2
graph=0
fore=0
grid=1
volume=0
scroll=0
shift=1
ohlc=1
one_click=0
one_click_btn=1
askline=0
days=0
descriptions=0
shift_size=20
fixed_pos=0
window_left=0
window_top=450
window_right=337
window_bottom=600
window_type=3
background_color=0
foreground_color=16777215
barup_color=0
bardown_color=0
bullcandle_color=0
bearcandle_color=0
chartline_color=65280
volumes_color=3329330
grid_color=2433309
askline_color=255
stops_color=255

<window>
height=159
fixed_height=0
<indicator>
name=main
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=rsi chart bars
flags=275
window_num=0
<inputs>
RSI_Period=101
RSI_Price=0
Overbought=50
Oversold=50
BarWidth=1
CandleWidth=3
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=16711680
style_0=0
weight_0=1
shift_1=0
draw_1=2
color_1=255
style_1=0
weight_1=1
shift_2=0
draw_2=2
color_2=16711680
style_2=0
weight_2=3
shift_3=0
draw_3=2
color_3=255
style_3=0
weight_3=3
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=PBF_2EMA_Color
flags=275
window_num=0
<inputs>
MA1_Period=159
MA2_Period=220
</inputs>
</expert>
shift_0=0
draw_0=3
color_0=65280
style_0=0
weight_0=0
arrow_0=167
shift_1=0
draw_1=3
color_1=32768
style_1=0
weight_1=0
arrow_1=167
shift_2=0
draw_2=3
color_2=255
style_2=0
weight_2=0
arrow_2=167
shift_3=0
draw_3=3
color_3=2763429
style_3=0
weight_3=0
arrow_3=167
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=75
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=vertex_mod_3.01 alerts + arrows
flags=275
window_num=2
<inputs>
Processed=2000
Control_Period=88
Signal_Period=15
Signal_Method=0
BB_Up_Period=12
BB_Up_Deviation=2
BB_Dn_Period=12
BB_Dn_Deviation=2
levelOb=6.0
levelOs=-6.0
extremelevelOb=10.0
extremelevelOs=-10.0
alertsOn=false
alertsOnObOs=false
alertsOnExtremeObOs=false
alertsOnCurrent=false
alertsMessage=false
alertsSound=false
alertsEmail=false
alertsNotify=false
soundfile=alert2.wav
arrowsVisible=true
arrowsIdentifier=vertex arrows1
arrowsUpperGap=1.0
arrowsLowerGap=1.0
arrowsOnObOs=false
arrowsObOsUpColor=3329330
arrowsObOsDnColor=255
arrowsObOsUpCode=241
arrowsObOsDnCode=242
arrowsObOsUpSize=1
arrowsObOsDnSize=1
arrowsOnExtremeObOs=false
arrowsExtremeObOsUpColor=16760576
arrowsExtremeObOsDnColor=9662683
arrowsExtremeObOsUpCode=159
arrowsExtremeObOsDnCode=159
arrowsExtremeObOsUpSize=5
arrowsExtremeObOsDnSize=5
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=255
style_0=0
weight_0=0
shift_1=0
draw_1=0
color_1=16711680
style_1=0
weight_1=0
shift_2=0
draw_2=0
color_2=8421504
style_2=0
weight_2=0
shift_3=0
draw_3=0
color_3=8421504
style_3=0
weight_3=0
levels_color=13850042
levels_style=2
levels_weight=1
level_0=6.00000000
level_1=-6.00000000
level_2=10.00000000
level_3=-10.00000000
level_4=58.00000000
period_flags=0
show_data=1
</indicator>
</window>
</chart>

