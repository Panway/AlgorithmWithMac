//
//  main.m
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/11/13.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <LearnAlgorithmOnMac-Swift.h>
#import <Foundation/Foundation.h>
//struct BinaryTreeNode {
//    int val;
//    BinaryTreeNode left;
//    BinaryTreeNode right;
//};

//void preOrder(struct BinaryTreeNode root) {
////    if (root == NULL) return;
//    printf("%s", root); // 此处为伪代码，表示打印 root 节点
//    preOrder(root.left);
//    preOrder(root.right);
//}


int main(int argc, const char * argv[]) {
    const char *testStr = "iambabygirl";
    LongestPalindrome(testStr, strlen(testStr));
    PPCodeEntry *link = [[PPCodeEntry alloc] init];
    [link printLog];
    //---------------断点-----------------
    NSLog(@"====");
//    struct BinaryTreeNode root1={
//        1,NULL,NULL};
//    root1->val = 1;
//    preOrder(root1);
//    main_linkTable1();
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    
    NSLog(@"exit app without start");
#warning exit app without start 不启动App
    exit(0);
    
    return NSApplicationMain(argc, argv);
}
