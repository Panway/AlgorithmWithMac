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
}
