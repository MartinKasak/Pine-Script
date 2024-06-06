//@version=4
strategy(title="Bollinger Band Reversion",calc_on_every_tick=true,calc_on_order_fills=true, shorttitle = "BBR",default_qty_type = strategy.percent_of_equity,default_qty_value = 100, overlay=true, process_orders_on_close=true)
source = close
length = input(7, minval=1, title = "Period") 
mult = input(1.2, minval=0.001, maxval=50, title = "Standard Deviation", step=0.1) 

movingaverage =input(233, title="moving averaage")
mma233=ema(close, movingaverage)
plot(mma233, color=color.rgb(255, 251, 0))

basis = sma(source, length)
dev = mult * stdev(source, length)

upper = basis + dev
lower = basis - dev
middle = sma(close,length  )

testStartYear = input(2009, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(2, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)
testStopYear = input(2023, "Backtest Stop Year")
testStopMonth = input(12, "Backtest Stop Month")
testStopDay = input(30, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()

    if (close < lower )  and close >mma233
        strategy.entry("Long", strategy.long)

    if (close > middle)
        strategy.close("Long") 
        
p1 = plot(upper, color=color.blue,title= "UB")
p2 = plot(lower, color=color.blue,title= "LB" )
middle2 = plot(middle, color=color.blue,title= "rr")
fill(p1, p2, transp=100)
