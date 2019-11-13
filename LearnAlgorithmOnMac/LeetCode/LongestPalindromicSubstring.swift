//
//  LongestPalindromicSubstring.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/30.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

/**
 * Question Link: https://leetcode.com/problems/longest-palindromic-substring/
 * Primary idea: Find the longest palindrome string from every index at the center.
 * Time Complexity: O(n^2), Space Complexity: O(1)
 *
 */
//官方解答：https://leetcode-cn.com/problems/longest-palindromic-substring/solution/zui-chang-hui-wen-zi-chuan-by-leetcode/
/*
 方法四：中心扩展算法
事实上，只需使用恒定的空间，我们就可以在 O(n^2)的时间内解决这个问题。
我们观察到回文中心的两侧互为镜像。因此，回文可以从它的中心展开，并且只有 2n - 1 个这样的中心。
你可能会问，为什么会是 2n - 1 个，而不是 n 个中心？
原因在于所含字母数为偶数的回文的中心可以处于两字母之间（例如 “abba” 的中心在两个‘b’ 之间）,所以中心位置还可以是“a❤️bba”、“ab❤️ba”、“abb❤️a”
 
 //求一个字符串里面的最长回文字符串（两遍对称的字符串，比如bab、bb）
 //思路，比如一个字符串string=iambabygirl，回文字符串是bab，那么可以用i循环每个字符，假设它是中心的那个字符串a，那么string[i-1]和string[i+1]应该相等（a左右两遍的字符串相等），如果不等那就break跳出循环，如果相等，那么就继续比较string[i-2]和string[i+2]是否相等，如果相等，j--，直到string[i-j]和string[i+j]这轮小循环全部结束，此时回文字符串长度是(i+j)-(i-j)+1,即右index-左index+1

*/


class LongestPalindromicSubstring {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else {
            return s
        }
        
        let sChars = Array(s)
        var maxLen = 0, start = 0
        
        for i in 0..<sChars.count {
            //如果用|当做间隔，那么|a|b|a|b|c|的中心就是|a|b|❤️|b|c|
            searchPalindrome(sChars, i, i, &start, &maxLen)//回文字符串是奇数的情况，那么中心相当于是第2个字符串，左是2，右是2
            //如果用|当做间隔，那么|a|b|b|c|的中心就是|a|b❤️b|c|
            searchPalindrome(sChars, i, i + 1, &start, &maxLen)//回文字符串是偶数,那么中心相当于是2.5，左是2，右是3
        }
        
        return String(sChars[start..<start + maxLen])
    }
    
    private func searchPalindrome(_ chars: [Character], _ l: Int, _ r: Int, _ start: inout Int, _ maxLen: inout Int) {
        var left = l, right = r
        
        while left >= 0 && right < chars.count && chars[left] == chars[right] {
            left -= 1
            right += 1
        }
        
        if maxLen < right - left - 1 {
            start = left + 1
            maxLen = right - left - 1
        }
    }
}

