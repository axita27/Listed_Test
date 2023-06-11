//
//  Date + Extension.swift
//  Listed
//
//  Created by Axita Dholariya on 09/06/23.
//

import Foundation

extension Date{
    
    //MARK: - Get Greeting using hour
    func greetingLogic() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        
        let NEW_DAY = 0
        let NOON = 12
        let SUNSET = 18
        let MIDNIGHT = 24
        
        var greetingText = "Hello" // Default greeting text
        switch hour {
        case NEW_DAY..<NOON:
            greetingText = "Good Morning"
        case NOON..<SUNSET:
            greetingText = "Good Afternoon"
        case SUNSET..<MIDNIGHT:
            greetingText = "Good Evening"
        default:
            _ = "Hello"
        }
        
        return greetingText
    }
    
    static func getISTFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "IST")
        dateFormatter.locale = Locale.init(identifier: "en_IN")
        return dateFormatter
    }
    
    static func dateFromZoneFormatString(dateString: String) -> Date? {
        let dateFormatter = getISTFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: dateString)
    }
    
    func dateStringFromDate(toFormat:String) -> String {
        let dateFormatter = Date.getISTFormatter()
        dateFormatter.dateFormat = toFormat
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
