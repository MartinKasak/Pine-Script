//@version=4

strategy("FiverrWilliams%", calc_on_every_tick = true, process_orders_on_close=true, default_qty_type=strategy.percent_of_equity, default_qty_value=100)
length = input(title="Length", defval=22)
wpr = wpr(length)


williams_lower = input(title="Lower williams", type=input.integer, defval=-95)
williams_upper = input(title="Upper williams", type=input.integer, defval=-50)

obPlot2=hline(williams_upper, title="Middle Level", linestyle=hline.style_dotted)
obPlot3=hline(williams_lower, title="Middle Level", linestyle=hline.style_dotted)

//fill(obPlot, osPlot , color.rgb(0, 0, 0, 0))
//fill(obPlot, osPlot , color.rgb(0, 0, 0, 0))
plot(wpr, title="%R", color=#7E57C2)

//plot(williams_lower, title="lower", color=#e4e4e6)
//plot(williams_upper, title="middle", color=#e4e4e6)

testStartYear = input(2005, "Backtest Start Year")
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
    if (strategy.position_size >= 0 and wpr < williams_lower )  
        strategy.entry("buy", strategy.long)
    if wpr > williams_upper
        strategy.close("buy")



