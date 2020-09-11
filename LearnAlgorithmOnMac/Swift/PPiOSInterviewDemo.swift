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
    //class用
    init(name:String) {
        self.name = name
    }
}

class PersonClass {
    var name = "unknown"
    var jobStruct : JobStruct?
    var jobClass : JobClass?
    
    func makeFood() {
        print("Cook Seafood")
    }
    //class用
    init(name:String) {
        self.name = name
    }
}

struct PersonStruct {
    var name = "unknown"
    var jobStruct : JobStruct?
    var jobClass : JobClass?
}


class PandaClass:NSObject {
    var name = "unknown"
    init(name:String) {
        self.name = name
    }
    override init () {
        super.init()
    }
}
class PPiOSInterviewDemo {
    class func demo() {
        
    }
    /// 值类型和引用类型的区别（用结构体和类来当例子区别）
    /// LLDB控制台打印内存地址：frame var -L 你的变量
    /// https://zhuanlan.zhihu.com/p/63186927
    /// 终极总结：引用类型不管是否嵌套，赋值后也都只在内存里有一份
    class func class_vs_Struct() {
        //字符串类型(值类型)
        var str_Baker = "Baker"
        let str_Baker2Coder = str_Baker
        str_Baker = "Coder"
        debugPrint("\(str_Baker) and \(str_Baker2Coder)")//Coder and Baker
        
        //引用类型套引用类型1
        let c_Baker = JobClass(name: "Baker")
        let c_Baker2Coder = c_Baker
        c_Baker.name = "Coder"
        debugPrint("\(c_Baker.name ) and \(c_Baker2Coder.name )")//Coder and Coder
        
        //引用类型套引用类型2
        let c_Dancer = PersonClass(name: "Dancer")
        c_Dancer.jobClass = JobClass(name: "Dancer")
        let c_Dancer2Editor = c_Dancer
        c_Dancer.jobClass = JobClass(name: "Editor")
        debugPrint("\(c_Dancer.jobClass?.name ?? "") and \(c_Dancer2Editor.jobClass?.name ?? "")")//Editor and Editor
        
        
        
        var personA = PersonStruct(name: "Alice")
        var personB = PersonStruct(name: "Bob")
        var cook_s = JobStruct(name: "cook")
        let cook_c = JobClass(name: "c_cook")
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
        array[0].name = "Alice new"
        debugPrint(array.map{$0.name})
        var p2 = array[1]
        p2.name = "Bob new"
        debugPrint(array.map{$0.name})
        debugPrint(array2.map{$0.name})
        debugPrint("--- end ---")
        /*如果 personA personB是类：
         "--- start ---"
         ["Alice", "Bob"]
         ["Alice new", "Bob"]
         ["Alice new", "Bob new"]
         ["Alice new", "Bob new"]
         "--- end ---"
         
         如果 personA personB是结构体：
         "--- start ---"
         ["Alice", "Bob"]
         ["Alice new", "Bob"]
         ["Alice new", "Bob"]
         ["Alice", "Bob"]
         "--- end ---"
         */
        
        // 引用类型套值类型
        let playboy = PersonClass(name: "playboy")
        var playboyjob = JobStruct()
        playboy.jobStruct = playboyjob
        playboyjob.name = "playboy job new"
        debugPrint(playboy.jobStruct?.name ?? "")
        //结论：嵌套的值类型实例赋值给其他变量后，就算修改它不会变
        
        // 值类型套引用类型
        var xuxian = PersonStruct(name: "许仙")
        var xuxian2 = xuxian
        let xuxianjob = JobClass(name: "doctor")
        xuxian.jobClass = xuxianjob
        xuxianjob.name = "救白素贞"
        debugPrint(xuxian.jobClass?.name ?? "")
        //结论：嵌套的值类型实例赋值给其他变量后，修改就会变
        debugPrint("-----END-----")
        
        
        
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
