//@version=4
strategy(title="Double 7's Strategy",shorttitle="Double 7 (3)", overlay=true, default_qty_type = strategy.percent_of_equity, default_qty_value = 100, calc_on_every_tick=true, process_orders_on_close=true)

value1=input(7, title="Quantity of day low")
value2=input(7, title="Quantity of day high")
entry=lowest(close[1],value1)
exit=highest(close[1],value2)

entry2=lowest(close[0],value1)
exit2=highest(close[0],value2)

moving=input(233, title = "moving average")
mma200=ema(close,moving)

plot(entry2, title='fast', color=#aeaaaa, linewidth=1)
plot(exit2, title='fast', color=#aeaaaa, linewidth=1)
plot(mma200, title='moving_average', color=#e1e80a, linewidth=1)


// Test Period
testStartYear = input(2012, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(2, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)

testStopYear = input(2022, "Backtest Stop Year")
testStopMonth = input(12, "Backtest Stop Month")
testStopDay = input(30, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false

if testPeriod()
    if (close > mma200) and (close <= entry)
        strategy.entry("RsiLE", strategy.long , comment="Open") 
    if (close >= exit)
        strategy.close("RsiLE")
