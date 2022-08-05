//
//  Extension-String.swift
//  VM Directory
//
//  Created by Arun R Mani on 03/08/2022.
//

import Foundation


extension String {
    func toString(dateFormat: String, returnFormat: String = "dd-MM-yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = returnFormat
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
