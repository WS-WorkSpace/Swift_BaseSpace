//
//  SelfRefreshGifHeader.m
//  ShowExample
//
//  Created by 王爽 on 2022/10/19.
//

#import "SelfRefreshGifHeader.h"

@implementation SelfRefreshGifHeader

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:30];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:30];
    //普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
//    CGRect temp = self.frame;
//    temp.size.width = 20;
//    temp.size.height = 20;
//    self.frame = temp;
}

- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}

#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        NSString *sampleBundlePath = [[NSBundle mainBundle] pathForResource:@"Refresh.bundle" ofType:nil];
        NSBundle *sampleBundle = [NSBundle bundleWithPath:sampleBundlePath];
        NSString *picName = [NSString stringWithFormat:@"self_refresh_%zd.png",i];
        NSString *picPath = [sampleBundle pathForResource:picName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:picPath];
//        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"self_refresh_%zd",i]];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}

@end
