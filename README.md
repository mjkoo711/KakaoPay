# Environment
개발에 사용된 **스펙 & API** 입니다
### Spec
 - macOS : **Mojave 10.14.6**
 - Xcode : **10.3**
 - Swift : **Swift 5**
 - Test Device : **iOS 12.4**
 
 => *디바이스(or Simulator)와 네트워크 상태에 따라 날씨를 불러오는 속도에 차이가 있을 수 있습니다.*

### Weather API 
 - using [**Dark Sky API**](https://darksky.net/dev/docs)

<br><br><br>

# Structure
Mode, Parser, Network에 대한 설명입니다. 

## Model
![alt text](https://drive.google.com/uc?id=1rKx-oVV7u1S3WJ5CrwziiOJfKu5Pk_aN)
- Weather 객체 안에 `latitude, longitude 프로퍼티`와 `CurrentlyWeather, HourlyWeather, DailyWeather 타입의 프로퍼티`로 구성되어 있습니다. 
- HourlyWeather, DailyWeather 객체 안에는 여러개의 **WeatherData**가 리스트로 존재합니다. 
- **Location** 객체는 latitude, longitude, regionName을 한번에 관리하기 위해 만든 모델입니다.

## Parser 
![alt text](https://drive.google.com/uc?id=1ahga7IboBWEcn4QdoM-e0JQVRwTpAA4Y)
- `parseWeatherData`는 `parseCurrentlyWeather`, `parseHourlyWeather`, `parseDailyWeather` 메서드에서 호출됩니다.
- `parseCurrentlyWeather`의 파라미터에는 요청 데이터인 response의 `response["currently"]` 값을 전달합니다. 
- `parseHourlyWeather`의 파라미터에는 요청 데이터인 response의 `response["hourly"]` 값을 전달합니다.
- `parseDailyWeather`의 파라미터에는 요청 데이터인 response의 `response["daily"]` 값을 전달합니다.

## Network
![alt text](https://drive.google.com/uc?id=1uB1vH8btPMvx0s3tvEqoGJW89jNmRI8-)
1. **WeatherVC**에서 WeatherRequest 객체를 생성하여 latitude, longitude와 함께 `WeatherRequest.request 메서드를 호출`합니다.
2. **WeatherRequest**에서는 latitude, longitude를 받아서 `path를 만든 뒤`, Request 객체를 생성하여 path와 params와 함께 `Request.get 메서드를 호출`합니다.
3. **Request**에서 `최종 URL을 만든 뒤`, `HTTPS GET 요청`을 합니다. 그리고 Success 시 돌아오는 `response를 WeatherRequest로 전달`합니다. 
4. **WeatherRequest**에서는 response를 Parser에 전달하여 `필요한 데이터만 파싱`하고, 그것들을 모두 모아 `Weather 객체를 생성`합니다. 
5. 생성된 Weather 객체를 `WeatherVC에 전달`하고, WeatherVC는 그것을 UI로 그려줍니다. 
<br><br><br>
# Episode
개발을 하면서 결정했야 했던 부분들에 대한 뒷 이야기입니다. 

## Current Location's Latitude & Longitude
현재 위치가 업데이트 될 때, 기존 위/경도와 `소수점 둘째자리까지 같으면` 요청을 하지 않게 구성하였습니다.
이유는 소수점 둘째자리까지가 약 `1km` 오차를 나타내는데 이 정도 오차는 현재 날씨가 동일할 것으로 판단했기 때문입니다.

```
decimal  degrees    distance
places
-------------------------------  
0        1.0        111 km
1        0.1        11.1 km
2        0.01       1.11 km
3        0.001      111 m
4        0.0001     11.1 m
5        0.00001    1.11 m
6        0.000001   0.111 m
7        0.0000001  1.11 cm
8        0.00000001 1.11 mm

```

## Data Needed
제가 앱을 구성하는데 필요로 했던 데이터는 아래 json 정도로 추렸습니다.
```json
{
	"latitude": 37.8267,
	"longitude": -122.4233,
	"timezone": "America/Los_Angeles",
	"currently": {
		"time": 1564581314,
		"icon": "partly-cloudy-day",
		"precipProbability": 0, (강수확률)
		"temperature": 13.73,
		"apparentTemperature": 13.73,
		"humidity": 0.89,
		"pressure": 1013.99,
		"windSpeed": 2.58,
		"windBearing": 228,
		"uvIndex": 0,
		"visibility": 16.093,
	},
	"hourly": {
		"summary": "Partly cloudy throughout the day.",
		"icon": "partly-cloudy-day",
		"data": [
			{
			"time": 1564578000,
			"icon": "partly-cloudy-night",
			"precipProbability": 0,
			"temperature": 13.6,
			"apparentTemperature": 13.6, (체감)
			"humidity": 0.88,
			"pressure": 1013.67,
			"windSpeed": 2.75,
			"windBearing": 231,
			"uvIndex": 0,
			"visibility": 16.093,
			} ...
		]
	},
	"daily": {
		"summary": "No precipitation throughout the week, with high temperatures rising to 20°C on Saturday.",
		"icon": "clear-day",
		"data": [
			{
			"time": 1564556400,
			"icon": "partly-cloudy-day",
			"sunriseTime": 1564578816,
			"sunsetTime": 1564629663,
			"precipProbability": 0.01,
			"precipType": "rain",
			"temperatureMin": 13.6,
			"temperatureMax": 18.67,
			} ...
		]
	}
}
```

## Refresh (with Cache)
화면을 아래로 끌어당기면 날씨 데이터를 새로고침 할 수 있습니다. 
처음에는 같은 위경도에 대해서 새로운 데이터를 계속 요청해서 업데이트 하는 것은 좋지 않다고 생각했습니다. 
그래서 클라이언트에서 Cache를 만들어 1시간 정도 캐시데이터를 유지하려 하였습니다. 
그러나, [DarkAPI](https://darksky.net/dev/docs#response-headers)에서 이미 요청한 데이터에 대해서는 **한시간 정도 캐쉬를 유지**하고 캐쉬값을 받아오고 있는 것을 아래와 같이 확인해서, 
클라이언트 측에서는 refresh를 요청하면 그냥 darkAPI를 호출하기로 `결정`했습니다.

``` 
<NSHTTPURLResponse: 0x283b379c0> { URL: https://api.darksky.net/forecast/ff027595edc16310fecd5629043d0552/13.3186546,108.3680998?units=si } { Status Code: 200, Headers {
    "Cache-Control" =     (
        "max-age=3600"
    );
    "Content-Encoding" =     (
        gzip
    );
    "Content-Type" =     (
        "application/json; charset=utf-8"
    );
    Date =     (
        "Sat, 03 Aug 2019 15:13:49 GMT"
    );
    Expires =     (
        "Sat, 03 Aug 2019 16:13:49 +0000"
    );
    Vary =     (
        "Accept-Encoding"
    );
    "x-authentication-time" =     (
        731ms
    );
    "x-forecast-api-calls" =     (
        35
    );
    "x-response-time" =     (
        "27.072ms"
    );
} }
```
