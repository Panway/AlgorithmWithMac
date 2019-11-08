//
//  PPLinkList.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/28.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation

//链表的节点
class PPLinkedListNode: NSObject {
    var value: Int = 0
    var next : PPLinkedListNode?
    
    init(_ value:Int) {
        self.value = value
        self.next = nil
    }
    override var description : String {
        var node:PPLinkedListNode? = self
        var des : Array<String> = []
        while node != nil {
            des.append("\(node?.value ?? 0)")
            node = node?.next
        }
        return "Node \(des)"
    }
    //MARK:PPLeetCode21将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的
    //图例：L1=["1", "3", "5"] L2=["2", "4", "6"],虚拟节点dummy变化过程如下：
    //["0"] 此时p.next=L1可得到如下
    //["0", "1", "3", "5"] 此时L1的第一个元素"1"已经被我们利用了,所以要把L1变成["3", "5"]，即L1=L1.next，但是做这个操作之前要把L1缓存一下：p=L1，此时dummy=[0]+p,将p.next=L2可得到如下：
    //["0", "1", "2", "4", "6"]此时L2的第一个元素"2"已经被我们利用了,所以要把L2变成["4", "6"]，即L2=L2.next，但是做这个操作之前要把L2缓存一下：p=L2，此时dummy=[0]+p,将p.next=L2可得到如下：
    //["0", "1", "2", "3", "5"] 类似上面的操作，这里不赘述了
    //["0", "1", "2", "3", "4", "6"]
    //["0", "1", "2", "3", "4", "5", "6"]
    //时间复杂度：O(n + m) 空间复杂度：O(1)
    ///迭代法合并
    func mergeSortedLists(_ list: PPLinkedListNode) -> PPLinkedListNode? {
        let dummy = PPLinkedListNode(0)
        var p = dummy
        var l1: PPLinkedListNode? = self
        var l2: PPLinkedListNode? = list

        while l1 != nil && l2 != nil {
            if l1!.value < l2!.value {
                p.next = l1//dummy=[0]+[l1]
                p = l1!
                l1 = l1!.next
            } else {
                p.next = l2
                p = l2!
                l2 = l2!.next
            }
            print("dummy=\(dummy)")
        }

//        if l1 != nil {
//            p.next = l1!
//        } else if l2 != nil {
//            p.next = l2!
//        }
        p.next = l1 ?? l2
        print("dummy=\(dummy)")
        return dummy.next
    }
    
}






//MARK: 链表
open class PPLinkList: NSObject {
    var head:PPLinkedListNode?
    init(head:PPLinkedListNode) {
        self.head = head
    }
    ///添加新节点（数据）
    func pp_appendNode(_ newNodeValue:Int) {
        if self.head == nil {
            self.head = PPLinkedListNode.init(newNodeValue)
        }
        else {
            var node = self.head
            while node?.next != nil {
                node = node?.next
            }
            node?.next = PPLinkedListNode.init(newNodeValue)
        }
    }
    ///添加新节点
    func pp_appendNode(_ newNode:PPLinkedListNode)  {
        if self.head == nil {
            self.head = newNode
        }
        else {
            var node = self.head
            while node?.next != nil {
                node = node?.next
            }
            node?.next = newNode
        }
    }
    ///追加链表
    func pp_appendLinkList(_ newLinkList:PPLinkList) -> PPLinkList{
        //找最后一个节点
        var lastNode = self.head
        while lastNode?.next != nil {
            lastNode = lastNode?.next
        }
        //拼接两链表
        var node = newLinkList.head
        self.pp_appendNode(node!.value)
//        self.pp_appendNode(PPLinkedListNode(node?.value ?? 0))//后面的链表head拼接到前面的链表tail即可
        while node?.next != nil {
            node = node?.next
            if let nodeTmp = node {//安全检查真恶心啊
                self.pp_appendNode(nodeTmp.value)
            }
        }
        return self
    }
    ///第几个节点
    func nodeAtIndex(index:Int) -> PPLinkedListNode? {
        var node:PPLinkedListNode? = self.head
        for _ in 0..<index {
            if let nodeTmp = node?.next  {
                node = nodeTmp
            }
        }
        return node
    }
    override open var description : String {
            var node = self.head
            var des : Array<String> = []
            while node != nil {
    //            if node!.value < x {
                des.append("\(node?.value ?? 0)")
    //            }
                node = node!.next
            }
            return "PPLinkList \(des)"
        }
    override open class func description() -> String {
            return ""
        }
}

//MARK: 单向链表
class PPSinglyLinkedList: PPLinkList {
    var tail:PPLinkedListNode?
    // 别人的尾插法
     func appendToTail(_ val: Int) {
       if tail == nil {
         tail = PPLinkedListNode(val)
        self.head = tail
       } else {
         tail!.next = PPLinkedListNode(val)
         tail = tail!.next
       }
     }
    
     // 别人的头插法
     func appendToHead(_ val: Int) {
       if head == nil {
         head = PPLinkedListNode(val)
         tail = head
       } else {
         let temp = PPLinkedListNode(val)
         temp.next = head
         head = temp
       }
     }
    
    //举个例子，这里用❤️代表指针，小于3的值即1、2、2就是我们的目标
    //Node [❤️"1", "6", "4", ❤️"2", "5", ❤️"3"]
    //那么循环到数字2的时候把第一个指针的next指向第二颗星,链表就变成了
    //Node [❤️"1", ❤️"2", "5", ❤️"3"]
    func getLeftList(_ head: PPLinkedListNode?, _ x: Int) -> PPLinkedListNode? {
      let dummy = PPLinkedListNode(0)// Dummy 节点是虚拟的头前结点。我们引入它的原因是我们不知道要返回的新链表的头结点是哪一个
      var pre = dummy, node = head
     
      while node != nil {
        if node!.value < x {
            pre.next = node //dummy的next一直在变，但是dummy不会变（dummy是常量）
//            print(pre)
//            print("dummy=\(dummy)")
            pre = node!
//            print(pre)
//            print("dummy=\(dummy)")
//            print("\n")
        }
        node = node!.next
      }
     
      // 防止构成环
      pre.next = nil
      return dummy.next
    }
    //MARK:问题：给一个链表和一个值 x，要求将链表中所有小于 x 的值放到左边，所有大于等于 x 的值放到右边。原链表的节点顺序不能变。
    //例：1->5->3->2->4->2，给定x = 3。则我们要返回1->2->2->5->3->4
    //方法：先处理左边（比 x 小的节点），然后再处理右边（比 x 大的节点），最后再把左右两边拼起来（左边处理见getLeftList方法）。
    func partition(_ head: PPLinkedListNode?, _ x: Int) -> PPLinkedListNode? {
      // 引入Dummy节点
      let prevDummy = PPLinkedListNode(0), postDummy = PPLinkedListNode(0)
      var prev = prevDummy, post = postDummy
           
      var node = head
     
      // 用尾插法处理左边和右边
      while node != nil {
        if node!.value < x {
          prev.next = node
          prev = node!
        } else {
          post.next = node
          post = node!
        }
        node = node!.next
      }
     
      // 防止构成环
      post.next = nil
      // 左右拼接
      prev.next = postDummy.next
           
      return prevDummy.next
    }
    //MARK:问题：删除链表中倒数第 n 个节点
    //例：1->2->3->4->5，n = 2。返回1->2->3->5。 注意：给定 n 的长度小于等于链表的长度。
    //方法：两个指针移动速度相同。但是一开始，第一个指针prev（指向头结点之前）就落后第二个指针post n 个节点。接着两者同时移动，当第二个移动到尾节点时，第一个节点的下一个节点就是我们要删除的节点。
    // n=2时示例图如下：
    //[❤️"1", "2", ❤️"3", "6", "4", "5"]
    //["1", ❤️"2", "3", ❤️"6", "4", "5"]
    //["1", "2", ❤️"3", "6", ❤️"4", "5"]
    //["1", "2", "3", ❤️"6", "4", ❤️"5"]此时post.next=nil停止循环，让prev=prev.next.next即可删除节点
    func removeNthFromEnd(head: PPLinkedListNode?, _ n: Int) -> PPLinkedListNode? {
      guard let head = head else {
        return nil
      }
     
      let dummy = PPLinkedListNode(0)
      dummy.next = head
      var prev: PPLinkedListNode? = dummy
      var post: PPLinkedListNode? = dummy
     
      // 设置后一个节点初始位置
      for _ in 0 ..< n {
        if post == nil {
          break
        }
        post = post!.next
      }
     
      // 同时移动前后节点
      while post != nil && post!.next != nil {
        prev = prev!.next
        post = post!.next
      }
     
      // 删除节点
      prev!.next = prev!.next!.next
        
      return dummy.next
    }
//    https://leetcode-cn.com/problems/merge-two-sorted-lists/solution/he-bing-liang-ge-you-xu-lian-biao-by-leetcode/
    //MARK:PPLeetCode21将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的
    //示例：
    //输入：1->2->4, 1->3->4
    //输出：1->1->2->3->4->4
    //方法：递归地定义在两个链表里的 merge 操作（忽略边界情况，比如空链表等），递归公式如下：
    //如果list1[0]<list2[0]，那么 list1[0]+merge(list1[1:],list2)
    //否则list2[0]+merge(list1,list2[1:])
    //时间复杂度：O(n + m) 空间复杂度：O(n + m)
    //Tips:我这里取值list1[0]后，把head指针指到head.next就可以得到list1[1:]；递归到list1或list2剩一个元素的时候（list1.head?.next == nil），需要特殊处理，即拼接两个链表
    /// 递归法合并
    func pp_mergeTwoOrderedLinkList(list1:PPSinglyLinkedList, list2:PPSinglyLinkedList) -> PPSinglyLinkedList? {
        print("合并\(list1)\(list2)")
        if list1.head == nil && list2.head == nil {
            return nil//好像用不上
        }
        
        if let value1 = list1.head?.value,let value2 = list2.head?.value {
            if (value1 <  value2) {
                let oneNodeLinkList = PPSinglyLinkedList.init(head: PPLinkedListNode(value1))
                if list1.head?.next == nil {
                    return (list1.pp_appendLinkList(list2) as! PPSinglyLinkedList)
                }
                else {
                    list1.head = list1.head?.next
                    return (oneNodeLinkList.pp_appendLinkList(pp_mergeTwoOrderedLinkList(list1:list1, list2: list2)!) as! PPSinglyLinkedList)
                }
            }
            else {
                if list2.head?.next == nil {
                    return (list2.pp_appendLinkList(list1) as! PPSinglyLinkedList)
                }
                let oneNodeLinkList = PPSinglyLinkedList.init(head: PPLinkedListNode(value2))
                list2.head = list2.head?.next
                return (oneNodeLinkList.pp_appendLinkList(pp_mergeTwoOrderedLinkList(list1:list1, list2: list2)!) as! PPSinglyLinkedList)
            }
            
        }
        
        
        return nil
    
    }
    
    
    
    
}


