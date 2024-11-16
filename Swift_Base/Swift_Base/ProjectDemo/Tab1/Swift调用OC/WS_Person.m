//
//  WS_Person.m
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

#import "WS_Person.h"

@implementation WS_Person

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
    }
    return self;
}
//+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name {
//    return nil;
//}
+ (void)run { NSLog(@"Swift调用:类方法: +run"); }
- (void)run { NSLog(@"Swift调用:实例方法: -run, 年龄:%zd,姓名:%@", _age, _name); }
+ (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"Swift调用:类方法: +eat, 食物:%@, %@", food, other); }
- (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"Swift调用:实例方法:年龄:%zd 姓名:%@ -eat %@ %@", _age, _name, food, other); }
int sum(int a, int b) {
    return a + b;
}



@end
