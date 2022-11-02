//
//  String+Category.swift
//  Bachelorarbeit
//
//

import Foundation
import UIKit

extension Encodable {
    func toJSONString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else{ return "" }
        guard let jsonStr = String(data: data, encoding: .utf8) else{ return "" }
        return jsonStr
    }
}

extension String {
     func jSONStringToData() -> Data? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        return data
    }
}

extension Date {
    
    /// time stamp : 10 digits
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }

    /// ms, 13 digits
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}


extension Notification.Name {
    static let refreshNavigationBar = Notification.Name("refreshNavigationBar")


}
