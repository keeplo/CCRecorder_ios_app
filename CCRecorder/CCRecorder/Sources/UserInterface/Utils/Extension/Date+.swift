//
//  Date+.swift
//  CCRecorder
//
//  Created by 김용우 on 9/10/24.
//

import Foundation.NSDate

extension Date {
        
    var rowDescription: String {
        let formatter: DateFormatter = .init()
        formatter.dateFormat = "YY.MM.dd HH:mm"
        return formatter.string(from: self)
    }
    
}
