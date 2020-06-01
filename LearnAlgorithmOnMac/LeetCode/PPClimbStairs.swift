//
//  PPClimbStairs.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2020/6/1.
//  Copyright © 2020 WeirdPan. All rights reserved.
//

import Foundation

//https://leetcode-cn.com/problems/climbing-stairs/
//PPLeetCode70. 爬楼梯
//PPCategory:Recursive PPCategory:递归
//Time Complexity: O(n), Space Complexity: O(1)
func climbStairs(_ n: Int) -> Int {
    if n == 1 {
        return 1
    }
    var first = 1
    var second = 2
    for _ in 3..<n {
        let third = first + second
        first = second
        second = third
    }
    return second
    
}
