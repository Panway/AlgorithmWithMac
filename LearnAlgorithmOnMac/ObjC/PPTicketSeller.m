//
//  PPTicketSeller.m
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/12/20.
//  Copyright © 2019 WeirdPan. All rights reserved.
//  模拟售票 -- 线程安全的加锁操作

#import "PPTicketSeller.h"
@interface PPTicketSeller ()
{
    NSInteger _leftTicket;///< 剩余票数
    NSLock *_lock;
}
@property (nonatomic) int money;
@property (strong, nonatomic) dispatch_semaphore_t moneySemaphore;

@end


@implementation PPTicketSeller

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _elements = [NSMutableArray array];
        _leftTicket = 1000;
        _lock = [[NSLock alloc] init];
        self.moneySemaphore = dispatch_semaphore_create(1);

    }
    return self;
}

- (void)ticketSelling {
    if (_leftTicket > 0) {
        _leftTicket --;
    }
    printf("\nLeftTicket=%ld - %s",(long)_leftTicket,[[NSThread currentThread].description cStringUsingEncoding:NSUTF8StringEncoding]);
//    NSLog(@"LeftTicket=%ld",_leftTicket);
}
- (void)ticketSellingWithSynchronized {
    @synchronized (self) {
        [self ticketSelling];
    }
}

- (void)ticketSellingWithNSLock {
    [_lock lock];
    [self ticketSelling];
    [_lock unlock];
}

- (void)testTicketSelling {
    dispatch_queue_t queue = dispatch_queue_create("com.panda.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSInteger i = 0; i < 500; i ++) {
        dispatch_async(queue, ^{
            //        [NSThread sleepForTimeInterval:2];
            //            NSLog(@"dispatch_async1%@",[NSThread currentThread]);
            [self ticketSelling];
            
        });
        
    }
    
    for (NSInteger i = 0; i < 500; i ++) {
        dispatch_async(queue, ^{
            //        [NSThread sleepForTimeInterval:1];
            //            NSLog(@"dispatch_async2%@",[NSThread currentThread]);
            [self ticketSelling];
        });
        
    }

}



/**
 MARK:存钱、取钱演示
 */
- (void)moneyTest
{
    self.money = 100;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saveMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __drawMoney];
        }
    });
}
- (void)__drawMoney
{
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    
//    [super __drawMoney];
    sleep(.2);
    self.money -=20;
    
    dispatch_semaphore_signal(self.moneySemaphore);
    NSLog(@"-20元，还剩%d元 - %@", self.money, [NSThread currentThread]);

}

- (void)__saveMoney
{
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    
//    [super __saveMoney];
    sleep(.2);
    self.money += 10;
    
    dispatch_semaphore_signal(self.moneySemaphore);
    NSLog(@"+10元，还剩%d元 - %@", self.money, [NSThread currentThread]);

}


/**
 存钱
 */
- (void)__saveMoney2
{
//    int oldMoney = self.money;
    sleep(.2);
//    oldMoney += 10;
    self.money += 10;//= oldMoney;
    
    NSLog(@"存10元，还剩%d元 - %@", self.money, [NSThread currentThread]);
}

/**
 取钱
 */
- (void)__drawMoney2
{
//    int oldMoney = self.money;
    sleep(.2);
//    oldMoney -= 20;
    self.money -=20;//= oldMoney;
    
    NSLog(@"取20元，还剩%d元 - %@", self.money, [NSThread currentThread]);
}



@end
