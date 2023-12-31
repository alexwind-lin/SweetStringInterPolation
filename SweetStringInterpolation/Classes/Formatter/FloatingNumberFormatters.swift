//
//  FloatingNumberFormatters.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 2023/12/28.
//

import Foundation

public class DefaultFloatingNumberFormatter: FloatingNumberFormatter {
    let numberFormatter: NumberFormatter
    public init(numberFormatter: NumberFormatter) {
        self.numberFormatter = numberFormatter
    }
    
    public func format(floatingValue: any BinaryFloatingPoint) -> String {
        let number = Double(floatingValue)
        guard let str = numberFormatter.string(from: number as NSNumber) else {
            #if DEBUG
            fatalError("格式化失败")
            #else
            return "\(floatingValue)"
            #endif
        }
        return str
    }
}
