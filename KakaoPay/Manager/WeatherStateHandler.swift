//
//  WeatherStateHandler.swift
//  KakaoPay
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
      stateString = "아주 좋은 낮이야~"
      break
    case "sleet":
      stateString = "진눈꺠비가 날릴거야~"
      break
    case "fog":
      stateString = "안개가 많이 꼈어~"
      break
    case "partly-cloudy-night":
      stateString = "구름이 조금 껴도 밤이라 괜찮아~"
      break
    case "snow":
      stateString = "눈이 펑펑 옵니다~"
      break
    case "wind":
      stateString = "바람이 불어오는 데~"
      break
    case "clear-night":
      stateString = "아주 좋은 밤이야~"
      break
    case "cloudy":
      stateString = "구름이 많이 꼈어~"
      break
    case "partly-cloudy-day":
      stateString = "구름이 껴서 햇빛은 피할거야~"
      break
    case "rain":
      stateString = "밖에 비온다 주룩주룩~"
      break
    default:
      stateString = "날씨 정보를 안주네,,,"
      break
    }
    
    return stateString
  }
}
