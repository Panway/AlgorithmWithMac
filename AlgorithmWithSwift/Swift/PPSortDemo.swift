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
    ///归并排序
    func mergeSort(numsArray:[Int]) -> [Int] {
        let count = numsArray.count
        if count == 1 {
            return numsArray// 当任意数组分解到只有一个时返回
        }
        let centerIndex = count/2
        // 分割
        let leftArray = Array(numsArray[0 ..< centerIndex ])
        let rightArray = Array(numsArray[centerIndex ..< count])
        // 归并(递归合并)
        return mergeTwoSortedArray(mergeSort(numsArray: leftArray),mergeSort(numsArray: rightArray))
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
}
