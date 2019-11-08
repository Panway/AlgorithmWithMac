//
//  FirstMissingPositive.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/4.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation

class FirstMissingPositive {
    class func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        let n = nums.count;

        // 第一步，检查 1 是否存在于数组中。如果没有，则已经完成，1 即为答案
        var contains = 0;
        for i in 0..<n {
            if (nums[i] == 1) {
                contains+=1;
                break;
            }
        }
        if (contains == 0) {
            return 1;
        }
        
        // 第二步，如果 nums = [1]，答案即为 2
        if (n == 1){
            return 2;
        }
        
        // 第三步，用 1 替换负数、0和大于 n 的数, 在转换以后，nums 只会包含正数
        for i in 0..<n {
            if ((nums[i] <= 0) || (nums[i] > n)) {
                nums[i] = 1;
            }
        }
        // 第四步，遍历数组。当读到数字 a 时，替换第 a 个元素的符号。使用索引和正负号作为检查器
        // 例如，如果 nums[1] 是负数，表示在数组中出现了数字 `1`
        // 如果 nums[2] 是正数 表示数字 2 没有出现
        for i in 0..<n {
            let a = abs(nums[i]);
            // 如果发现了一个数字a -> 改变第 a 个元素的符号(-)
            // 注意重复元素只需操作一次
            if (a == n){
                nums[0] = -abs(nums[0]);
            }
            else {
                nums[a] = -abs(nums[a]);
            }
        }
        
        // 第五步，再次遍历数组,返回第一个正数元素的下标。现在第一个正数的下标就是第一个缺失的数
        for i in 1..<n {
            if (nums[i] > 0) {
                return i;
            }
        }
        
        if (nums[0] > 0) {
            return n;
        }
        
        return n + 1;

//        作者：LeetCode
//        链接：https://leetcode-cn.com/problems/first-missing-positive/solution/que-shi-de-di-yi-ge-zheng-shu-by-leetcode/
    }
    
    
    
    
    class func firstMissingPositive2(_ nums: [Int]) -> Int {
        var set = Set<Int>()
        
        nums.forEach { set.insert($0) }
        
        for i in 0..<nums.count {
            if !set.contains(i + 1) {
                return i + 1
            }
        }
        
        return nums.count + 1
    }
    
}
