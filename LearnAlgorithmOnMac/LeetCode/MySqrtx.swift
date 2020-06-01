//
//  MySqrtx.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2020/6/1.
//  Copyright © 2020 WeirdPan. All rights reserved.
//

import Foundation

//https://leetcode-cn.com/problems/sqrtx/
//MARK: PPLeetCode69 x 的平方根整数部分
///我的解法
func pp_mySqrt(_ x:Int) -> Int {
    var left = 1, mid = 0, right = x
    while left <= right {
        //当left和right非常大，那么right + left 就会非常之大，造成溢出导致程序崩溃，
        //所以不推荐用(left+right)/2
        mid = (right - left) / 2 + left
        //left = 2, mid = 2, right = 3的时候是个特殊情况
        if mid == left || mid == right {
            break
        }
        if mid*mid <= x {
            left = mid
        }
        else {
            right = mid
        }
        
    }
    return mid
}
func mySqrt(_ x: Int) -> Int {
    var l = 0
    var r = x
    var res = 0
    while l <= r {
        let mid = (r - l) / 2 + l
        if mid * mid <= x {
            l = mid + 1
            res = mid
        } else {
            r = mid - 1
        }
    }
    return res
}
