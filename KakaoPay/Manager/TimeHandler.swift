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
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "MM.dd"
    return dateFormatter.string(from: date)
  }
  
  func convertTimeStampToHour(timeStamp: Int) -> String {
    let date = Date(timeIntervalSince1970: Double(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "a h시"
    dateFormatter.amSymbol = "오전"
    dateFormatter.pmSymbol = "오후"
    
    return dateFormatter.string(from: date)
  }
  
  func convertTimeStampToDateFormatter(timeStamp: Int) -> String {
    let date = Date(timeIntervalSince1970: Double(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:00"
    
    return dateFormatter.string(from: date)
  }
}
