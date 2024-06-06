//@version=5
strategy(title="Larry Connor RSI", shorttitle="Minu connor RSI", calc_on_every_tick = true, process_orders_on_close=true)

//CRSI
src = close
lenrsi = input(3, "RSI Length")
lenupdown = input(2, "UpDown Length")
lenroc = input(100, "ROC Length")
updown(s) =>
	isEqual = s == s[1]
	isGrowing = s > s[1]
	ud = 0.0
	ud := isEqual ? 0 : isGrowing ? (nz(ud[1]) <= 0 ? 1 : nz(ud[1])+1) : (nz(ud[1]) >= 0 ? -1 : nz(ud[1])-1)
	ud
rsi = ta.rsi(src, lenrsi)
updownrsi = ta.rsi(updown(src), lenupdown)
percentrank = ta.percentrank(ta.roc(src, 1), lenroc)
crsi = math.avg(rsi, updownrsi, percentrank)

plot(crsi)

lowerrsi=input(25, title="RSI Lower Band")
middlersi=input(55, title="RSI Middle Band")
upperrsi=input(90, title="RSI Upper Band")

movingaverage =input(233, title="moving averaage")
mma200=ta.ema(close, movingaverage)
moving8 = input(8,  title="moving averaage" )
ema8 = ta.ema(close,moving8)

testStartYear = input(2002, "Backtest Start Year")
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

fill(band1, band0, transp=100)
close_Oversold = input(true, "Close at oversold levels")
close_Overbought = input(true, "Close at overbought levels")

testPeriod() =>
    time >= testPeriodStart and time <= testPeriodStop ? true : false
    
if testPeriod()

    if crsi<=lowerrsi and close > mma200 and  close_Oversold == true
        strategy.entry("BuyOS", strategy.long)
    if close_Oversold == true 
        if (close > ema8)  and strategy.position_size>=1
            strategy.close("BuyOS")
            
if testPeriod()           

    if crsi>=upperrsi and close < mma200 and  close_Overbought == true
        strategy.entry("SellOS", strategy.short)
    if close_Overbought == true
        if strategy.position_size<=1 
            strategy.close("SellOS")

