//
//  FormatterInterpolation.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 2023/12/28.
//

import Foundation

extension DefaultStringInterpolation {
    mutating
    public func appendInterpolation<T: BinaryInteger>(value: T, formatter: any IntegerNumberFormatter) {
        appendInterpolation(formatter.format(integerValue: value))
    }
    
    mutating
    public func appendInterpolation<T: BinaryFloatingPoint>(value: T, formatter: any FloatingNumberFormatter) {
        appendInterpolation(formatter.format(floatingValue: value))
    }
}
