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
        
        
        //获取分区位置：smallerIndex，此部分可以合并成一个分区函数
        let pivotVal = numsArray[numsArray.count-1]
        let count = numsArray.count
        var nums = numsArray
        var smallerIndex = 0
        for lagerIndex in 0..<count {
            if nums[lagerIndex] < pivotVal {
                (nums[lagerIndex],nums[smallerIndex]) = (nums[smallerIndex],nums[lagerIndex])
                smallerIndex += 1
            }
        }
        (nums[smallerIndex],nums[numsArray.count-1]) = (nums[numsArray.count-1],nums[smallerIndex])
        
        
        let left = Array(nums[0..<smallerIndex])
        let right = smallerIndex+1<nums.count ? Array(nums[smallerIndex+1...numsArray.count-1]) : []
        print("分解成两个快排\(left) & \(right)")
        
        let result = pp_quickSort(left) + [nums[smallerIndex]] + pp_quickSort(right)
        return result
    }
    
    // 快速排序
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
}
