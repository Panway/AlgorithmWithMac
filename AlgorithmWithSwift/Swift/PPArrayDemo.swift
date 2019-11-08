//
//  PPArrayDemo.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/1.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation


class PPArrayDemo: NSObject {
    //👉swift👈
    //t👉wif👈s
    //tf👉i👈ws
    //tf👈i👉ws start < end（👉<👈），结束循环
    fileprivate func reverse<T>(_ chars: inout [T], _ start: Int, _ end: Int) {
      var start = start, end = end
     
      while start < end {
        swap(&chars, start, end)
        start += 1
        end -= 1
      }
    }
     
    fileprivate func swap<T>(_ chars: inout [T], _ p: Int, _ q: Int) {
      (chars[p], chars[q]) = (chars[q], chars[p])
    }
    func reverseWords(s: String?) -> String? {
      guard let s = s else {
        return nil
      }
     
      var chars = Array(s), start = 0
      reverse(&chars, 0, chars.count - 1)//整个字符串翻转，"the sky is blue" -> "eulb si yks eht"
     
      for i in 0 ..< chars.count {
        if i == chars.count - 1 || chars[i + 1] == " " {
          reverse(&chars, start, i)//"👉eulb👈 si yks eht" -> "👉blue👈 si yks eht"
          start = i + 2//"blue 👉si yks eht"
        }
      }
     
      return String(chars)
    }
}
