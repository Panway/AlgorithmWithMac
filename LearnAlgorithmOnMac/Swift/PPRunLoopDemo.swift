//
//  PPRunLoopDemo.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/12/27.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation
import AppKit

class PPRunLoopDemo: NSObject {
    func forLoopWithoutAutoReleasePool() {
        //10000次循环Memory 从 10.9MB 变成 14.8MB，100000次循环会从43MB变28MB
        for i in 0...100000 {
            let view = NSView()
        }
        
        //        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, { (observer, activity) in
        //            switch activity {
        //            case .entry:
        //                print("进入RunLoop");
        //            case .beforeTimers:
        //                print("即将处理Timer事件");
        //            case .beforeSources:
        //                print("即将处理Source事件");
        //            case .beforeWaiting:
        //                print("即将休眠");
        //            case .afterWaiting:
        //                print("被唤醒");
        //            case .exit:
        //                print("退出RunLoop");
        //            default:
        //                break;
        //            }
        //        })
        //        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .commonModes)
    }
    func forLoopWithAutoReleasePool() {
        //10000次循环Memory 从 10.9MB 变成 13.8MB，100000次循环会从43MB变16MB
        for i in 0...10000 {
            autoreleasepool {
                let view = NSView()
            }
        }
    }
    
    
    
    
    
    
    
    
}
