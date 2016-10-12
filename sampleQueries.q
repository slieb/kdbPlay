/ this loads the binary trades table into the runtime
trades: get `:data/trades

/ this gets a simple count of the # of records in the trade table
count trades

/ this selects the first 50 records from the trade table
select [50] from trades

/ this selects the last 50 records from the trade table
select [-50] from trades

/ this gets the count and average trade price by ticker
select cnt:count 1, avgPrice:avg tradePrice by ticker from trades

/ this gets the vwap by ticker
select tradeQty wavg tradePrice by ticker from trades