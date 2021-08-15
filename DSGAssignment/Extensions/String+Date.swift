//
//  String+Date.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import Foundation

extension String {
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ServerUTCFormat
        if let date = dateFormatter.date(from: self) {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = DisplayFormat
            return dateFormatter1.string(from: date)
        }
        else {
            return self
        }
    }
}
