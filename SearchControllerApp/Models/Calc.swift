//
//  Calc.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/07/07.
//

import Foundation
class Calc {
   static func calculateEAN13CheckDigit(barcode: String) -> Int {
     
       // 13桁のバーコードを取得する
       let digits = barcode.compactMap { Int(String($0)) }
       print(digits)
       // 奇数の数字を掛け合わせる
       let oddDigits = digits.enumerated().filter { $0.offset % 2 == 1 }.map { $0.element * 3 }
       
       // 偶数の数字を足し合わせる
       let evenDigits = digits.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
       
       // 奇数の数字の合計と偶数の数字の合計を足す
       let sum = oddDigits.reduce(0, +) + evenDigits.reduce(0, +)
       print(sum % 10)
       // 合計の1の位を返す
       return sum % 10
   }
    
    
    
}
