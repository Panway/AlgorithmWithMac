//
//  PPUnsortedAlgorithm.swift
//  AlgorithmWithSwift
//
//  Created by panwei on 2019/11/9.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation


/*和为k的子数组*/
func subarraySum(_ nums: [Int],_ k: Int) -> Int {
    if nums.count == 0 {
        return 0
    }
    var dic : Dictionary<Int, Int> = [:]
    var sum:Int=0;
    var res:Int=0;
    for i in 0..<nums.count {
        sum += nums [i]
        /*当本身为k时，res + 1 */
        if sum==k {
            res += 1
        }
        /*当sum - k存在时，res +之前保存的和为sum - k的数量*/
        if dic[sum - k] != nil {
            res += dic[sum - k]!
        }
        
        if dic[sum] == nil {
            dic[sum] = 1
        } else {
            dic[sum] = dic[sum]! + 1
        }
    }
    return res
}

/*最短无序连续子数组*/
func findUnsortedSubarray(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    var rightIndex : Int = 0
    var max : Int = nums[0]
    for index in 1..<nums . count {
        if nums [index] >= max {
            max = nums [ index]
        } else {
            rightIndex = index
        }
    }
    /* leftIndex也应该从0开始，比如说[1, 2, 3, 4]，如果从最大index开始，那么leftIndex最终也就为最大index */
    var leftIndex : Int = 0
    var min:Int=nums[nums.count-1]
    for index in (0..<nums.count - 1).reversed() {
        if nums[index] <= min {
            min = nums [index]
        } else {
            leftIndex = index
        }
    }
    return rightIndex != leftIndex ? rightIndex - leftIndex + 1 : 0
}
///树的按层次遍历
func levelOrder(_ root: PPTreeNode?) -> [[Int]] {
    if (root == nil) {
        return [[Int]]()
    }
    
    var queue : [PPTreeNode] = [PPTreeNode]()
    queue.append(root! )
    var length : Int = 0;
    var res : [[Int]] = [[Int]]()
    while (queue.count > 0) {
        length = queue.count
        var temp : [Int] = [Int]()
        while (length > 0) {
            length -= 1
            let node : PPTreeNode = queue.first!
            queue.remove(at: 0)
            if (node.leftNode != nil) {
                queue.append(node.left!)
                if (node.right != nil) {
                    queue.append(node.right!)
                }
                temp.append(node.val)
            }
            res.append( temp)
        }
    }
    return res
}

