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


enum Visit<Element: Hashable> {
    case source
    case edge(Edge<Element>)//关联值,相当于把一个或多个任意类型的值跟这个枚举值关联起来
}

extension Graphable {
    // MARK: - 广度优先搜索
    ///广度优先搜索
    ///感谢 https://www.raywenderlich.com/710-swift-algorithm-club-swift-breadth-first-search
    public func breadthFirstSearch(from source: Vertex<Element>, to destination: Vertex<Element>)
        -> [Edge<Element>]? {
            var queue = Queue<Vertex<Element>>()
            queue.enqueue(source) // 1 第一次把起点入列
            //记录访问过的点
            var visits : [Vertex<Element> : Visit<Element>] = [source: .source] // 1
            while let visitedVertex = queue.dequeue() { // 从队列中取出顶点，并将其称为已访问顶点
                if visitedVertex == destination { // 3
                    var vertex = destination // 1
                    var route: [Edge<Element>] = [] // 2.用来存储您找到目标点后返回的路线
                    
                    while let visit = visits[vertex],
                        // 3 只要visits里包含某个顶点，并且该顶点为边，该循环就会继续
                        //如果条目是源，则while循环将结束
                        case .edge(let edge) = visit {
//                            case let .edge(edge) = visit {//等价于这个
                            route = [edge] + route
                            vertex = edge.source // 4 先找到老鼠到珠宝的边，vertex从珠宝改成老鼠、然后找到入口到老鼠的边，vertex从老鼠改成入口，下一次循环visit变成了字符串source，就不会走到这一步
                            
                    }
                    return route // 5
                }
                //如果起点不是目的点，就看看起点的邻居、起点的邻居的邻居是不是目的点
                //如果visits中不包含当前边的目的点，就把这个目的点入列，并记录目的点到visits
                let neighbourEdges = edges(from: visitedVertex) ?? []//// 获取穿过顶点所有的边
                for edge in neighbourEdges {
                    if visits[edge.destination] == nil { // 2
                        queue.enqueue(edge.destination)
                        visits[edge.destination] = .edge(edge) // 3
                    }
                }
                
            }
            return nil // 4
            
    }
    
}









/// 深度优先和广度优先搜索
class PPSearchAlgorithm: NSObject {
    //广度优先搜索测试用例
    func testBreadthFirstSearch() {
        let dungeon = AdjacencyList<String>()
        ///![](https://i.loli.net/2020/02/21/HqtVUaw5MGQSYeu.png)
        //备用URL https://koenig-media.raywenderlich.com/uploads/2017/03/E1-1.png
        // 假设有一个迷宫长这个样↑↑↑，我该怎么从大门走到有珠宝的房间呢？
        
        // 创建九个房间：
        let entranceRoom = dungeon.createVertex(data: "Entrance")
        let spiderRoom = dungeon.createVertex(data: "Spider")
        let goblinRoom = dungeon.createVertex(data: "Goblin")
        let ratRoom = dungeon.createVertex(data: "Rat")
        let knightRoom = dungeon.createVertex(data: "Knight")
        let batRoom = dungeon.createVertex(data: "Bat")
        let orcRoom = dungeon.createVertex(data: "Orc")
        let keyRoom = dungeon.createVertex(data: "Key")
        let treasureRoom = dungeon.createVertex(data: "Treasure")
        
        //创建8条路线
        dungeon.add(.undirected, from: entranceRoom, to: spiderRoom, weight: 1)
        dungeon.add(.undirected, from: entranceRoom, to: ratRoom, weight: 1)
        dungeon.add(.undirected, from: entranceRoom, to: batRoom, weight: 1)
        dungeon.add(.undirected, from: spiderRoom, to: goblinRoom, weight: 1)
        dungeon.add(.undirected, from: spiderRoom, to: orcRoom, weight: 1)
        dungeon.add(.undirected, from: ratRoom, to: treasureRoom, weight: 1)
        dungeon.add(.undirected, from: ratRoom, to: keyRoom, weight: 1)
        dungeon.add(.undirected, from: batRoom, to: knightRoom, weight: 1)
        
        debugPrint(dungeon.description)
        
        //探索那条路径！
        if let edges = dungeon.breadthFirstSearch(from: entranceRoom, to: treasureRoom) {
            for edge in edges {
                print("\(edge.source) -> \(edge.destination)")
            }
        }
    }
    
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
    func breadthFirstSearch1(_ root: PPSearchNode?) {
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
    
    //MARK: - 深度优先搜索
    /// 深度优先搜索
    /// 感谢 https://www.raywenderlich.com/661-swift-algorithm-club-swift-depth-first-search
    /// - Parameter start: 起始点
    /// - Parameter end: 目标点
    /// - Parameter graph: 图
    func depthFirstSearch(from start: Vertex<String>, to end: Vertex<String>, graph: AdjacencyList<String>) -> Stack<Vertex<String>> {
        var visited = Set<Vertex<String>>() // 1 存储所有已访问的顶点,防止无限循环
        var stack = Stack<Vertex<String>>() // 2 存储路径经过的顶点，先入栈，如果发现不是就弹出
        

        stack.push(start)
        visited.insert(start)// 4 先测试第一个点

        outer: while let vertex = stack.peek(), vertex != end { // 1
            
            guard let neighbors = graph.edges(from: vertex), neighbors.count > 0 else { // 4 检查起点是否有邻居，如果连邻居都没有，那就直接返回
                debugPrint("backtrack from \(vertex)")
                stack.pop()
                continue
            }
            
            for edge in neighbors { // 5 如果顶点有任何边，就遍历每个边
                if !visited.contains(edge.destination) {
                    visited.insert(edge.destination)
                    stack.push(edge.destination)
                    print(stack.description)
                    continue outer
                }
            }
            
            debugPrint("backtrack from \(vertex)") // 6 如果已经访问了当前顶点的所有边，则意味着我们到达了死角，找不到目标点
            stack.pop()
        }

        
        return stack // 3 返回一个装满顶点的栈（路径）
    }
    func testDepthFirstSearch() {
        //: ![image.png](https://i.loli.net/2020/02/22/3iyFkulU42hbYaD.png)
        // 实际应用：如何找到上图中从S到E的路径
        // Sample Graph
        let adjacencyList = AdjacencyList<String>()
        
        let s = adjacencyList.createVertex(data: "S")
        let a = adjacencyList.createVertex(data: "A")
        let b = adjacencyList.createVertex(data: "B")
        let c = adjacencyList.createVertex(data: "C")
        let d = adjacencyList.createVertex(data: "D")
        let f = adjacencyList.createVertex(data: "F")
        let g = adjacencyList.createVertex(data: "G")
        let e = adjacencyList.createVertex(data: "E")
        
        adjacencyList.add(.undirected, from: s, to: a)
        adjacencyList.add(.undirected, from: a, to: b)
        adjacencyList.add(.undirected, from: a, to: d)
        adjacencyList.add(.undirected, from: a, to: c)
        adjacencyList.add(.undirected, from: b, to: d)
        adjacencyList.add(.undirected, from: d, to: g)
        adjacencyList.add(.undirected, from: d, to: f)
        adjacencyList.add(.undirected, from: f, to: e)
        
//        debugPrint(adjacencyList.description)
        debugPrint(depthFirstSearch(from: s, to: e, graph: adjacencyList))

    }
    
    
    
}

class PPSearchNode: PPTreeNode {
    var visited : Bool = false
    var neighbors : Array<PPSearchNode> = []
}
