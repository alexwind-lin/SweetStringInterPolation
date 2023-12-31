//
//  BinaryNumberFormatters.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 2023/12/29.
//

import Foundation

/**
 *  LevelSeperateFormatter用来进行进制分割的格式化使用
 *  例如：如果想将秒数分割成00:00:00的格式，可以定义这样的formatter:
 *  var secondFormatter: LevelSeperateFormatter = .init(
    levels: [
     .init(value: 60, suffix: ""),
     .init(value: 60, suffix: ":"),
     .init(value: 24, suffix: ":"),
     ],
     numberFormatter: VF.zeroPadding(width: 2)
    )
 *
 */
public class LevelSeperateFormatter: IntegerNumberFormatter, FloatingNumberFormatter {
    private let levels: [IntLevel]
    private let customNumberFormatter: (_ number: Int, _ level: IntLevel) -> String
    
    public struct Config {
        /// 如果高位的数字为0的话，是否跳过
        let skipZeroHighLevel: Bool
        /// 如果最高位超过最高位的进制，显示取模的结果，还是显示完整的数字
        let useModValueOnHighestLevel: Bool
        
        public init(skipZeroHighLevel: Bool = false, useModValueOnHighestLevel: Bool = true) {
            self.skipZeroHighLevel = skipZeroHighLevel
            self.useModValueOnHighestLevel = useModValueOnHighestLevel
        }
    }
    private let config: Config
    /// levels: 单位进制列表，从小到大
    public init(levels: [IntLevel],
                customNumberFormatter: @escaping (_ number: Int, _ level: IntLevel) -> String,
                config: Config) {
        self.levels = levels
        self.customNumberFormatter = customNumberFormatter
        self.config = config
    }
    
    /// levels: 单位进制列表，从小到大
    public convenience init(levels: [IntLevel],
                            numberFormatter: (any IntegerNumberFormatter)? = nil,
                            config: Config = .init()) {
        var formatter: (_ number: Int, _ level: IntLevel) -> String = { number, level in
            return "\(number)"
        }
        
        if let numberFormatter = numberFormatter {
            formatter = { number, level in
                return numberFormatter.format(integerValue: number)
            }
        }
        self.init(levels: levels, customNumberFormatter: formatter, config: config)
    }
    
    public func format(integerValue: any BinaryInteger) -> String {
        return format(time: Int(integerValue))
    }
    
    public func format(floatingValue: any BinaryFloatingPoint) -> String {
        return format(integerValue: Int(floatingValue))
    }
    
    private func format(time: Int) -> String {
        var result: String = ""
        var number = time
        for i in levels.indices {
            let level = levels[i]
            
            guard level.value != 0 else {
                #if DEBUG
                fatalError("进度单位不能为0")
                #else
                return "\(time)"
                #endif
            }
            
            var levelResult = ""
            var numberString = ""
            let shouldDivide = (i < levels.count - 1) || config.useModValueOnHighestLevel
            if number >= level.value, shouldDivide {
                let divmod = ldiv(number, level.value)
                numberString = customNumberFormatter(divmod.rem, level)
                number = divmod.quot
            } else {
                numberString = customNumberFormatter(number, level)
                number = 0
            }
            levelResult = level.format(numberString: numberString)
            result = levelResult + result
            
            if number == 0, config.skipZeroHighLevel {
                break
            }
        }
        return result
    }
}


public class StringFormatNumberFormatter: IntegerNumberFormatter, FloatingNumberFormatter {
    let strFormat: String
    init(strFormat: String) {
        self.strFormat = strFormat
    }
    
    public func format(integerValue: any BinaryInteger) -> String {
        return String.init(format: strFormat, Int(integerValue))
    }
    
    public func format(floatingValue: any BinaryFloatingPoint) -> String {
        return String.init(format: strFormat, Double(floatingValue))
    }
}
