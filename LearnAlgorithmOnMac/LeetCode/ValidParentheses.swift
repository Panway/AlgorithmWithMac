//
//  ValidParentheses.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/5.
//  Copyright © 2019 WeirdPan. All rights reserved.
// 有效的括号
//https://leetcode-cn.com/problems/valid-parentheses/solution/you-xiao-de-gua-hao-by-leetcode/

import Foundation

class ValidParentheses: NSObject {
    var stack:Array<Character> = []
    func isValid(_ strings: String) -> Bool {
//        var flag = 0
        for str in strings {
            if str == "{" || str == "[" || str == "(" {
                stack.append(str)
//                push(str)
//                flag += 1
            }
            let topStr = peek()
            if ((str == "}" && topStr == "{") || (str == "]" && topStr == "[") || (str == ")" && topStr == "(")) {
                stack.removeLast()
//                pop(str)
//                flag -= 1
            }
                
        }
        return stack.isEmpty
    }
    func push(_ string:Character) -> Array<Character> {
        stack.append(string)
        return stack
    }
    func pop(_ string:Character) -> Array<Character> {
        stack.removeLast()
        return stack
    }
    func peek() -> Character {
        return stack[stack.count-1]
//        return stack
    }
    
    
    
    
    
    
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
    
}
