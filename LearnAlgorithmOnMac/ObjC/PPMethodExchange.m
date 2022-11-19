//
//  PPMethodExchange.m
//  LearnAlgorithmOnMac
//
//  Created by Panway on 2022/11/18.
//  Copyright © 2022 Panway. All rights reserved.
//

#import "PPMethodExchange.h"
#import <objc/runtime.h>

@implementation PPMethodExchange

/// replace method printA 's implementations for ClassA
- (void)testExchangeImplementations {
    Method originalMethod = class_getInstanceMethod(PPMethodExchangeClassA.class, @selector(printA));
    Method newMethod = class_getInstanceMethod(PPMethodExchangeClassB.class, @selector(printB));
    method_exchangeImplementations(originalMethod,newMethod);
    PPMethodExchangeClassA *a = [[PPMethodExchangeClassA alloc] init];
    PPMethodExchangeClassB *b = [[PPMethodExchangeClassB alloc] init];
    [a printA];//输出B
    [b printB];//输出A
}

/// replace method printA for ClassA
- (void)testReplaceMethod {
    Method newMethod = class_getInstanceMethod(PPMethodExchangeClassB.class, @selector(printB));
    class_replaceMethod(PPMethodExchangeClassA.class,
                        @selector(printA),
                        method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod));
    PPMethodExchangeClassA *a = [[PPMethodExchangeClassA alloc] init];
    [a performSelector:@selector(printA)];//输出B
}
/// add method printB for ClassA
- (void)testAddMethod {
    Method newMethod = class_getInstanceMethod(PPMethodExchangeClassB.class, @selector(printB));
    BOOL didAddMethod = class_addMethod(PPMethodExchangeClassA.class,
                                        @selector(printB),
                                        method_getImplementation(newMethod),
                                        method_getTypeEncoding(newMethod));
    NSLog(@"didAddMethod:%@",@(didAddMethod));
    PPMethodExchangeClassA *a = [[PPMethodExchangeClassA alloc] init];
    [a performSelector:@selector(printB)];//输出B
}
@end

@implementation PPMethodExchangeClassA

- (void)printA {
    NSLog(@"A");
}
@end

@implementation PPMethodExchangeClassB
- (void)printB {
    NSLog(@"B");
}
@end
