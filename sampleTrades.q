/ Create a trades table
trades:([]
    tradeDate:`date$();
    tradeTime:`time$();
    ticker:`symbol$();
    tradePrice:`float$();
    tradeQty:`int$())

/ 15 tickers -- using more starts stressing local swap space
tickers : `IBM`MSFT`AAPL`MS`GS`BAC`GOOG`AMZN`CSCO`AMBA`NFLX`HACK`FB`YHOO`INTC

/ start the timeseries on Monday, October 3
startDate : 2016.10.03
countTickers : count tickers
tradesPerSecond : 8
secondsPerDay : `int$6.5 * 60 * 60        / need to cast the result (23,400) to an integer
tradesPerDay : tradesPerSecond * secondsPerDay
tradingDays : 3
numberOfTrades : countTickers * tradesPerDay * tradingDays

/ create list of tradeDates
tradeDate:startDate+numberOfTrades?tradingDays

/ create time arrays in 125 millisecond intervals (8 trades per second) per symbol per day
/ using enlist and raze with type TIME to create final column of timestamps
tradeTime:"t"$raze (countTickers * tradingDays) #enlist 09:30:00:00+125 * til tradesPerDay
/ randomize milliseconds
tradeTime+:numberOfTrades?124

ticker:numberOfTrades?tickers

/ consider anchoring each tradePrice / symbol combo to make more accurate, up & down within band
tradePrice:numberOfTrades?100f

/ randomize tradeQty (by lotsize of 100) between 100 and 10,000
tradeQty:100 + 100 * numberOfTrades ? 100

/ insert into trades table
`trades insert (tradeDate;tradeTime;ticker;tradePrice;tradeQty)

/ sort by date, time
trades:`tradeDate`tradeTime xasc trades

/ save to binary and csv formats into data subdirectory
save `:data/trades
save `:data/trades.csv
