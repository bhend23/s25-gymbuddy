//
//  MonthStruct.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/16/25.
//

import Foundation

struct MonthStruct {
    var monthType: MonthType
    var dayInt: Int
    func day() -> String {
        return String(dayInt)
    }
}

enum MonthType {
    case Previous
    case Current
    case Next
}
