//
//  WS_Person.h
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// C 语言函数
int sum(int a, int b);

@interface WS_Person : NSObject
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;
- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name;
//+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name;
- (void)run;
+ (void)run;
- (void)eat:(NSString *)food other:(NSString *)other;
+ (void)eat:(NSString *)food other:(NSString *)other;
@end


NS_ASSUME_NONNULL_END
