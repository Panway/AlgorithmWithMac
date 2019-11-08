//
//  AppDelegate.swift
//  AlgorithmWithSwift
//
//  Created by panwei on 2019/11/8.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let entrance = PPCodeEntry.init()
        entrance.printLog()
//        exit(5333)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

