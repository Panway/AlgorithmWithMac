//
//  PPGraph.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2020/2/19.
//  Copyright © 2020 WeirdPan. All rights reserved.
//

import Foundation
/*
 笔记：
 在某种程度上，无向图是双向的有向图
 链表和树是图的简化版本
 
 */
// Thanks to raywenderlich:
//https://www.raywenderlich.com/773-swift-algorithm-club-graphs-with-adjacency-list

//MARK:邻接列表 — 顶点
public struct Vertex<T: Hashable> {
    var data: T
}
extension Vertex: Hashable {
    //为了实现可散列一致性，您必须提供一个hashValue属性
    public var hashValue: Int { // 1
        return "\(data)".hashValue
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)

    }
    static public func ==(lhs: Vertex, rhs: Vertex) -> Bool { // 2
        return lhs.data == rhs.data
    }
}
extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(data)"//验证您的邻接表
    }
}



//MARK:邻接列表 — 边
public enum EdgeType {
    //有向路径还是无向路径
    case directed, undirected
}
//一条边包含两个顶点
public struct Edge<T: Hashable> {
    public var source: Vertex<T> // 源顶点，可以理解成某个城市的机场
    public var destination: Vertex<T>//目的顶点
    public let weight: Double? // 权重数值，可以理解成东京到新加坡的机票价格
}
extension Edge: Hashable {
    
    public var hashValue: Int {
        return "\(source)\(destination)\(String(describing: weight))".hashValue
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
        hasher.combine(weight)
    }
    static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}







//MARK:邻接列表 — 图
protocol Graphable {
    associatedtype Element: Hashable // 1
    var description: CustomStringConvertible { get } // 打印出图形的内容
    
    func createVertex(data: Element) -> Vertex<Element> // 创建顶点
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) // 在两个顶点之间添加边, 您可以指定权重以及边是有向还是无向
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? // 获取两个顶点之间的边的权重
    func edges(from source: Vertex<Element>) -> [Edge<Element>]? // 源顶点连接到的所有边
}


open class AdjacencyList<T: Hashable> {
    //保存图表，key是顶点，value是边
    public var adjacencyDict : [Vertex<T>: [Edge<T>]] = [:]
    public init() {}
}
extension AdjacencyList: Graphable {
    
    
    public typealias Element = T
//    public typealias Element = T

    
    fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight) // 1
        adjacencyDict[source]?.append(edge) // 2
    }
    //将无向图视作双向的有向图
    fileprivate func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }

    
    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data)
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []//初始化边缘数组并返回顶点
        }
        return vertex
    }

    //检查类型是有向还是无向，并创建正确的边
    public func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }

    
    
    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        guard let edges = adjacencyDict[source] else { // 1 从源顶点检索所有边,如果没有边，则返回nil
            return nil
        }
        
        for edge in edges { // 2
            if edge.destination == destination { // 3 检查是否是通向目标顶点的边
                return edge.weight
            }
        }
        
        return nil // 4
    }

    
    public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return adjacencyDict[source]
    }
    //打印出顶点，以及它通过一条边连接的所有顶点
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ] \n ")
        }
        return result
    }

}





class PPAdjacencyListTest : NSObject {
    let adjacencyList = AdjacencyList<String>()
    
    func test() {
        //下面的代码使用邻接表创建航班网络定价图
        let singapore = adjacencyList.createVertex(data: "Singapore")
        let tokyo = adjacencyList.createVertex(data: "Tokyo")
        let hongKong = adjacencyList.createVertex(data: "Hong Kong")
        let detroit = adjacencyList.createVertex(data: "Detroit")
        let sanFrancisco = adjacencyList.createVertex(data: "San Francisco")
        let washingtonDC = adjacencyList.createVertex(data: "Washington DC")
        let austinTexas = adjacencyList.createVertex(data: "Austin Texas")
        let seattle = adjacencyList.createVertex(data: "Seattle")
        
        adjacencyList.add(.undirected, from: singapore, to: hongKong, weight: 300)
        adjacencyList.add(.undirected, from: singapore, to: tokyo, weight: 500)
        adjacencyList.add(.undirected, from: hongKong, to: tokyo, weight: 250)
        adjacencyList.add(.undirected, from: tokyo, to: detroit, weight: 450)
        adjacencyList.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
        adjacencyList.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
        adjacencyList.add(.undirected, from: detroit, to: austinTexas, weight: 50)
        adjacencyList.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
        adjacencyList.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
        adjacencyList.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
        adjacencyList.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
        adjacencyList.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
        
        debugPrint(adjacencyList.description)
        //实际问题
        //Q:How much does a ticket cost from Singapore to Tokyo?
        debugPrint("\(String(describing: adjacencyList.weight(from: singapore, to: tokyo)))")
        //Q:What are the flights going out of San Francisco?
        if let flightsFromSanFrancisco = adjacencyList.edges(from: sanFrancisco) {
            print("San Francisco Out Going Flights:")
            print("--------------------------------")
            for edge in flightsFromSanFrancisco {
                print("from: \(edge.source) to: \(edge.destination)")
            }
        }
    }

}





/*
class PPGraph : NSObject {
    private var v : Int? // 顶点的个数
    private var adj : PPLinkedList? // 邻接表
    
    func Graph(v : Int) {
        self.v = v
        let head = PPLinkedListNode(0)
        adj = PPLinkedList(head: head)
        for _ in 0...v {
//            PPLinkedList.initNNode(value: 1, count: 1)
        }
    }
}


extension PPLinkedList {
    /// 创建`count`个值等于`value`的链表
    fileprivate class func initNNode(value:Int,count:Int) -> PPLinkedList {
        let head = PPLinkedListNode(value)
        let linkedList = PPLinkedList(head: head)
        for _ in 0...count-2 {
            linkedList.pp_appendNode(value)
        }
        return linkedList
    }
}
*/
