//
//  Request.swift
//  KakaoPay
//
//  Created by MinJun KOO on 01/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class Request {
  var baseURLString = ""

  init(baseURLString: String) {
    self.baseURLString = baseURLString
  }

  func get(path: String, parameters: [String: Any], completion: @escaping ([String: Any]?, Error?) -> ()) {
    guard var components = URLComponents(string: baseURLString + path) else { return }
    components.queryItems = parameters.map({ (arg) -> (URLQueryItem) in
      let (key, value) = arg
      return URLQueryItem(name: key, value: "\(value)")
    })
    components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    guard let url = components.url else { return }
    var request = URLRequest(url: url)

    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data,
        let response = response as? HTTPURLResponse,
        (200 ..< 300) ~= response.statusCode,
        error == nil else {
          completion(nil, error)
          return
      }

      if let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] {
        completion(responseObject, nil)
      }
    }
    task.resume()
  }
}
