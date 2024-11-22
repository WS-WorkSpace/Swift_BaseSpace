//
//  SelfRefreshBackGifFooter.m
//  ShowExample
//
//  Created by 王爽 on 2022/10/19.
//

#import "SelfRefreshBackGifFooter.h"

@implementation SelfRefreshBackGifFooter

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:8];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:1 endIndex:8];
   // 普通状态
    [self setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.stateLabel.hidden = self.state != MJRefreshStateNoMoreData;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentH + self.ignoredScrollViewContentInsetBottom;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
    // 设置位置和尺寸
    self.mj_y = MAX(contentHeight, scrollHeight);
    
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
