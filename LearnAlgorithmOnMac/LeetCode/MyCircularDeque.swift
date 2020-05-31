//
//  MyCircularDeque.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2020/5/30.
//  Copyright © 2020 WeirdPan. All rights reserved.
//

import Cocoa
//PPCategory:Queue Array
//MARK: PPLeetCode641 循环双端队列(环形队列)
//题目：https://leetcode-cn.com/problems/design-circular-deque/
//解决方法：https://leetcode-cn.com/problems/design-circular-deque/solution/shu-zu-shi-xian-de-xun-huan-shuang-duan-dui-lie-by/
// 1、不用设计成动态数组，使用静态数组（固定容量的数组）即可
// 2、设计 head 和 tail 指针变量（整型）
// 3、head == tail 成立的时候表示队列为空
// 4、tail + 1 == head

class MyCircularDeque {
    let capacity:Int!
    var arr:[Int]!
    var front:Int!
    var rear:Int!
    
    /** 初始化数据结构。将双端队列的大小设置为k. */
    init(_ k: Int) {
        //数组大小是给定大小+1，因为rear所指向的位置始终是空的
        capacity = k + 1
//        self.arr.reserveCapacity(capacity)
        arr = Array(repeating: 0, count: capacity)//初始化某个容量的数组
        // 头部指向第 1 个存放元素的位置
        // 插入时，先减，再赋值
        // 删除时，索引 +1（注意取模）
        front = 0
        // 尾部指向下一个插入元素的位置
        // 插入时，先赋值，再加
        // 删除时，索引 -1（注意取模）
        rear = 0
    }
    
    /** 将一个元素添加到双端队列(Deque)头部。 如果操作成功返回 true */
    func insertFront(_ value: Int) -> Bool {
        if (isFull()) {
            return false
        }
        front = (front - 1 + capacity) % capacity
        arr[front] = value
        return true
    }
    
    //@discardableResult
    /** 将一个元素添加到双端队列尾部。如果操作成功返回 true */
    func insertLast(_ value: Int) -> Bool {
        if (isFull()) {
            return false
        }
        arr[rear] = value
        rear = (rear + 1) % capacity
        return true
    }
    
    /** 从双端队列头部删除一个元素。 如果操作成功返回 true. */
    func deleteFront() -> Bool {
        if (isEmpty()) {
            return false
        }
        // front 被设计在数组的开头，所以是 +1
        front = (front + 1) % capacity
        return true
    }
    
    /** 从双端队列尾部删除一个元素。如果操作成功返回 true. */
    func deleteLast() -> Bool {
        if (isEmpty()) {
            return false
        }
        // rear 被设计在数组的末尾，所以是 -1
        rear = (rear - 1 + capacity) % capacity
        return true
    }
    
    /** 从双端队列头部获得一个元素。如果双端队列为空，返回 -1 */
    func getFront() -> Int {
        if (isEmpty()) {
            return -1
        }
        return arr[front]
    }
    
    /** 获得双端队列的最后一个元素。 如果双端队列为空，返回 -1 */
    func getRear() -> Int {
        if (isEmpty()) {
            return -1
        }
        // 当 rear 为 0 时防止数组越界
        return arr[(rear - 1 + capacity) % capacity]
    }
    
    /** 检查双端队列是否为空。 */
    func isEmpty() -> Bool {
        return front == rear
    }
    
    /** 检查双端队列是否满了 */
    func isFull() -> Bool {
        // 注意：这个设计是非常经典的做法
        return (rear + 1) % capacity == front
    }
    
    
    func testMyCircularDeque() {
        /*
        let deque = MyCircularDeque(8)
        let ret_1: Bool = deque.insertLast(10)
        deque.insertLast(20)
        deque.insertLast(30)
        deque.insertLast(40)
        deque.insertLast(50)
        deque.deleteLast()
        deque.deleteLast()
        deque.deleteFront()
        deque.insertLast(60)
        deque.insertLast(70)
        deque.insertLast(80)
        deque.insertLast(90)
        deque.deleteFront()
        deque.insertLast(100)
        deque.insertLast(110)
        deque.insertLast(120)
        let res = deque.insertLast(130)
     */
    }
}

/**
 * Your MyCircularDeque object will be instantiated and called as such:
 * let obj = MyCircularDeque(k)
 * let ret_1: Bool = obj.insertFront(value)
 * let ret_2: Bool = obj.insertLast(value)
 * let ret_3: Bool = obj.deleteFront()
 * let ret_4: Bool = obj.deleteLast()
 * let ret_5: Int = obj.getFront()
 * let ret_6: Int = obj.getRear()
 * let ret_7: Bool = obj.isEmpty()
 * let ret_8: Bool = obj.isFull()
 */

