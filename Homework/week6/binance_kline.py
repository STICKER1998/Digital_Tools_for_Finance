import requests

def binance_kline(currency, startTime):
    url = 'https://api.binance.com/api/v3/klines?symbol='+currency+'&interval=1d&startTime='+startTime+'&limit=75'
    return requests.get(url).json()
    
print(binance_kline('BTCUSDT', '1661990400000'))




