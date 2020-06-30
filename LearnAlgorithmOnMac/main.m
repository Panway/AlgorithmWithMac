//
//  main.m
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/11/13.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import <LearnAlgorithmOnMac-Swift.h>
#import <Foundation/Foundation.h>


int main(int argc, const char * argv[]) {
    
    PPCodeEntry *link = [[PPCodeEntry alloc] init];
    [link testCaseEntrance];
    
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    
    NSLog(@"WARNING: `exit(0);` will exit app without start");
#warning exit app without start 不启动App
    exit(0);
    
    return NSApplicationMain(argc, argv);
}
