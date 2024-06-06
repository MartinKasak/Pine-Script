//@version=4
strategy(title="Simple Relative Strength Index", shorttitle="SRSI5 + WRSI2", calc_on_every_tick = true,   calc_on_order_fills = true, process_orders_on_close=true)

src = close, len = input(5, minval=1, title="Length")
up = sma(max(change(src), 0), len)
down = sma(-min(change(src), 0), len)
rsi = down == 0 ? 100 : up == 0 ? 0 : 100 - (100 / (1 + up / down))
plot(rsi, color=color.rgb(219, 11, 0))

rsitwo =input(2, title="Wilders RSI")
rsisecond=rsi(close, rsitwo)
plot(rsisecond, color=color.rgb(220, 150, 0))

movingaveragesell =input(8, title="moving average")
ema5=ema(close, movingaveragesell)

lowerrsi=input(10, title="RSI Lower Band")
middlersi=input(50, title="RSI Middle Band")
upperrsi=input(90, title="RSI Upper Band")

movingaverage =input(233, title="moving averaage")
mma200=ema(close, movingaverage)

testStartYear = input(2010, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(2, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)
testStopYear = input(2022, "Backtest Stop Year")
testStopMonth = input(12, "Backtest Stop Month")
testStopDay = input(30, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

band1 = hline(upperrsi)
band2 = hline(middlersi)
band0 = hline(lowerrsi)
 
close_Overbought = input(true, "Close at overbought levels")
close_Oversold = input(true, "Close at oversold levels")

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()
    if (rsi<=lowerrsi) and (close > mma200) and (rsisecond<=lowerrsi) and  close_Overbought == true
        strategy.entry("BuyOS", strategy.long)
    if close_Overbought == true
        if close>=ema5 and strategy.position_size>=1
            strategy.close("BuyOS")
if testPeriod()                 
    if (rsi>=upperrsi) and (close < mma200) and (rsisecond>=upperrsi) and  close_Oversold == true
        strategy.entry("SellOS", strategy.short)
    if close_Oversold == true
        if (close<=ema5 or close > mma200)  and strategy.position_size<=1 
            strategy.close("SellOS")