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
    
    //搜索字符串测试用例
    func testSearchStringWithSkipTable() {
        let s = "ABCDEF"
        let i = s.index(of: "TCDEF", usingHorspoolImprovement: true)
        debugPrint(i ?? "-1")
    }
    
    
}

class PPSearchNode: PPTreeNode {
    var visited : Bool = false
    var neighbors : Array<PPSearchNode> = []
}


/*
 来源：https://github.com/raywenderlich/swift-algorithm-club/blob/master/Boyer-Moore-Horspool/BoyerMooreHorspool.swift
 Boyer-Moore字符串搜索 BM搜索
 
 This code is based on the article "Faster String Searches" by Costas Menico
 from Dr Dobb's magazine, July 1989.
 http://www.drdobbs.com/database/faster-string-searches/184408171
 */
extension String {
    
    fileprivate var skipTable: [Character: Int] {
        var skipTable: [Character: Int] = [:]
        for (i, c) in enumerated() {
            skipTable[c] = count - i - 1
        }
        return skipTable
    }
    //主串从currentIndex开始从后往前跟模式串比较。
    //pattern每次去掉最后一个字符再递归比较，比如：HELLO、HELL、HEL、HE、H
    fileprivate func match(from currentIndex: Index, with pattern: String) -> Index? {
        //检查是否超出边界，超出范围将返回nil
        if currentIndex < startIndex { return nil }
        if currentIndex >= endIndex { return nil }
        //如果还没比到最左边的字符，主串和模式串就不匹配了，返回空表示没匹配成功
        if self[currentIndex] != pattern.last { return nil }
        //举例子：如果`HELLO`从`O`比到最左边的字符`H`，一直都匹配的话，
        //那就说明查找成功，返回当前索引表明从此位置开始匹配
        if pattern.count == 1 && self[currentIndex] == pattern.last { return currentIndex }
        return match(from: index(before: currentIndex), with: "\(pattern.dropLast())")//上一个字符、
    }
    //MARK:使用跳过表(skip table)查找字符串
    ///使用跳过表(skip table)查找字符串，感谢 https://www.raywenderlich.com/541-swift-algorithm-club-boyer-moore-string-search-algorithm#toc-anchor-006
    func index(of pattern: String) -> Index? {
        //检查模式字符串的长度是否在源字符串的范围内
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= count else { return nil }
        
        let skipTable = pattern.skipTable
        let lastChar = pattern.last!
        
        // 假如在`ABCDEF`中查找`ZCDEF`,那么i的位置变动如下：
        // A B C D E F
        // Z C D E F   （i初始是4）→（5）
        //      ↓
        // A B C D E F
        //   Z C D E F （5）→（6，此时while结束）
        var i = index(startIndex, offsetBy: patternLength - 1)
        while i < endIndex {
            let c = self[i]//主串从pattern.length处的字符开始，从右到左跟pattern比较
            //如果主串的字符跟pattern的字符匹配，就，否则就跳`skipTable[c]`步
            //如果源字符串的当前字符与模式字符串pattern的最后一个字符匹配，则将尝试运行match函数。
            if c == lastChar {
                //如果返回非nil值，则意味着您已找到一个匹配项，因此您将返回与该模式匹配的索引。
                if let k = match(from: i, with: pattern) { return k }
                //否则，您将移至下一个索引。
                i = index(after: i)
            } else {
                //如果无法进行匹配，请查阅跳过表以查看可以跳过多少个索引。
                //如果这一跳过超出了源字符串的长度，您将直接进入结尾，然后while循环结束。
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
    
    
    
    func index(of pattern: String, usingHorspoolImprovement: Bool = false) -> Index? {
        // 缓存要搜索的模式串长度，因为我们会多次用到它，所以我们要节省开销
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= self.count else { return nil }
        
        //制作跳过表。
        //如果当前比较的主串字符来自模式串且跟模式串的最后一个字符不一样，该表可以确定模式串往右跳几步
        var skipTable = [Character: Int]()
        for (i, c) in pattern.enumerated() {
            skipTable[c] = patternLength - i - 1
        }
        
        // This points at the last character in the pattern.
        let p = pattern.index(before: pattern.endIndex)
        let lastChar = pattern[p]
        
        // The pattern is scanned right-to-left, so skip ahead in the string by
        // the length of the pattern. (Minus 1 because startIndex already points
        // at the first character in the source string.)
        var i = index(startIndex, offsetBy: patternLength - 1)
        
        // This is a helper function that steps backwards through both strings
        // until we find a character that doesn’t match, or until we’ve reached
        // the beginning of the pattern.
        func backwards() -> Index? {
            var q = p
            var j = i
            while q > pattern.startIndex {
                j = index(before: j)
                q = index(before: q)
                if self[j] != pattern[q] { return nil }
            }
            return j
        }
        
        // The main loop. Keep going until the end of the string is reached.
        while i < endIndex {
            let c = self[i]
            
            // Does the current character match the last character from the pattern?
            if c == lastChar {
                
                // There is a possible match. Do a brute-force search backwards.
                if let k = backwards() { return k }
                
                if !usingHorspoolImprovement {
                    // If no match, we can only safely skip one character ahead.
                    i = index(after: i)
                } else {
                    // Ensure to jump at least one character (this is needed because the first
                    // character is in the skipTable, and `skipTable[lastChar] = 0`)
                    let jumpOffset = max(skipTable[c] ?? patternLength, 1)
                    i = index(i, offsetBy: jumpOffset, limitedBy: endIndex) ?? endIndex
                }
            } else {
                // The characters are not equal, so skip ahead. The amount to skip is
                // determined by the skip table. If the character is not present in the
                // pattern, we can skip ahead by the full pattern length. However, if
                // the character *is* present in the pattern, there may be a match up
                // ahead and we can't skip as far.
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
}
