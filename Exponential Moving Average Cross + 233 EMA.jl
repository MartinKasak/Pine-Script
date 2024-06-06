//@version=4
strategy(title="Fiverr Exponential Moving average cross+233EMA", shorttitle="MA cross+233EMA", calc_on_every_tick = true,overlay=true, process_orders_on_close=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)

movingaverage1 =input(9, title="fast moving average")
mma2002=ema(close, movingaverage1)
movingaverage2 =input(4, title="slow moving average")
mma2003=ema(close, movingaverage2)
movingaverage3 =input(233, title="slow moving average")
mma2004=ema(close, movingaverage3)
plot(mma2002, title='fast', color=#06BD1C, linewidth=1)
plot(mma2003, title='slow', color=#0B60C6, linewidth=1)
plot(mma2004, title='very slow', color=#ffff00, linewidth=1)

testStartYear = input(2003, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(2, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)
testStopYear = input(2023, "Backtest Stop Year")
testStopMonth = input(12, "Backtest Stop Month")
testStopDay = input(31, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()
    strategy.entry("BuyOS", true, when = crossover(mma2002, mma2003) )
    strategy.close("BuyOS", when = crossunder(mma2002, mma2003))
      