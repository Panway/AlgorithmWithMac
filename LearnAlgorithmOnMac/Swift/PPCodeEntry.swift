//
//  PPCodeEntry.swift
//  AlgorithmWithMac
//
//  Created by panwei on 2019/10/28.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation


open class PPCodeEntry : NSObject {
    public override init() {
        
    }
    
    @objc open func printLog() -> Void {
        print("Swft算法入口")
//        let aaa = ValidParentheses.init()
//        aaa.isValid("{[]}")
        
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
        
        
//        let tree = PPSearchTree.init(rootNode: nil)
//        tree.pp_insertNodes([10,7,12,3,9,11,1,4,8,2,5])
//        let array = tree.pp_levelTraverse(root: tree.rootNode)
//        print(array)
        
        let sortDemo = PPSortDemo.init()
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
        merge(meetingTimes: [time1,time2,time3])
    }
}
