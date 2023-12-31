//
//  ViewController.swift
//  SweetStringInterpolation
//
//  Created by alexwind on 12/28/2023.
//  Copyright (c) 2023 alexwind. All rights reserved.
//

import UIKit
import SweetStringInterpolation

class ViewController: UIViewController {

    var byteFormatter: LevelNumberFormatter = LevelNumberFormatter(
        levels: [
            .init(value: 0, suffix: "B"),
            .init(value: 1_000, suffix: "K"),
            .init(value: 1_000_000, suffix: "M"),
            .init(value: 1_000_000_000, suffix: "G"),
            .init(value: 10_000_000_000, fixedDescription: "9.9G+"),
        ],
        decimalPlace: 1, shouldRoundUp: false)
    
    var smhTimerFormatter: LevelNumberFormatter = .init(
        levels: [
            .init(value: 0, suffix: "秒"),
            .init(value: 60, suffix: "分"),
            .init(value: 3600, suffix: "小时"),
            .init(value: 3600 * 24, suffix: "天"),
            .init(value: 3600 * 24 * 7, fixedDescription: "超过一周啦")
        ],
        decimalPlace: 1)
    
    var secondFormatter: LevelSeperateFormatter = .init(
        levels: [
            .init(value: 60, suffix: ""),
            .init(value: 60, suffix: ":"),
            .init(value: 24, suffix: ":"),
        ],
        numberFormatter: VF.zeroPadding(width: 2)
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let numList: [Int] = [0, 6, 100, 1026, 100099, 599_999, 999_999_999, 999_999_999_999]
//        let numList: [Int] = [999_999_999_999]
        for num in numList {
//            let formatter = IntegerNumberFormatter.kmbt()
            let formatter = self.secondFormatter
            print("\(opt: num)")
            print("\(value: num, formatter: formatter)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

