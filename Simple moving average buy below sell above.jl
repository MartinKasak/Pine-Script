//@version=4
strategy(title="Simple Moving average buy below/sell", shorttitle="MA buy/sell",overlay=true,calc_on_every_tick = true, process_orders_on_close=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)
 
FastMa =input(8, title="Moving average Short")
MovingFast=sma(close, FastMa)
plot(MovingFast, color=color.rgb(255, 0, 0))

movingaverage =input(233, title="Moving Average Long")
mma233=ema(close, movingaverage)
plot(mma233, color=color.rgb(255, 251, 0))

testStartYear = input(2003, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(1, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)
testStopYear = input(2023, "Backtest Stop Year")
testStopMonth = input(12, "Backtest Stop Month")
testStopDay = input(12, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()
    if (close < MovingFast) and (close > mma233) 
        strategy.entry("BuyOS", strategy.long)
    if (close > MovingFast) and strategy.position_size>=1
        strategy.close("BuyOS")
