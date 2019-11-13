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
