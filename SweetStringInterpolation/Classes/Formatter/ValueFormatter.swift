//
//  Formatter.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 2023/12/28.
//

import Foundation

public enum VF {
}


public protocol IntegerNumberFormatter {
    func format(integerValue: any BinaryInteger) -> String
}

public protocol FloatingNumberFormatter {
    func format(floatingValue: any BinaryFloatingPoint) -> String
}

public typealias BinaryNumberFormatter = IntegerNumberFormatter & FloatingNumberFormatter
// MARK: - FloatingNumberFormatters
extension VF {
    /// digtalPlace: 保留几位小数
    /// shouldRoundUp: 是否要四舍五入
    public static func precision(decimalPlace: Int, shouldRoundUp: Bool) -> any FloatingNumberFormatter {
        let numberFormatter: NumberFormatter = .init()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = decimalPlace
        numberFormatter.roundingMode = shouldRoundUp ? .halfUp : .floor
        return DefaultFloatingNumberFormatter(numberFormatter: numberFormatter)
    }
}


// MARK: - IntegerNumberFormatters
extension VF {
    public static func zeroPadding(width: Int) -> any IntegerNumberFormatter {
        return StringFormatNumberFormatter(strFormat: "%0\(width)d")
    }
}

// MARK: - BinaryNumberFormatters
extension VF {
    public static var playback: any BinaryNumberFormatter {
        return LevelSeperateFormatter(
            levels: [
                .init(value: 60, suffix: ""),
                .init(value: 60, suffix: ":"),
                .init(value: 24, suffix: ":")
            ], numberFormatter: VF.zeroPadding(width: 2))
    }
}
