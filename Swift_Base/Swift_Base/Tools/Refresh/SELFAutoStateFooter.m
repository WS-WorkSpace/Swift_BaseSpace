//
//  SELFAutoStateFooter.m
//  ShowExample
//
//  Created by 王爽 on 2022/11/19.
//

#import "SELFAutoStateFooter.h"

@implementation SELFAutoStateFooter

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
}

- (void)placeSubviews{
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
@end
//https://blog.csdn.net/u010545480/article/details/125716497
/*
 二、如何使用
 //导入相关头文件
 #import "SELFAutoStateFooter.h"

  //上拉加载更多
  self.tableView.mj_footer = [HSWuGanRefreshFooter footerWithRefreshingBlock:^{
      self.page ++;
      [self requestData];
  }];
 三、实现原理
 通过分析其源码 MJRefreshAutoFooter 类可以发现其实就是将手动加载下一页变成了自动加载下一页。普通的下拉加载更多，是要用户手动的触发了列表底部的下拉刷新控件，而无感刷新只是将这一触发条件改成了监听屏幕滚动到哪个位置，变自动触发加载下一页的数据。
 #import "MJRefreshFooter.h"
 ** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) *
 @property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;
 - (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
 {
     [super scrollViewContentOffsetDidChange:change];
     
     if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_y == 0) return;
     
     if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
         // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
         if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetB - self.mj_h) {
             // 防止手松开时连续调用
             CGPoint old = [change[@"old"] CGPointValue];
             CGPoint new = [change[@"new"] CGPointValue];
             if (new.y <= old.y) return;
             
             // 当底部刷新控件完全出现时，才刷新
             [self beginRefreshing];
         }
     }
 }
 我们可以通过修改 triggerAutomaticallyRefreshPercent 的值改变触发加载下一页的时机，比如我们想要列表滑动到屏幕一半的时候开始加载下一页：
 HSWuGanRefreshFooter *footer = [HSWuGanRefreshFooter footerWithRefreshingBlock:^{
     self.page ++;
     [self requestData];
 }];
 footer.triggerAutomaticallyRefreshPercent = 0.5;
 self.tableView.mj_footer = footer;
 */
