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
/**累加不使用循环和递归借助oc语法*/
- (int)calculate: (int)n {
    int sum = 0;
    int i=0;
add:
    i++ ;
    if(i>n){
        return sum;
    }
    sum +=i;
    goto add;
}
/*一个字符串最长且没有重复字符的子串*/
- (NSString *)findNoDuplicateSubString: (NSString *)originString {
    if (! originString.length) {
        return nil;
    }
    int startIndex = 0;
    int endIndex = 0 ;
    int currentIndex = 0;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < originString. length;i++) {
        NSString *iChar = [originString substringWithRange:NSMakeRange(i, 1)];
        NSNumber *lastCacheIndex = dic[iChar] ;
        dic[iChar] = @(i);
        if (lastCacheIndex) {
            currentIndex = [lastCacheIndex intValue] + 1;
        }
        if (i - currentIndex > endIndex - startIndex) {
            startIndex = currentIndex ;
            endIndex = i;
        }
//        NSLog(@"====%@",[originString substringWithRange : NSMakeRange (startIndex, endIndex - startIndex + 1)]);
    }
    return [originString substringWithRange : NSMakeRange (startIndex, endIndex - startIndex + 1)];
}
- (void)testFindNoDuplicateSubString {
    PPUnsortedDemo *demo = [[PPUnsortedDemo alloc] init];
    NSString *str = [demo findNoDuplicateSubString:@"appleeeeee"];
    NSLog(@"====%@",str);
}
@end
