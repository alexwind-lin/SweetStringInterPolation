//
//  IntLevel.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 2023/12/29.
//

import Foundation

public struct IntLevel {
    public typealias LevelFormatterFunc = (_ numberString: String, _ suffix: String) -> String
    public let identifier: String
    public var value: Int
    public var suffix: String
    private var formatter: LevelFormatterFunc = { numberString, suffix in
        return "\(numberString)\(suffix)"
    }
    
    /// value: 这个等级的基础数字
    /// suffix: 计算完后加的后缀
    /// formatter: 自定义格式化函数
    public init(identifier: String = "",
                value: Int,
                suffix: String,
                formatter: LevelFormatterFunc? = nil) {
        self.identifier = identifier
        self.value = value
        self.suffix = suffix
        if let formatter {
            self.formatter = formatter
        }
    }

    /// value: 这个等级的基础数字
    /// fixedDescription: 这个等级的数字固定使用这个描述，不管具体的值是多少
    public init(identifier: String = "",
                value: Int,
                fixedDescription: String) {
        self.init(value: value, suffix: "") { numStr, suffix in
            return fixedDescription
        }
    }
    
    public func format(numberString: String) -> String {
        return formatter(numberString, suffix)
    }
}
