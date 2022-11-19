//
//  PPMethodExchange.h
//  LearnAlgorithmOnMac
//
//  Created by Panway on 2022/11/18.
//  Copyright © 2022 Panway. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPMethodExchange : NSObject
/// 交换方法内部实现
- (void)testExchangeImplementations;
/// 替换方法
- (void)testReplaceMethod;
/// 新增方法
- (void)testAddMethod;
@end

@interface PPMethodExchangeClassA : NSObject
- (void)printA;
@end

@interface PPMethodExchangeClassB : NSObject
- (void)printB;
@end
NS_ASSUME_NONNULL_END
