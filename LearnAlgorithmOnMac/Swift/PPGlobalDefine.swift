//
//  PPGlobalDefine.swift
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/11/30.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

import Foundation


public func pplog(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) {
    print("\(message) called from \(function) \(file):\(line)")
}
