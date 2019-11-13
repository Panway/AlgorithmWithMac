//
//  ThreeSum.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/4.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation

class ThreeSum: NSObject {
//解法https://leetcode-cn.com/problems/3sum/solution/hua-jie-suan-fa-15-san-shu-zhi-he-by-guanpengchn/
    /* 三个指针
     首先对n个元素的数组进行排序，排序后固定一个数 nums[i]，再使用左右指针指向 nums[i+1] nums[n-1]，数字分别为nums[L] 和 nums[R]，计算三个数的和 sum 判断是否满足为 0，满足则添加进结果集
     如果 nums[i]大于 0，则三数之和必然无法等于 0，结束循环
     如果 nums[i] == nums[i-1]，则说明该数字重复，会导致结果重复，所以应该跳过
     当 sum == 0 时，nums[L] == nums[L+1] 则会导致结果重复，应该跳过，L++
     当 sum == 0 时，nums[R] == nums[R-1] 则会导致结果重复，应该跳过，R--
     时间复杂度：O(n^2)，n 为数组长度
     链接：
     */
    class func threeSum(nums:[Int],target:Int) -> [Array<Int>] {
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
                print("比较\(nums[i])、\(nums[left])、\(nums[right])")
                if nums[i] + nums[left] + nums[right] == target {
                    result.append([nums[i], nums[left], nums[right]])
                    print("符合要求")

                    //去重
                    repeat {
                        left += 1
                    } while nums[left] == nums[left - 1]
                    repeat {
                        right -= 1
                    } while nums[right] == nums[right + 1]
                    
                    
//                    if (nums[left] == nums[left+1]) || (nums[right] == nums[right-1]) {
//
//                    }
//                    else {
//                        print("符合要求")
//                        result.append([nums[i],nums[left],nums[right]])
//                    }
//                    left+=1
//                    right-=1
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



