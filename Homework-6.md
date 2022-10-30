# Exercise 6
## Problem
The first part is about the [Binance API](https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md):

- What is the root URL?
- What is the endpoint to retrieve klines (open-high-low-close data) for a specific cryptocurrency?
- Specify a request string to retrieve 75 observations of klines data for BTCUSDT since 2022-09-01.
- Write a function (in Python, R or Julia) that retrieves 75 observations of klines data for a generic currency pair since a generic date. The function should take the currency pair and start date as input parameters.

The rest is about the [FRED API](https://fred.stlouisfed.org/docs/api):

- Read how authentication with API keys works. Create an account and obtain your own key.
- What is the root URL?
- What is the endpoint to retrieve time series observations?
- Construct a query string to retrieve the series of the monthly unemployment rate (seasonally adjusted) since 2020-01. Use the fake API key `abc123` in the query string.

## Solution
The first part is about the Binance API:

1. What is the root URL? https://api.binance.com/

2. What is the endpoint to retrieve klines (open-high-low-close data) for a specific cryptocurrency?  `GET/api/v3/klines`

3. Specify a request string to retrieve 75 observations of klines data for BTCUSDT since 2022-09-01.
  
    `https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d&startTime=1661990400000&limit=75`

4. Write a function (in Python, R or Julia) that retrieves 75 observations of klines data for a generic currency pair since a generic date. The function should take the currency pair and start date as input parameters. `binance_kline.py` which is in `Homework/week6/`.

The rest is about the FRED API:
1. What is the root URL?  https://api.stlouisfed.org/

2. What is the endpoint to retrieve time series observations? `GET/fred/series/observations`

3. Construct a query string to retrieve the series of the monthly unemployment rate (seasonally adjusted) since 2020-01. Use the fake API key abc123 in the query string.

   `https://api.stlouisfed.org/fred/series/observations?series_id=UNRATE&frequency=m&realtime_start=2020-01-01&api_key=abc123`


