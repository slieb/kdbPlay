/ kdbPlay.q

/ Create a deck of cards, deal a poker hand, and show it
fullDeck : `Two`Three`Four`Five`Six`Seven`Eight`Nine`Ten`Jack`Queen`King`Ace cross `Clubs`Hearts`Diamonds`Spades
pokerDeal : -7?fullDeck
pokerDeal

/ Create a trades table
trades:([]
    tradeDate:`date$();
    tradeTime:`time$();
    ticker:`symbol$();
    tradePrice:`float$();
    tradeQty:`int$())

tickers : `IBM`MSFT`AAPL`MS`GS`BAC`GOOG`AMZN`CSCO`AMBA`NFLX`HACK`PFE
startDate : 2016.10.03
countTickers : count tickers
tradesPerSecond : 4
secondsPerDay : `int$6.5 * 60 * 60        / need to cast the result to an integer
tradesPerDay : tradesPerSecond * secondsPerDay
tradingDays : 5
numberOfTrades : countTickers * tradesPerDay * tradingDays

tradeDate:startDate+numberOfTrades?5

/ fix tradeTime array - 4 trades per second, but stop at 16:00:00
tradeTime:"t"$raze (countTickers*tradingDays)#enlist 09:30:00+15*til tradesPerDay
tradeTime+:numberOfTrades?1000

ticker:numberOfTrades?tickers

/ consider anchoring each tradePrice / symbol combo to make more accurate, up & down within band
tradePrice:numberOfTrades?100f

/ fix tradeQty and make more rational
tradeQty:100*numberOfTrades?1000

`trades insert (tradeDate;tradeTime;ticker;tradePrice;tradeQty)

trades:`tradeDate`tradeTime xasc trades

/save `:data/trades.csv
/save `:data/trades
