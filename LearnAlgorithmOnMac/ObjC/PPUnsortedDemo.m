//
//  PPUnsortedDemo.m
//  LearnAlgorithmOnMac
//
//  Created by panwei on 2019/11/30.
//  Copyright © 2019 WeirdPan. All rights reserved.
//

#import "PPUnsortedDemo.h"

@implementation PPUnsortedDemo
/*倒序字符串测试用例*/
- (void)testReverseString {
    char s1[9] = "abcdefghi";
    reverseString(s1, 9);
    int times=1, length=10;
    char *s = "abcdefghij";
    while (times >0){
        char t[length];
        for (int i = 0;i < length; i++){
            t[i] = *(s + arc4random()% 10);
        }
        reverseString(t, length);
        times--;
    }
}
/*倒序字符串*/
char* reverseString(char*s, int length) {
    if (length < 1){
        return s;
    }
    NSLog(@"oriString=%@",[NSString stringWithCString:s encoding:NSUTF8StringEncoding]);
    int i=0, j= length-1;
    while (i< j){
        char temp = s[i];
        s[i] = s[j];
        s[j]= temp;
        i++;
        j--;
    }
    NSLog(@"newString =%@",[NSString stringWithCString:s encoding:NSUTF8StringEncoding]);
    NSLog(@"\n");
    return s;
}
@end
