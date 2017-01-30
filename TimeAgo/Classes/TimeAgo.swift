//
//  TimeAgo.swift
//  TimeAgo
//
//  Created by Naveed A. on 11/4/16.
//  Copyright © 2016 WhiteSpaceConflict. All rights reserved.
//

import UIKit

extension String {
    var localized: String {

        
        let bundle = Bundle(path: Bundle(for: type(of:self) as! AnyClass).path(forResource: "TimeAgo", ofType: "bundle")!)
        
//        let path = Bundle.main.path(forResource: "TimeAgo", ofType: "bundle")
//        let bundle = Bundle(path: path!)
        
        let res =  NSLocalizedString(self, tableName: "NSDateTimeAgo", bundle: bundle!, value: "", comment: "")
        return res
    }
}
extension Date {
    

    func generateDate(byValue:Int) -> Date {
        
        let calendar = Calendar.current
        
        let date = calendar.date(byAdding: .day, value: byValue, to: Date())
        
        return date!
    }
    
    
    func minutes(fromDays:Double) -> Double{
        
        return (24 * 60 * fromDays)
    }
    

    public func dateTimeAgo() -> String {
        
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month,.weekOfYear, .day,.hour,.minute,.second], from: self, to: now)
        
                
        var dateStr = ""
        
        if components.year! >= 1 {
         
            if components.year == 1 {
                dateStr = "Last year".localized
            }else{
                dateStr = String(format:"%d years ago".localized,components.year!)
            }
        }else if components.month! >= 1 {
            
            if components.month == 1 {

                dateStr = "1 month ago".localized
                
            }else{
                dateStr = String(format:"%d months ago".localized,components.month!)
            }
            
        }else if components.weekOfYear! >= 1  {
            
            if components.weekOfYear == 1 {
                dateStr = "Last week".localized
                
            }else{
                dateStr = String(format:"%d weeks ago".localized,components.weekOfYear!)
            }
        }else if components.day! >= 1{
            
            if components.day == 1 {
                dateStr = "Yesterday".localized
                
            }else{
                dateStr = String(format:"%d days ago".localized,components.day!)
            }
        }else if components.hour! >= 1{
            
            if components.hour == 1 {
                dateStr = "An hour ago".localized
                
            }else{
                dateStr = String(format:"%d hours ago".localized,components.hour!)
            }
            
        }else if components.minute! >= 1{
            
            if components.minute == 1 {
                dateStr = "A minute ago".localized
                
            }else{
                dateStr = String(format:"%d minutes ago".localized,components.minute!)
            }
            
        }else if components.second! < 5{
            
            dateStr = "Just now".localized
        }else{
            
            dateStr = String(format:"%d seconds ago".localized,components.second!)

        }

        
        return dateStr
        
    }
    func timeAgo() -> String {
        
        let date = Date()
        let deltaSeconds = fabs(self.timeIntervalSince(date))
        let deltaMinutes = deltaSeconds / 60.0
        
        
        
        
        // time ago..
        var dateStr = ""
        switch deltaSeconds {
        case let sec where sec < 5:
            dateStr = "Just now".localized
        case let sec where sec < 60:
            dateStr = String(format:"%d seconds ago".localized,deltaSeconds)
        case let sec where sec < 120:
            dateStr = "A minute ago".localized
        default:
            print("default")
        }
        
        
        
        var totalTime = 0
        
        switch deltaMinutes {
            
        case let value where value < 60:
            dateStr = String(format:"%d minutes ago".localized,deltaMinutes)
            
        case let value where value < 120:
            dateStr = "An hour ago".localized
            
        case let value where value < minutes(fromDays:1):
            totalTime = Int(floor(deltaMinutes/60))
            dateStr = String(format:"%d hours ago".localized,totalTime)
            
        case let value where value < minutes(fromDays:2):
            dateStr = "Yesterday".localized
            
        case let value where value < minutes(fromDays:7):
            totalTime = Int(floor(deltaMinutes/minutes(fromDays:1)))
            dateStr = String(format:"%d days ago".localized,totalTime)
            
        case let value where value < minutes(fromDays:14):
            dateStr = "Last week".localized
            
        case let value where value < minutes(fromDays:31):
            totalTime = Int(floor(deltaMinutes/minutes(fromDays:7)))
            dateStr = String(format:"%d weeks ago".localized,totalTime)
            
        case let value where value < minutes(fromDays:61):
            dateStr = "Last month".localized
            
        case let value where value < minutes(fromDays:365.25):
            totalTime = Int(floor(deltaMinutes/minutes(fromDays:30)))
            dateStr = String(format:"%d months ago".localized,totalTime)
            
        case let value where value < minutes(fromDays:731):
            dateStr = "Last year".localized
            
        default:
            totalTime = Int(floor(deltaMinutes/minutes(fromDays:365)))
            dateStr = String(format:"%d years ago".localized,totalTime)
            
        }

        return dateStr
    }
}
