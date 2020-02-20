//
//  PPSearchAlgorithm.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2020/2/19.
//  Copyright © 2020 WeirdPan. All rights reserved.
//

import Foundation


/*
 假设一个树的结构如下：
 https://images.xiaozhuanlan.com/photo/2018/aa41a6a4e47a49ba5e44b0e0ae40664b.jpg
 那么深度优先搜索(DFS)的搜索步骤为：
 1
 2 -> 3 -> 4
 5
 6 ->7 -> 8
 9 -> 10
 即每次把一个方向彻底搜索完全后，才返回搜索下一个方向，有点像二叉树的前序遍历
 
 
 广度优先搜索(BFS)的搜索步骤为：
 1
 2 -> 5 -> 6 -> 9
 3 -> 4
 7
 10
 8
 即每次访问上一步周围所有方向上的角落，有点像二叉树的层级遍历
 */
/// 深度优先和广度优先搜索
class PPSearchAlgorithm: NSObject {

    func visit(_ root: PPSearchNode?) {
        //待完成
    }
    //伪代码，别人写的
    func depthFirstSearch(_ root: PPSearchNode?) {
        guard let root = root else {
            return
        }
        
        visit(root)
        root.visited = true
        
        for node in root.neighbors {
            if !node.visited {
                depthFirstSearch(node)
            }
        }
        
    }
    //伪代码，别人写的
    func breadthFirstSearch(_ root: PPSearchNode?) {
        var queue = [PPSearchNode]()
        
        if let root = root {
            queue.append(root)
        }
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            
            visit(current)
            current.visited = true
            
            for node in current.neighbors {
                if !node.visited {
                    queue.append(node)
                }
            }
        }
    }
    
}

class PPSearchNode: PPTreeNode {
    var visited : Bool = false
    var neighbors : Array<PPSearchNode> = []
}
