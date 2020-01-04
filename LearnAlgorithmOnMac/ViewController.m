//
//  ViewController.m
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/11/13.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

#import "ViewController.h"
#import "PPTicketSeller.h"
@interface ViewController ()
{
    NSInteger _totalTicket;
}
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTextView *text = [[NSTextView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    text.string = @"PPDemo Hub";
    [self.view addSubview:text];
    
    
//    [self testTicketSeller];
}


- (void)testTicketSeller {
    PPTicketSeller *seller = [PPTicketSeller new];
    [seller moneyTest];
    
    
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
