//
//  ThreeSum.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/4.
//  Copyright © 2019 WeirdPan. All rights reserved.
//  🎈题目：给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。

import Foundation

class ThreeSum: NSObject {
    //PPCategory:Array
    //解法https://leetcode-cn.com/problems/3sum/solution/hua-jie-suan-fa-15-san-shu-zhi-he-by-guanpengchn/
    /* 三个指针
     首先对n个元素的数组进行排序，然后从左到右循环，每次先固定一个数 nums[i]，再使用左右指针指向 nums[i+1] nums[n-1]，数字分别为nums[L] 和 nums[R]，计算三个数的和 sum 是否为 0，和为0则添加进结果集
     如果 nums[i]大于 0，则三数之和必然无法等于 0，结束循环
     如果 nums[i] == nums[i-1]，则说明该数字重复，会导致结果重复，所以应该跳过
     当 sum == 0 时，nums[L] == nums[L+1] 则会导致结果重复，应该跳过，L++
     当 sum == 0 时，nums[R] == nums[R-1] 则会导致结果重复，应该跳过，R--
     时间复杂度：O(n^2)，n 为数组长度
     */
    //MARK:PPLeetCode15. 三数之和
    //测试用例：ThreeSum.threeSum([-1,0,1,2,-1,-4], target: 0)
    class func threeSum(_ nums:[Int],target:Int) -> [[Int]] {
        if nums.count<3 {
            return []
        }
        let nums = nums.sorted()
        var result = [Array<Int>]()
        for i in 0..<nums.count {
            if nums[i] > target {//第一个数都大于目标值，后面更大的数字就更没法累加和了
                break
            }
            if i > 0 && nums[i] == nums[i - 1] {
                continue//重复的数字
            }
            var left:Int = i+1
            var right:Int = nums.count-1
            
            while left < right {
                //debugPrint("比较\(nums[i])、\(nums[left])、\(nums[right])")
                if nums[i] + nums[left] + nums[right] == target {
                    result.append([nums[i], nums[left], nums[right]])
                    //debugPrint("符合要求")
                    //去重
                    while left < right && nums[left] == nums[left + 1] {
                        left += 1
                    }
                    while left < right && nums[right] == nums[right - 1] {
                        right -= 1 //假如它的继任者跟它一样，那就用它的继任者
                    }
                    left += 1
                    right -= 1
                }
                else if nums[i] + nums[left] + nums[right] > target {
                    right-=1
                }
                else {
                    left+=1
                }
            }
            
        }
        
        return result
    }
    
}



