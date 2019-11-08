//
//  PPQueue.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/5.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation


protocol PPQueue {
  /// 持有的元素类型
  associatedtype Element

  /// 是否为空
  var isEmpty: Bool { get }
  /// 队列的大小
  var size: Int { get }
  /// 队首元素
  var peek: Element? { get }

  /// 入队
  mutating func enqueue(_ newElement: Element)
  /// 出队
  mutating func dequeue() -> Element?
}

struct PPIntegerQueue: PPQueue {
  typealias Element = Int

  var isEmpty: Bool { return left.isEmpty && right.isEmpty }
  var size: Int { return left.count + right.count }
  var peek: Element? { return left.isEmpty ? right.first : left.last }

  private var left = [Element]()
  private var right = [Element]()

  mutating func enqueue(_ newElement: Element) {
    right.append(newElement)
  }

  mutating func dequeue() -> Element? {
    if left.isEmpty {
      left = right.reversed()
      right.removeAll()
    }
    return left.popLast()
  }
}
