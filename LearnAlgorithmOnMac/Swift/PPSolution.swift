//
//  PPSolution.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/12/3.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation

class PPSolution {
    
    /// PPLeetCode120 三角形最小路径和 https://leetcode-cn.com/problems/triangle/
    ///
    ///     [
    ///      [2],
    ///      [3,4],
    ///      [6,5,7],
    ///      [4,1,8,3]
    ///     ]
    ///     https://leetcode-cn.com/problems/triangle/solution/120-san-jiao-xing-zui-xiao-lu-jing-he-by-alexer-66/
    ///     解法：result(i,j) = min(triangle[triangle.count-1,j] , triangle[triangle.count-1,j+1]) + triangle[i,j]
    ///     i从triangle.count-2到0，j从0到i
    ///     第四列的每次循环后结果如下
    ///     [7,1,8,3]       [min(4,1)+6,1,8,3]
    ///     [7,6,8,3]       [7,min(1,8)+5,8,3]
    ///     [7,6,10,3]      ...
    ///     [9,6,10,3]
    ///     [9,10,10,3]
    ///     [11,10,10,3]
    func minimumTotal(_ triangle: [[Int]],_ printLastRow:Bool = false) -> Int {
        guard triangle.count > 0 else {
            return 0
        }
        
        var dp = triangle.last!
        //i是行数，j是列数，第n行有n列
        for i in stride(from: triangle.count - 2, through: 0, by: -1) {
            for j in 0...i {
                dp[j] = min(dp[j], dp[j + 1]) + triangle[i][j]
                if printLastRow {//是否打印过程
                    var prefixB = dp.map { String(format: "%d,", $0) }.joined()
                    prefixB.removeLast()
                    print("["+prefixB+"]")
                }
            }
        }
        
        return dp[0]
    }
    ///三角形最小路径和测试用例
    func testMinimumTotal () {
        let result = minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]])
        debugPrint(result)
    }
    
    
    ///PPLeetCode3 https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/
    ///无重复字符的最长子串长度
    ///
    ///思路：
    ///初始化游标开始位start，结束位end，最大子字符串长度ans，Hash记录cache
    ///
    ///如果没有重复字符出现：
    ///循环 游标end开始步进，如果没有遇到重复字符ans为 （end - start ），并用当前字符为Key记录当前 end 游标的index
    ///
    ///    有重复字符出现
    ///    1.如果碰到重复字符(从我们Hash记录中找到)
    ///    2.更新start游标移动至上次记录的重复字符下标的后一位
    ///    3.取之前ans字符长度和现在字符长度最大值为新的无重复字符的最长子串
    ///
    ///    循环直到s的最后一位
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var ans = 0,start = 0,end = 0
        let characters = Array(s)
        var cache:[Character: Int] = [:]
        let length = s.count
        while start < length && end < length {
            let char = characters[end]
            if let cacheVal = cache[char] {
                start = max(start, cacheVal)//应付"abba"这种特例
            }
            end += 1
            ans = max(ans, end - start )
            cache[char] = end
        }
        return ans
    }
    //github.com/soapyigu https://leetcode-cn.com/submissions/detail/38932086/
    func lengthOfLongestSubstring2(_ s: String) -> Int {
        var maxLen = 0, startIdx = 0, charToPos = [Character: Int]()
        let sChars = Array(s)
        
        for (i, char) in sChars.enumerated() {
            if let pos = charToPos[char] {
                startIdx = max(startIdx, pos)
            }
            
            // update to next valid position
            charToPos[char] = i + 1
            maxLen = max(maxLen, i - startIdx + 1)
        }
        
        return maxLen
    }

    
    
    //  老胡的OC转Swift版 - https://objectivec2swift.com/
    func findNoDuplicateSubString(_ originString: String) -> String? {
        if originString.count == 0 {
            return nil
        }
        var startIndex = 0
        var endIndex = 0
        var currentIndex = 0
        var dic: [AnyHashable : Any] = [:]
        for i in 0..<originString.count {
            let iChar = (originString as NSString).substring(with: NSRange(location: i, length: 1))
            let lastCacheIndex = dic[iChar] as? NSNumber
            dic[iChar] = NSNumber(value: i)
            if lastCacheIndex != nil {
                currentIndex = lastCacheIndex?.intValue ?? 0 + 1
            }
            if i - currentIndex > endIndex - startIndex {
                startIndex = currentIndex
                endIndex = i
            }
        }
        return (originString as NSString).substring(with: NSRange(location: startIndex, length: endIndex - startIndex + 1))
    }
    
    func testLengthOfLongestSubstring() {
        var result = lengthOfLongestSubstring("abba")
        debugPrint(result)
        result = lengthOfLongestSubstring("bbbbb")
        debugPrint(result)
        result = lengthOfLongestSubstring("abcabcbb")
        debugPrint(result)
        result = lengthOfLongestSubstring("pwwkew")
        debugPrint(result)
    }
    
    // PPLeetCode53 最大子序和 https://leetcode-cn.com/problems/maximum-subarray/
    //[-12,3,6,9,1,-9,0,8,7,9,-3]
    // 贪心算法，每一步都选择最佳方案，到最后就是全局最优的方案。
    class func maxSubArray(_ n: [Int]) -> (startIndex: Int, endIndex: Int, maxSum: Int) {
        let nums = n
        var maxSum = nums[0]
        var currentSum = nums[0]
        var startIndex = 0
        var endIndex = 0
        for i in 1..<nums.count {
            if currentSum + nums[i] < nums[i] {
                startIndex = i
            }
            currentSum = max(currentSum + nums[i], nums[i])//当前的数字 vs 上一轮的自己
            if maxSum < currentSum {
                endIndex = i
            }
            maxSum = max(currentSum, maxSum)//这一轮的当前总和 vs 上一轮的自己
            debugPrint("currentSum=\(currentSum) maxSum=\(maxSum)")
        }
        return (startIndex,endIndex,maxSum)
    }
    //https://leetcode-cn.com/problems/maximum-subarray/solution/hua-jie-suan-fa-53-zui-da-zi-xu-he-by-guanpengchn/
    // [-2,1,-3,4,-1,2,1,-5,4]
    class func maxSubArray2(_ nums: [Int]) -> Int {
        var res = nums[0]
        var sum = 0
        for num in nums {
            //如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字
            //换种说法，如果sum不是负数，那么他就不会让结果变小，我们就留下他
            if (sum > 0) {
                sum += num
            }
            else {//如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字
                sum = num
            }
            res = max(res, sum)
        }
        return res
    }
    
    //PPLeetCode152 乘积最大子数组
    //答案来自：https://leetcode-cn.com/problems/maximum-product-subarray/solution/hua-jie-suan-fa-152-cheng-ji-zui-da-zi-xu-lie-by-g/
    //解题思路：每轮循环比较`累乘乘积`和`当前数字`，二者最大值为resMax，二者最小值为resMin，
    //然后比较`上次乘积最大值`res和resMax谁最大，最大的即结果
    //这里有个问题，假如当前数字是负数，那么resMax和resMin乘以这个数字后，老大和老小的地位反了，所以此时需要交换这两者
    //测试用例：let res = PPSolution.maxProduct([2,3,-2,4]); debugPrint(res)
    class func maxProduct(_ nums: [Int]) -> Int {
        var res = Int.min
        var resMin = 1
        var resMax = 1
        for num in nums {
            if num < 0 {
                let tmp = resMax
                resMax = resMin
                resMin = tmp
            }
            resMin = min(resMin * num, num)
            resMax = max(resMax * num, num)
            res = max(res, resMax)
        }
        return res
    }
    
    
    
    
}
