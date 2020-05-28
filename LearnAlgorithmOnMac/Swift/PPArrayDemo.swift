//
//  PPArrayDemo.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/1.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation

///数组相关的题目
class PPArrayDemo: NSObject {
    //MARK:反转字符串
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
    //交换 p 和 q 位置的字符，chars交换后会改变
    fileprivate func swap<T>(_ chars: inout [T], _ p: Int, _ q: Int) {
        (chars[p], chars[q]) = (chars[q], chars[p])
    }
    //MARK: 翻转英文句子
    func reverseWords(_ s: String?) -> String? {
      guard let s = s else {
        return nil//不能为空
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
    
    

    
    //感谢 https://leetcode-cn.com/problems/first-missing-positive/solution/tong-pai-xu-python-dai-ma-by-liweiwei1419/
    
     //假设确实的数字大于len + 1，那么就算数组里len个数字只有一种可能：数字1到len且不重样，所以可得：缺失的第一个整数是 [1, len + 1] 之间，所以这是循环的区间
     //遍历数组，将 1 就填充到 nums[0] 的位置， 2 填充到 nums[1] 的位置...
     //填充完成后再遍历一次数组，如果对应的 nums[i] != i + 1，即第1个遇到的它的值不等于下标的那个数，那么这个 i + 1 就是缺失的第一个正数
    //例子：
    //[3,4,-1,1] （原始数组）
    //[-1,4,3,1] （第一次for循环后）
    //
    //[-1,1,3,4] （第二次for循环第1次while后）
    //[1,-1,3,4] （第二次for循环第2次while后）
    //MARK: PPLeetCode41. 缺失的第一个正数
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var numbers = nums
        let length = numbers.count
        //使用 while 是因为交换后，原本 i 位置的 nums[i] 已经交换到了别的地方，交换后到这里的新值不一定是适合这个位置的，因此需要重新进行判断交换
        //如果使用 if，那么进行一次交换后，i 就会 +1 进入下一个循环，那么交换过来的新值就没有去找到它该有的位置
        for i in 0..<length {
            while numbers[i]>0 && numbers[i]<=length && numbers[numbers[i] - 1] != numbers[i] {
                numbers.swapAt(i, numbers[i] - 1)
            }
        }
        for i in 0..<length {
            if numbers[i] != i+1 {
                return i+1
            }
        }
        return length + 1
    }
}
