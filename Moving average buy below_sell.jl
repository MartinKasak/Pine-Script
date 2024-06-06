//@version=4
strategy(title="Exponential Moving average buy below/sell", shorttitle="MA buy/sell",overlay=true, calc_on_every_tick = true, process_orders_on_close=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)
 
FastMa =input(9, title="Moving average")
MovingFast=ema(close, FastMa)
plot(MovingFast, color=color.rgb(81, 255, 0))

MiddleMa =input(65, title="Moving average")
MovingMiddle=ema(close, MiddleMa)
plot(MovingMiddle, color=color.rgb(255, 255, 255))

movingaverage =input(233, title="moving averaage")
mma233=ema(close, movingaverage)
plot(mma233, color=color.rgb(255, 251, 0))

testStartYear = input(2003, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(1, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)
testStopYear = input(2022, "Backtest Stop Year")
testStopMonth = input(1, "Backtest Stop Month")
testStopDay = input(1, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()
    if (close < MovingFast) and (close > mma233) and close > MovingMiddle
        strategy.entry("BuyOS", strategy.long)
    if (close > MovingFast) and strategy.position_size>=1
        strategy.close("BuyOS")
