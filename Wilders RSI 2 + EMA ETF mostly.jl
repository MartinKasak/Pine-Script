//@version=4
strategy(title="W-RSI+EMA/ETF mostly", shorttitle="Wilders2 + EMA", calc_on_every_tick = true , process_orders_on_close=true)

rsitwo =input(2, title="rsiwilder")
rsi=rsi(close, rsitwo)

plot(rsi, color=#FA0101)

movingaveragesell =input(8, title="moving averaage")
ema5=sma(close, movingaveragesell)


lowerrsi=input(10, title="RSI Lower Band")
middlersi=input(50, title="RSI Middle Band")
upperrsi=input(90, title="RSI Upper Band")

movingaverage =input(233, title="moving averaage")
mma200=ema(close, movingaverage)

testStartYear = input(1993, "Backtest Start Year")
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

fill(band1, band0, color = color.new(color.blue, transp =100))

close_Oversold = input(true, "Close at oversold levels")
close_Overbought = input(true, "Close at overbought levels")

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()

    if rsi<=lowerrsi and close > mma200 and  close_Oversold == true
        strategy.entry("BuyOS", strategy.long)
    if close_Oversold == true
        if close>=ema5 and strategy.position_size>=1
            strategy.close("BuyOS")
            
if testPeriod()           

    if rsi>=upperrsi and close < mma200 and  close_Overbought == true
        strategy.entry("SellOS", strategy.short)
    if close_Overbought == true
        if close<=ema5  and strategy.position_size<=1 
            strategy.close("SellOS")