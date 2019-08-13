//
//  WeatherStateHandler.swift
//  MJWeather
//
//  Created by 구민준 on 03/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class WeatherStateHandler {
  func changeWindBearingToDirection(windBearing: Int) -> String {
    var direction: String = ""
    
    if windBearing == 0 {
      direction = "바람없음"
    } else if windBearing > 0 && windBearing < 45 {
      direction = "북북동"
    } else if windBearing == 45 {
      direction = "북동"
    } else if windBearing > 45 && windBearing < 90 {
      direction = "동북동"
    } else if windBearing == 90 {
      direction = "동"
    } else if windBearing > 90 && windBearing < 135 {
      direction = "동남동"
    } else if windBearing == 135 {
      direction = "동남"
    } else if windBearing > 135 && windBearing < 180 {
      direction = "남남동"
    } else if windBearing == 180 {
      direction = "남"
    } else if windBearing > 180 && windBearing < 225 {
      direction = "남남서"
    } else if windBearing == 225 {
      direction = "남서"
    } else if windBearing > 225 && windBearing < 270 {
      direction = "서남서"
    } else if windBearing == 270 {
      direction = "서"
    } else if windBearing > 270 && windBearing < 315 {
      direction = "서북서"
    } else if windBearing == 315 {
      direction = "북서"
    } else if windBearing > 315 && windBearing < 360 {
      direction = "북북서"
    } else if windBearing == 360 {
      direction = "북"
    }
    
    return direction
  }
  
  func changeToString(icon: String) -> String {
    var stateString = ""
    
    switch icon {
    case "clear-day":
      stateString = "쨍 하고 해뜰 날 돌아왔단다☀️"
      break
    case "sleet":
      stateString = "진눈깨비 드륵드륵🥶"
      break
    case "fog":
      stateString = "안개 스믈스믈🌫"
      break
    case "partly-cloudy-night":
      stateString = "구름낀 밤이에요😎"
      break
    case "snow":
      stateString = "엘사 내한했나봐 눈온다🌨"
      break
    case "wind":
      stateString = "바람 바람 바람🌬"
      break
    case "clear-night":
      stateString = "깨끗한 저녁하늘이에요🌕"
      break
    case "cloudy":
      stateString = "구름 구름 구름☁️"
      break
    case "partly-cloudy-day":
      stateString = "구름 낀 하루⛅️"
      break
    case "rain":
      stateString = "밖에 비온다 주룩주룩☔️"
      break
    default:
      stateString = "날씨 정보를 안주네,,,😅"
      break
    }
    
    return stateString
  }
}
