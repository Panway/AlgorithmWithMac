//
//  PPStackOrQueue.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/11/5.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation
/// 用栈实现队列
///
/// 出列(dequeue)过程(假设左边是顶部，之前一次放入3、2、1)：
/// 用文字总结：首先如果栈B没有元素的话，将栈A的元素倒入栈B，然后取出栈B顶部的元素
///
///     A:[1,2,3] B:[     ]
///     A:[  2,3] B:[    1]
///     A:[    3] B:[  2,1]
///     A:[     ] B:[3,2,1]
///     A:[     ] B:[  2,1]//取出栈B顶部的元素

struct MyQueue {
    var stackA: PPIntegerStack
    var stackB: PPIntegerStack
    
    var isEmpty: Bool {
        return stackA.isEmpty
    }
    
    var peek: Any? {
        mutating get {
            shift()
            return stackB.peek
        }
    }
    
    var size: Int {
        get {
            return stackA.size + stackB.size
        }
    }
    
    init() {
        stackA = PPIntegerStack()
        stackB = PPIntegerStack()
    }
    
    mutating func enqueue(_ object: Any) {
        stackA.push(object as! PPIntegerStack.Element);
    }
    
    mutating func dequeue() -> Any? {
        shift()
        return stackB.pop();
    }
    
    fileprivate mutating func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!);
            }
        }
    }
}

// 用队列实现栈
struct MyStack {
    var queueA: PPIntegerQueue
    var queueB: PPIntegerQueue
    
    init() {
        queueA = PPIntegerQueue()
        queueB = PPIntegerQueue()
    }
    
    var isEmpty: Bool {
        return queueA.isEmpty
    }
    
    var peek: Any? {
        mutating get {
            if isEmpty {
                return nil
            }
            
            shift()
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            swap()
            return peekObj
        }
    }
    
    var size: Int {
        return queueA.size
    }
    
    mutating func push(object: Any) {
        queueA.enqueue(object as! PPIntegerQueue.Element)
    }
    
    mutating func pop() -> Any? {
        if isEmpty {
            return nil
        }
        
        shift()
        let popObject = queueA.dequeue()
        swap()
        return popObject
    }
    
    private mutating func shift() {
        while queueA.size > 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
    
    private mutating func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
}
