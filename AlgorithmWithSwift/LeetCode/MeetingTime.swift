//
//  MeetingTime.swift
//  AlgorithmWithSwift
//
//  Created by panwei on 2019/11/9.
//  Copyright © 2019 WeirdPan. All rights reserved.
// 已知有很多会议，如果有这些会议时间有重叠，则将它们合并。
// 比如有一个会议的时间为 3 点到 5 点，另一个会议时间为 4 点到 6 点，那么合并之后的会议时间为 3 点到6点

import Foundation


public class MeetingTime {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}



func merge(meetingTimes: [MeetingTime]) -> [MeetingTime] {
    // 处理特殊情况
    guard meetingTimes.count > 1 else {
        return meetingTimes
    }
    var meetingTimesArray:Array<MeetingTime> = meetingTimes
    // 排序
    meetingTimesArray = meetingTimesArray.sorted() {
        if $0.start != $1.start {
            return $0.start < $1.start
        } else {
            return $0.end < $1.end
        }
    }
    
    // 新建结果数组
    var res = [MeetingTime]()
    res.append(meetingTimesArray[0])
    
    // 遍历排序后的原数组，并与结果数组归并
    for i in 1..<meetingTimesArray.count {
        let last = res[res.count - 1]
        let current = meetingTimesArray[i]
        if current.start > last.end {
            res.append(current)
        } else {
            last.end = max(last.end, current.end)
        }
    }
    
    return res
}
