//
//  WeatherRequest.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class WeatherRequest {
  func loadWeather(latitude: Double, longitude: Double, onSuccess: @escaping (Weather) -> (), onFailure: @escaping (Error?) -> ()) {
    let request = Request(baseURLString: Const.baseURL)
    let path = "/forecast/" + Key.DARK_API + "/" + "\(latitude),\(longitude)"
    let params = ["units": "si"]
    
    request.get(path: path, parameters: params) { (response, error) in
      
    }
  }
}
