//
//  PPSortDemo.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/8.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation

class PPSortDemo: NSObject {
    
    //MARK: 插入排序
    /// 插入排序
    func insetSort(numsArray:[Int]) -> [Int] {
        let count = numsArray.count
        var nums = numsArray
        for i in 0..<count {
            for j in i+1..<count {
                if nums[j] < nums[i] {
                    let temp = nums[i]
                    nums[i] = nums[j]
                    nums[j] = temp
                }
            }
        }
        return nums
        
    }
    
    
    //MARK:归并排序
    ///归并排序 递推公式：merge_sort(p…r) = merge(merge_sort(p…q), merge_sort(q+1…r))
    func pp_mergeSort(_ numsArray:[Int]) -> [Int] {
        let count = numsArray.count
        if count == 1 {
            return numsArray// 当任意数组分解到只有一个时返回
        }
        let centerIndex = count/2
        // 分割
        let leftArray = Array(numsArray[0 ..< centerIndex ])
        let rightArray = Array(numsArray[centerIndex ..< count])
        // 归并(递归合并)
        return mergeTwoSortedArray(pp_mergeSort(leftArray),pp_mergeSort(rightArray))
    }
    /// 合并两个有序数组
    func mergeTwoSortedArray(_ leftArray:[Int],_ rightArray:[Int]) -> [Int] {
        var tempArray:Array<Int> = []
        var leftIndex = 0,rightIndex = 0

        while leftIndex < leftArray.count && rightIndex < rightArray.count {
            if leftArray[leftIndex] < rightArray[rightIndex] {
                tempArray.append(leftArray[leftIndex])
                leftIndex += 1
            }
            else {
                tempArray.append(rightArray[rightIndex])
                rightIndex += 1
            }
        }
        // 合并多余数组
        let res = tempArray + leftArray[leftIndex..<leftArray.count] + rightArray[rightIndex..<rightArray.count]
        return res
    }
    func swap(num1:Int,num2:Int) {
//        let temp = num1
//        nums1 = nums2
//        nums2 = temp
    }
    //MARK: 快速排序
    ///快速排序
    func pp_quickSort(_ numsArray:[Int]) -> [Int] {
        if numsArray.count <= 1 {
            return numsArray
        }
        
        
        //全部数据可分为 [左边的已整理分区（小）][右边的未整理分区（大）]
        //获取分区位置（右边未整理区域第一个元素位置）：unsortedIndex，此部分可以合并成一个分区函数
        let pivotVal = numsArray[numsArray.count-1]//分区的标准元素
        let count = numsArray.count
        var nums = numsArray
        var unsortedIndex = 0 //未整理区第一个元素的位置
        for currentIndex in 0..<count {
            if nums[currentIndex] < pivotVal {
                (nums[currentIndex],nums[unsortedIndex]) = (nums[unsortedIndex],nums[currentIndex])
                unsortedIndex += 1
            }
        }
        (nums[unsortedIndex],nums[numsArray.count-1]) = (nums[numsArray.count-1],nums[unsortedIndex])
        
        
        let left = Array(nums[0..<unsortedIndex])
        let right = unsortedIndex+1<nums.count ? Array(nums[unsortedIndex+1...numsArray.count-1]) : []
        print("分解成两个快排\(left) & \(right)")
        
        let result = pp_quickSort(left) + [nums[unsortedIndex]] + pp_quickSort(right)
        return result
    }
    
    // 别人写的快速排序
    func quicksort(_ array:[Int]) -> [Int] {
      guard array.count > 1 else {
        return array
      }
      let pivot = array[array.count / 2]
      let left = array.filter { $0 < pivot }
      let middle = array.filter { $0 == pivot }
      let right = array.filter { $0 > pivot }

      return quicksort(left) + middle + quicksort(right)
    }
    //MARK: 二分搜索/二分查找
    ///递归二分搜索有序数组，返回-1表示没找到
    func pp_binarySearchRecursively(_ nums:[Int], _ target:Int) -> Int {
        let index = nums.count/2
        if target > nums[nums.count-1] || target < nums[0]{
            return -1
        }
        if target == nums[index] {
            return index
        }
        else if target < nums[index] {
            return pp_binarySearchRecursively(Array(nums[0..<index]), target)
        }
        return pp_binarySearchRecursively(Array(nums[index..<nums.count]), target)
    }
    
    /// 别人写的 https://xiaozhuanlan.com/ios-interview/5978062134
    func binarySearchRecursively(nums: [Int], target: Int) -> Bool {
      return binarySearchRecursively(nums: nums, target: target, left: 0, right: nums.count - 1)
    }
    func binarySearchRecursively(nums: [Int], target: Int, left: Int, right: Int) -> Bool {
      guard left <= right else {
        return false
      }
      let mid = (right - left) / 2 + left
      if nums[mid] == target {
        return true
      } else if nums[mid] < target {
        return binarySearchRecursively(nums: nums, target: target, left: mid + 1, right: right)
      } else {
        return binarySearchRecursively(nums: nums, target: target, left: left, right: mid - 1)
      }
    }
    
    ///二分搜索有序数组(非递归)
    func pp_binarySearch(_ nums:[Int], _ target:Int) -> Int {
        var left = 0, mid = 0, right = nums.count-1
        //注意这里的`<=` !!!当left=2,mid=2,right=3时，left=mid+1会导致left=right
        while left <= right {
            //当数组的长度非常大、算法又已经搜索到了最右边部分的时候，那么right + left 就会非常之大，造成溢出导致程序崩溃,下面的写法也更容易理解
            mid = (right - left) / 2 + left//(right + left)/2
            if target == nums[mid] {
                return mid
            }
            else if target < nums[mid] {
                right = mid - 1
            }
            else {
                left = mid + 1 //Int (ceil( Double(right - left)/2.0 ))
            }
            
        }
        return -1
    }
}
