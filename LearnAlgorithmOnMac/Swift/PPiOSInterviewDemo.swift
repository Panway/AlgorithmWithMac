//
//  PPRunLoopDemo.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/12/27.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation
import AppKit

//类和结构体的区别
struct JobStruct {
    var name = "unknown"
    var duration = 1
}
class JobClass {
    var name = "unknown"
    var duration = 1
}

//class PersonClass {
struct PersonClass {
    var name = "unknown"
    var jobStruct : JobStruct?
    var jobClass : JobClass?

    func makeFood() {
        print("Cook Seafood")
    }
    func testPerson() {
    }
    //class用
    init(name:String) {
        self.name = name
    }
}



class PPiOSInterviewDemo {
    class func demo() {
        
    }
    class func class_vs_Struct() {
        var personA = PersonClass(name: "Alice")
        var personB = PersonClass(name: "Bob")
        var cook_s = JobStruct(name: "cook")
        let cook_c = JobClass()
        cook_c.name = "cook"
        
        personA.jobStruct = cook_s
        personB.jobStruct = cook_s
        cook_s.name = "cook 666"
        debugPrint("\(personA.jobStruct?.name ?? "") \(personB.jobStruct?.name ?? "")")
        
        personA.jobClass = cook_c
        personB.jobClass = cook_c
        cook_c.name = "teacher 666"
        debugPrint("name : \(personA.jobClass?.name ?? "") \(personB.jobClass?.name ?? "")")
        personA.jobClass?.name = "teacher 999"
        debugPrint("name : \(personA.jobClass?.name ?? "") \(personB.jobClass?.name ?? "")")

        debugPrint("--- start ---")
        var array = [personA,personB]
        debugPrint(array.map{$0.name})
        let array2 = array
        array[0].name = "new A"
        debugPrint(array.map{$0.name})
        var p2 = array[1]
        p2.name = "new B"
        debugPrint(array.map{$0.name})
        debugPrint(array2.map{$0.name})
        debugPrint("--- end ---")
        /*如果 personA personB是类：
         "--- start ---"
         ["Alice", "Bob"]
         ["new A", "Bob"]
         ["new A", "new B"]
         ["new A", "new B"]
         "--- end ---"
         
         如果 personA personB是类：
         "--- start ---"
         ["Alice", "Bob"]
         ["new A", "Bob"]
         ["new A", "Bob"]
         ["Alice", "Bob"]
         "--- end ---"
         */
    }
    
    func forLoopWithoutAutoReleasePool() {
        //10000次循环Memory 从 10.9MB 变成 14.8MB，100000次循环会从43MB变28MB
//        for i in 0...100000 {
//            let view = NSView()
//        }
        
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
//        for i in 0...10000 {
//            autoreleasepool {
//                let view = NSView()
//            }
//        }
    }
    
    
    
    
    
    
    
    
}
