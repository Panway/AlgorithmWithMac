//
//  PPStackDemo.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/2.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation


//class PPStack: NSObject {
//
//}
protocol PPStack {
  /// 持有的元素类型
  associatedtype Element

  /// 是否为空
  var isEmpty: Bool { get }
  /// 栈的大小
  var size: Int { get }
  /// 栈顶元素
  var peek: Element? { get }

  /// 进栈
  mutating func push(_ newElement: Element)
  /// 出栈
  mutating func pop() -> Element?
}

struct PPIntegerStack: PPStack {
  typealias Element = Int

  var isEmpty: Bool { return stack.isEmpty }
  var size: Int { return stack.count }
  var peek: Element? { return stack.last }

  private var stack = [Element]()

  mutating func push(_ newElement: Element) {
    stack.append(newElement)
  }

  mutating func pop() -> Element? {
    return stack.popLast()
  }
}


class PPStackDemo: NSObject {
    func simplifyPath(path: String) -> String {
      // 用数组来实现栈的功能
      var pathStack = [String]()
      // 拆分原路径
      let paths = path.components(separatedBy: "/")
           
      for path in paths {
        // 对于 "." 我们直接跳过
        guard path != "." else {
          continue
        }
        // 对于 ".." 我们使用pop操作
        if path == ".."  {
          if (pathStack.count > 0) {
            pathStack.removeLast()
          }
        // 对于太注意空数组的特殊情况
        } else if path != "" {
          pathStack.append(path)
        }
      }
      // 将栈中的内容转化为优化后的新路径,等价于`"/"+pathStack.joined(separator: "/")`
      let res = pathStack.reduce("") { total, dir in "\(total)/\(dir)" }
     
      // 注意空路径的结果是 "/"
      return res.isEmpty ? "/" : res
    }
}
