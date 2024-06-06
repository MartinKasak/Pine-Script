//@version=4
strategy(title="RSI", shorttitle="Simple RSI 25 & 55", calc_on_every_tick = true, process_orders_on_close=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)

src = close, len = input(3, minval=1, title="Length")
up = rma(max(change(src), 0), len)
down = rma(-min(change(src), 0), len)
rsi = down == 0 ? 100 : up == 0 ? 0 : 100 - (100 / (1 + up / down))
plot(rsi, color=color.rgb(255, 5, 5))

lowerrsi=input(35, title="RSI Lower Band")
middlersi=input(60, title="RSI Middle Band")
movingaverage =input(233, title="moving averaage")
mma233=ema(close, movingaverage)

testStartYear = input(2005, "Backtest Start Year")
testStartMonth = input(1, "Backtest Start Month")
testStartDay = input(1, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear,testStartMonth,testStartDay,0,0)
testStopYear = input(2023, "Backtest Stop Year")
testStopMonth = input(12, "Backtest Stop Month")
testStopDay = input(31, "Backtest Stop Day")
testPeriodStop = timestamp(testStopYear,testStopMonth,testStopDay,0,0)

band2 = hline(middlersi)
band0 = hline(lowerrsi)

fill(band2, band0, transp=100)

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false

if testPeriod()
    if rsi<=lowerrsi  and close > mma233
        strategy.entry("BuyOS", strategy.long)
    if (rsi > middlersi)  and strategy.position_size>=1
        strategy.close("BuyOS")
            
