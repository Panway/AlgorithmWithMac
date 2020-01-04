//
//  PPTicketSeller.h
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/12/20.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPTicketSeller : NSObject

- (void)ticketSelling;
- (void)ticketSellingWithSynchronized;
- (void)ticketSellingWithNSLock;
- (void)testTicketSelling;

- (void)moneyTest;
@end

NS_ASSUME_NONNULL_END
