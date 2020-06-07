//
//  Myatoi.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2020/6/1.
//  Copyright © 2020 WeirdPan. All rights reserved.
//  PPLeetCode8. 字符串转换整数 (atoi)
//https://leetcode-cn.com/problems/string-to-integer-atoi/

import Foundation


func power (_ base:Int,_ power:Int) -> Int {
    var answer = 1
    for _ in 0..<power {
        answer *= base
        if answer >= Int.max/10 {
            return Int.max
        }
    }
    return answer
}
var numTable = ["1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"0":0,"-":-1,"+":1]
func myAtoi(_ str: String) -> Int {
    if str.count < 1 {
        return 0
    }
    var res = 0
    var num_str = ""
    
    var index = -1
    var negative = false
    let newStr = str.replacingOccurrences(of: " ", with: "")
    if newStr.count < 1 {
        return 0
    }
    if numTable[String(newStr.first!)] == nil {
        return 0
    }
    let aaa: Character = "+"
    let bbb: Character = "-"
    var lastChar : Character = "#"
    for char in str {
        if (char == aaa || char == bbb) {
            if (lastChar == aaa || lastChar == bbb) {
                return 0
            }
            if num_str.contains(aaa) || num_str.contains(bbb) {
                break
            }
            if numTable[String(lastChar)] != nil {
                break
            }
        }
        if numTable[String(char)] != nil {
            index = 1
            num_str = num_str + String(char)
        }
        else {
            if index != -1 {
                index = -1
                break
            }
        }
        lastChar = char
    }
    if num_str.hasPrefix("-") {
        negative = true
        num_str.remove(at: num_str.startIndex)
    }
    else if num_str.hasPrefix("+") {
        num_str.remove(at: num_str.startIndex)
    }
    while num_str.count > 0 && String(num_str.first!) == "0" {
        num_str.remove(at: num_str.startIndex)
    }
    let length = num_str.count
    
    for i in 0..<length{
        let new = power(10, i)
        if new >= Int.max {
            res = Int.max
            break
        }
        res = res +  new * numTable[String(num_str.removeLast())]!
    }
    if negative {
        res = res * -1
    }
    // [−2^31,  2^31 − 1]
    if res < -Int(pow(2.0, Double(31))) {
        return -Int(pow(2.0, Double(31)))
    }
    else if res > Int(pow(2.0, Double(31))) - 1 {
        return Int(pow(2.0, Double(31))) - 1
    }
    return res
}
