//
//  MajorityElement.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/4.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation
class MajorityElement {
//求众数
//https://leetcode-cn.com/problems/majority-element/solution/du-le-le-bu-ru-zhong-le-le-ru-he-zhuang-bi-de-qiu-/
    //摩尔投票法
//    题目：寻找数组中超过一半的数字，这意味着数组中其他数字出现次数的总和都是比不上这个数字出现的次数 。
//    即如果把 该众数记为 +1 ，把其他数记为 −1 ，将它们全部加起来，和是大于 0 的。
    class func majorityElement(_ nums: [Int]) -> Int {
        var count = 0, candidate = 0//candidate 用来保存数组中遍历到的某个数字，count 表示当前数字的出现次数
        
        for num in nums {
            if count == 0 {
                candidate = num
            }
            
            count += (candidate == num) ? 1 : -1
        }
        
        return candidate
    }
}
