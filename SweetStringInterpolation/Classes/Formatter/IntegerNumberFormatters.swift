//
//  NumberFormatters.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 2023/12/28.
//

import Foundation

/** LevelNumberFormatter是将一个数按照不同数字等级格式化，取最高的那个等级的描述
 *  例如：想要将字节数进行格式化，并且最高的希望表述成9.9G+的话，可以这样做
 *  var byteFormatter: LevelNumberFormatter = LevelNumberFormatter(
         levels: [
             .init(value: 0, suffix: "B"),
             .init(value: 1_000, suffix: "K"),
             .init(value: 1_000_000, suffix: "M"),
             .init(value: 1_000_000_000, suffix: "G"),
             .init(value: 10_000_000_000, fixedDescription: "9.9G+"),
         ],
         decimalPlace: 1, shouldRoundUp: false)
 *
 */
public class LevelNumberFormatter: IntegerNumberFormatter {
    private let reversedLevel: [IntLevel]
    private let precisionFormatter: any FloatingNumberFormatter
    
    public init(levels: [IntLevel], decimalPlace: Int, shouldRoundUp: Bool = false) {
        self.reversedLevel = levels.reversed()
        self.precisionFormatter = VF.precision(decimalPlace: decimalPlace, shouldRoundUp: shouldRoundUp)
    }
    
    public func format(integerValue: any BinaryInteger) -> String {
        let intValue = Int(integerValue)
        var matchedLevel: IntLevel?
        for level in reversedLevel {
            if intValue > level.value {
                matchedLevel = level
                break
            }
        }
        
        guard let level = matchedLevel ?? reversedLevel.last else {
            #if DEBUG
            fatalError("匹配不到等级")
            #else
            return ""
            #endif
        }
        
        // 正常intValue肯定大于level.value，但是有可能出现intValue比最低档都小
        let finalValue = max(level.value, intValue)
        let result: Double = level.value == 0 ? Double(finalValue) : Double(finalValue) / Double(level.value)
        return level.format(numberString: "\(value: result, formatter: precisionFormatter)")
    }
}
