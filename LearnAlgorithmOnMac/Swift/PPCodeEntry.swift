//
//  PPCodeEntry.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/28.
//  Copyright © 2019 WeirdPan. All rights reserved.
//  3400Star https://github.com/soapyigu/LeetCode-Swift

import Foundation


open class PPCodeEntry : NSObject {
    public override init() {
        
    }
    
    @objc open func testCaseEntrance() -> Void {
        debugPrint("Swft算法测试用例入口")
        self.testHasCycle()
//        let a = PPSearchAlgorithm()
//        a.testDepthFirstSearch()
//        let ppRunLoopDemo = PPRunLoopDemo.init()
//        ppRunLoopDemo.forLoopWithAutoReleasePool()
//        ppRunLoopDemo.forLoopWithoutAutoReleasePool()
//        PPSinglyLinkedList.testReverseLinkedList()
        
        return
    }
    func testDemo() {
        
        let solution = PPSolution()
//        solution.testMinimumTotal()
        solution.testLengthOfLongestSubstring()

        
//        // 用栈实现队列
//        var myQueue : MyQueue = MyQueue.init()
//        myQueue.enqueue(1)
//        myQueue.enqueue(2)
//        myQueue.enqueue(3)
//        myQueue.dequeue()
//        myQueue.enqueue(4)
//        myQueue.enqueue(5)
//        myQueue.dequeue()
        
//        // 用数组实现队列
//        var queue = PPIntegerQueue.init()
//        queue.enqueue(1)
//        queue.enqueue(2)
//        queue.enqueue(3)
//        queue.dequeue()
//        queue.enqueue(4)
//        queue.enqueue(5)
//        queue.dequeue()
        
//        let aaa = FirstMissingPositive.firstMissingPositive([1,1,-2,3,4])
        
//        ThreeSum.threeSum(nums: [1,-2+3,3,-1+3,2,0+1,4], target: 0)
        
//        let res = MajorityElement.majorityElement([1,3,2,3,2,4]);
        
//        let list1 = PPSinglyLinkedList.init(head: PPLinkedListNode(1))
//        list1.pp_appendNode(3)
//        list1.pp_appendNode(5)
//        let list2 = PPSinglyLinkedList.init(head: PPLinkedListNode(2))
//        list2.pp_appendNode(4)
//        list2.pp_appendNode(6)
//        //合并
//        let merge1 = list1.head?.mergeSortedLists(list2.head!)
        
//        let mergedList = list1.pp_mergeTwoOrderedLinkList(list1: list1, list2: list2)
//
//        let ppPPStackDemo = PPStackDemo.init()
//        ppPPStackDemo.simplifyPath(path: "/a/b/./../d/")
//
//        let ppPPArrayDemo = PPArrayDemo.init()
//        let ppPPArrayDemoR = ppPPArrayDemo.reverseWords(s: "swift")
//        print(ppPPArrayDemoR)
//        let headPoint = PPLinkedListNode(1)
//
//        let ppLinkList = PPSinglyLinkedList.init(head: headPoint)
//        ppLinkList.pp_appendNode(6)
//        ppLinkList.pp_appendNode(4)
//        ppLinkList.pp_appendNode(2)
//        ppLinkList.pp_appendNode(5)
//        ppLinkList.pp_appendNode(3)
//        ppLinkList.removeNthFromEnd(head: headPoint, 3)
//        print(ppLinkList)
//        let res = ppLinkList.partition(headPoint, 4)
//        let aaa = ppLinkList.getLeftList(headPoint, 4)
//        let longestPalindromicSubstringObj = LongestPalindromicSubstring.init()
//        let longestPalindromicSubstring = longestPalindromicSubstringObj.longestPalindrome("iambabygirl")
        
        
        // MARK: Tree
        //        let node3 = node
        //图片辅助理解： https://i.loli.net/2019/11/24/Q8Rn3lEk5fx4qgB.png
        //https://i.loli.net/2019/11/08/EXNtZ7FOAI1mBWU.png
        let tree = PPSearchTree()
//        tree.pp_insertNodes([20,13,34,25,17,7,36])
//        tree.pp_insertNodes([33,16,50,13,18,34,58,15,17,25,51,66,19,27,55])//https://static001.geekbang.org/resource/image/29/2c/299c615bc2e00dc32225f4d9e3490e2c.jpg
        
        
        tree.pp_insertNodes([33,16,50,13])
        tree.pp_insertNodes([18,34,58,15])
        let pNode = PPSearchTreeNode(17)
        tree.pp_insertNode(pNode)
        tree.pp_insertNodes([25,51,66,19,27])
        let qNode = PPSearchTreeNode(55)
        tree.pp_insertNode(qNode)
        let lowestAncestor = tree.lowestCommonAncestor(root: tree.rootNode!, p: pNode, q: qNode)
        debugPrint(lowestAncestor as Any)//二叉树的最近公共祖先
        
        
        //tree.pp_deleteNode(13)
        debugPrint("is valid tree ? \(PPTreeSolution().isValidBST(tree.rootNode))")
//        tree.pp_insertNodes([20,13,34,25,17,7,29,15,8,32,24,6,36,19,21,12,16,14,18])
//        let array = tree.levelOrder(root: tree.rootNode)
//        print(array)
        
//        let sortDemo = PPSortDemo.init()
//        sortDemo.insetSort(numsArray: [3,1,5,2,4])
        
//        let mergeSortRes = sortDemo.pp_fastSort([3,1,5,2,4])
//        let quickSort = sortDemo.pp_quickSort([7,9,6,1,8,4,1,5,2,3])
//        print("quickSort\(quickSort)")
        
//        let binarySearch = sortDemo.pp_binarySearchRecursively([1,2,3,4,5,6,7,8,9,11],1)
        
//        let binarySearch = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],2)
//        let binarySearch3 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],3)
//        let binarySearch4 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],22)
//        let binarySearch5 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],5)
//        let binarySearch6 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],6)
//        let binarySearch7 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],7)
//        let binarySearch8 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],8)
//        let binarySearch9 = sortDemo.pp_binarySearch([1,2,3,4,5,6,7,8,9,11],9)
//        print("binarySearch\(binarySearch9)")
        
//        subarraySum([3,1,2,5,2,6,2,8,1,7,3,6,4,9], 10)
        let time1 = MeetingTime.init(3, 5)
        let time2 = MeetingTime.init(3, 6)
        let time3 = MeetingTime.init(4, 7)
        let result = merge(meetingTimes: [time1,time2,time3])
        debugPrint(result)
    }
    //LeetCode23 测试用例
    func testMergeKLists() {
        let link = PPSinglyLinkedList([1,4,5])
        let link2 = PPSinglyLinkedList([1,3,4])
        let link3 = PPSinglyLinkedList([2,6])
        
        let new = link.mergeKLists([link.head,link2.head,link3.head])
        debugPrint(new ?? "")
    }
    //LeetCode53
    func testMaxSubArray() {
        let sss = PPSolution.maxSubArray2([-12,3,6,9,1,-9,0,8,7,9,-3])
        debugPrint(sss)
        let aaa = PPSolution.maxSubArray2([-2,1,-3,4,-1,2,1,-5,4])
        debugPrint(aaa)
        let bbb = PPSolution.maxSubArray2([-9,-1,-2,-3])
        debugPrint(bbb)
    }
    /// PPLeetCode141 给定一个链表，判断链表中是否有环(检测是否是环形链表)
    func testHasCycle() {
        let list = PPSinglyLinkedList([3,2,0,4])
        let last = list.tail
        last?.next = list.head?.next
        let hasCycle = list.hasCycle(list.head)
        debugPrint(hasCycle)
    }
}
