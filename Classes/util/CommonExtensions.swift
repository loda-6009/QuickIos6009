//
//  NumberExtension.swift
//  StudioBase
//
//  Created by hyonsoo han on 2018. 3. 2..
//  Copyright © 2018년 StudioMate. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGPoint {
    func distance(toPoint p:CGPoint) -> CGFloat {
        return sqrt(pow(x - p.x, 2) + pow(y - p.y, 2))
    }
}

public extension Int {
    func twoDigitString() -> String {
        if self <= -10 {
            return "-\(abs(self))"
        } else if self < 0 {
            return "-0\(abs(self))"
        } else if self < 10 {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
    func string() -> String {
        return "\(self)"
    }
}

public extension Float {
    func twoDigitString() -> String {
        let int = Int(self)
        return int.twoDigitString()
    }
}

public extension Double {
    /// 두자리 문자로
    func twoDigitString() -> String {
        let int = Int(self)
        return int.twoDigitString()
    }
}

public extension NSMutableData {
    func appendString(_ string: String) {
        append(string.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
    }
}

public extension Date {

    /// Local weekday 1~7
    func weekday(calendar: Calendar = TimeUtil.calendar) -> Int {
        return calendar.component(.weekday, from: self)
    }
    
    /// Local weekday index : 0~6
    func weekdayIndex(calendar: Calendar = TimeUtil.calendar) -> Int {
        return calendar.component(.weekday, from: self) - calendar.firstWeekday
    }
    
    /// Local weekday symbol
    func weekdayShortSymbol(calendar: Calendar = TimeUtil.calendar) -> String {
        return calendar.shortWeekdaySymbols[weekdayIndex(calendar: calendar)]
    }
    /// Local weekday symbol
    func weekdayFullSymbol(calendar: Calendar = TimeUtil.calendar) -> String {
        return calendar.weekdaySymbols[weekdayIndex(calendar: calendar)]
    }
    /// year, month, day
    func ymd(calendar: Calendar = TimeUtil.calendar) -> (Int, Int, Int) {
        let cal = calendar
        let comps = cal.dateComponents([.year, .month, .day], from: self)
        return (comps.year!, comps.month!, comps.day!)
    }
    /// hour, minute, second
    func hms(calendar: Calendar = TimeUtil.calendar) -> (Int, Int, Int) {
        let cal = calendar
        let comps = cal.dateComponents([.hour, .minute, .second], from: self)
        return (comps.hour!, comps.minute!, comps.second!)
    }
    
    func yyyyMMdd_HHmmss(_ join: String = "/") -> String {
        let form = DateFormatter()
        form.locale = TimeUtil.currentLocale
        form.dateFormat = "yyyy\(join)MM\(join)dd HH:mm:ss"
        return form.string(from: self)
    }

    /// 시분초를 0으로 변경
    func zero(calendar: Calendar = TimeUtil.calendar) -> Date {
        let cal = calendar
        let comps = cal.dateComponents([.year, .month, .day], from: self)
        return TimeUtil.date(
            from: "\(comps.year!)-\(comps.month!)-\(comps.day!) 00:00:00",
            format: "yyyy-MM-dd HH:mm:ss")!
    }
}
