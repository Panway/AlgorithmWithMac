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
    
    
    
    
    
    
    
    
    
    
}
