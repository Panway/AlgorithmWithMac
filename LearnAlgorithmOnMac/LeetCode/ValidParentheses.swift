//
//  ValidParentheses.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/5.
//  Copyright © 2019 WeirdPan. All rights reserved.
// MARK:PPLeetCode20 有效的括号
//PPCategory:Stack
//https://leetcode-cn.com/problems/valid-parentheses/solution/you-xiao-de-gua-hao-by-leetcode/

import Foundation

class ValidParentheses: NSObject {
    var stack:Array<Character> = []
    let mappings = [")":"(","]":"[","}":"{"]
//    let mappings = ['c':'c']
    //官方解法
    //执行用时: 8 ms， 在所有Swift 提交中击败了87.09% 的用户
    //内存消耗: 20.9 MB，在所有Swift 提交中击败了33.33% 的用户
    func isValid(_ s: String) -> Bool {
        for char in s {
            //闭括号，滚粗
            if (mappings[String(char)] != nil) {
                let topStr = stack.isEmpty ? "#" : stack.removeLast() //peek()
                if (String(topStr) != mappings[String(char)]) {
                    return false
                }
            }
            else {
                stack.append(char)//开括号，保存
            }
        }
        return stack.isEmpty
    }
    //我自己的解法，左括号进去，右括号滚出来
    //执行用时: 12 ms 在所有Swift提交中击败了60 .55%的用户
    //内存消耗: 20.9 MB， 在所有Swift 提交中击败了33 .33%的用户
    func isValid_PP(_ s: String) -> Bool {
        for char in s {
            if char == "{" || char == "[" || char == "(" {
                stack.append(char)
            }
            else {
                let topStr = stack.count<1 ? "#" : stack[stack.count-1] //peek()
                if (char == "}" || char == "]" || char == ")") {
                    if ((char == "}" && topStr != "{") || (char == "]" && topStr != "[") || (char == ")" && topStr != "(")) {
                        return false
                    }
                    stack.removeLast()
                }
            }
        }
        return stack.isEmpty
        
    }
//    func push(_ string:Character) -> Array<Character> {
//        stack.append(string)
//        return stack
//    }
//    func pop(_ string:Character) -> Array<Character> {
//        stack.removeLast()
//        return stack
//    }
    func peek() -> Character {
        return stack[stack.count-1]
    }
    
    
    
    
    
    //https://github.com/soapyigu/LeetCode-Swift/blob/master/Stack/ValidParentheses.swift
    func isValid2(_ s: String) -> Bool {
        var stack = [Character]()
        
        for char in s {
            if char == "(" || char == "[" || char == "{" {
                stack.append(char)
            } else if char == ")" {
                guard stack.count != 0 && stack.removeLast() == "(" else {
                    return false
                }
            } else if char == "]" {
                guard stack.count != 0 && stack.removeLast() == "[" else {
                    return false
                }
            } else if char == "}" {
                guard stack.count != 0 && stack.removeLast() == "{" else {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
    
    func testValid() {
        let aaa = ValidParentheses().isValid_PP("(])")
        let bbb = ValidParentheses().isValid_PP("()")
        let ccc = ValidParentheses().isValid_PP("]")
        debugPrint(aaa)
        debugPrint(bbb)
        debugPrint(ccc)
    }
    
}
