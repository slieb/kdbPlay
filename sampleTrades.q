/ Create a trades table
trades:([]
    tradeDate:`date$();
    tradeTime:`time$();
    ticker:`symbol$();
    tradePrice:`float$();
    tradeQty:`int$())

/ tickers -- using more starts stressing local swap space
tickers : `IBM`MSFT`AAPL`MS`GS`BAC`GOOG`AMZN`CSCO`AMBA`NFLX`HACK`FB`YHOO`INTC`T`B`JPM`HYT`VHT`PFE`IYF`IYW`CHL`FAX

/ some settings you can play with to change the resulting table
startDate : 2016.10.03
tradesPerSecond : 10
tradingDays : 5

/ set up vectors for ultimate store
countTickers : count tickers
/ if/else logic in q to get to a trade-per-second interval for tradeTimes
$[(1000 mod tradesPerSecond)=0;tradeInterval:`int$1000%tradesPerSecond;tradeInterval:(`int$1000%tradesPerSecond)-1]
secondsPerDay : `int$6.5 * 60 * 60              / need to cast result to integer
tradesPerDay : tradesPerSecond * secondsPerDay
numberOfTrades : countTickers * tradesPerDay * tradingDays

/ create list of tradeDates
tradeDate:startDate+numberOfTrades?tradingDays

/ create time arrays in intervals per symbol per day
/ using enlist and raze with type TIME to create final column of timestamps
tradeTime:"t"$raze (countTickers * tradingDays) #enlist 09:30:00:00 + tradeInterval * til tradesPerDay

/ randomize milliseconds
tradeTime+:numberOfTrades?(tradeInterval-1)

ticker:numberOfTrades?tickers

/ consider anchoring each tradePrice / symbol combo to make more accurate, up & down within band
tradePrice:numberOfTrades?100f

/ randomize tradeQty (by lotsize of 100) between 100 and 10,000
tradeQty:100 + 100 * numberOfTrades ? 100

/ insert into trades table
`trades insert (tradeDate;tradeTime;ticker;tradePrice;tradeQty)

/ sort by date, time
trades:`tradeDate`tradeTime xasc trades

/ save to binary format into data subdirectory
save `:data/trades

/ save to csv file (which takes more memory)
/ save `:data/trades.csv
