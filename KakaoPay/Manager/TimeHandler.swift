//
//  TimeHandler.swift
//  KakaoPay
//
//  Created by 구민준 on 03/08/2019.
//  Copyright © 2019 mjkoo. All rights reserved.
//

import Foundation

class TimeHandler {
  func convertTimeStampToMonthDay(timeStamp: Int) -> String {
    let date = Date(timeIntervalSince1970: Double(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "MM.dd"
    return dateFormatter.string(from: date)
  }
}
