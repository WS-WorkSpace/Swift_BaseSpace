//
//  NineGridFlowLayout.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/5.
//

import UIKit

class NineGridFlowLayout: UICollectionViewFlowLayout {
    var itemAttributes = Array<UICollectionViewLayoutAttributes>()
    
    // MARK: - UICollectionViewLayout (UISubclassingHooks)
    /// 准备好布局时调用，此时collectionView所有属性已经确定了
    override func prepare() {
        super.prepare()
        let delegate = self.collectionView?.delegate
        let sectionCount = self.collectionView?.numberOfSections ?? 0
        for section in 0..<sectionCount{
            // 获取每一组最后一个 item 的索引
            let lastIndex = self.collectionView?.numberOfItems(inSection: section) ?? 0 - 1 ;
            if lastIndex < 0 { continue }
            // 取出每一组第一个和最后一个 item 的布局，来计算每一组的高度，
            let firstIndexpath = IndexPath(item: 0, section: section)
            let firstItemAttr:UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: firstIndexpath) ?? UICollectionViewLayoutAttributes()
            let lastIndexpath = IndexPath(item: lastIndex, section: section)
            let lastItemAttr:UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: lastIndexpath) ?? UICollectionViewLayoutAttributes()
            // 计算高度需要把间距加上去
            let sectionInset = self.sectionInset
            // 判断是否有额外改变间距的代理，有的话就更新间距
//            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            }

            if delegate != nil && ((delegate?.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:)))) ?? false) {
                
//                let inset = delegate?.collectionView?(collectionView(self.collectionView, layout: self, insetForSectionAt: section))
//                if let inset = delegate.collectionView?(self.collectionView!,
//
//                                        layout: self, insetForSectionAt: section) {
//
//                    sectionInset = inset

                }


            }

            
            
        }
    }
//    - (void)prepareLayout{
//        [super prepareLayout];
////        self.itemAttributes = [NSMutableArray array];
////        [ self registerClass: [ImageReusableView class ] forDecorationViewOfKind:@"SelfReusableView" ];
//        id<UICollectionViewDelegateFlowLayout> delegate = (id)self.collectionView.delegate ;
//        // 总共有多少个组
//        NSInteger sectionCount = self.collectionView.numberOfSections ;
//        // 遍历每一组
//        for ( int section = 0 ; section < sectionCount ; section++ ) {
//            // 获取每一组最后一个 item 的索引
//            NSInteger lastIndex = [ self.collectionView numberOfItemsInSection:section ] - 1 ;
//            if ( lastIndex < 0 ) {
//                continue ;
//            }
//            // 取出每一组第一个和最后一个 item 的布局，来计算每一组的高度，
//            UICollectionViewLayoutAttributes *firstItemAttr = [ self layoutAttributesForItemAtIndexPath: [ NSIndexPath indexPathForItem:0 inSection:section ]];
//            UICollectionViewLayoutAttributes *lastItemAttr = [ self layoutAttributesForItemAtIndexPath: [ NSIndexPath indexPathForItem:lastIndex inSection:section ]];
//            // 计算高度需要把间距加上去
//            UIEdgeInsets sectionInset = self.sectionInset ;
//            // 判断是否有额外改变间距的代理，有的话就更新间距
//            if ([ delegate respondsToSelector:@selector ( collectionView:layout:insetForSectionAtIndex: )]) {
//                sectionInset = [ delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section ];
//            }
//
//            // 获取除了 section 间距外的矩形大小
//            //CGRectUnion 获取包含两个 frame 的最小的矩形 frame
//            CGRect frame = CGRectUnion ( firstItemAttr.frame , lastItemAttr.frame );
//            //x , y ,初始坐标需要包含 inset ，所以要减间距，
//            frame.origin.x -= sectionInset.top ;
//            frame.origin.y -= sectionInset.left ;
//            /*
//             宽高不能这么写，因为 item 不可能正好铺满屏幕，如果最后一行(或者一列)只有一个，那么宽度就是这一个的宽高，得到的并不是 collectionView 的宽高
//             frame.size.height += ( sectionInset.top + sectionInset.bottom );
//             frame.size.width += ( sectionInset.left + sectionInset.right );
//             */
//            // 判断滚动方向固定宽高
//            if ( self.scrollDirection == UICollectionViewScrollDirectionHorizontal ) { // 水平滚动，高度是固定的，宽度不固定
//                frame.size.height = self.collectionView.frame.size.height ;
//                frame.size.width += ( sectionInset.left + sectionInset.right );
//            }else{// 竖直滚动，宽度是固定的，高度不固定
//                frame.size.height += ( sectionInset.top + sectionInset.bottom );
//                frame.size.width = self.collectionView.frame.size.width ;
//            }
//            // 装饰视图(类似于背景视图，如果做一个书架，该 View 可以做书架) 对于装饰视图的 UI 更新，需要覆写自定义的 UICollectionReusableView 的 applyLayoutAttributes 方法进行覆写
//            //
//            UICollectionViewLayoutAttributes *bgAttrbutes = [ UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"SelfReusableView" withIndexPath: [ NSIndexPath indexPathForItem:0 inSection:section ]];
//            // 放在最底层
//            bgAttrbutes.zIndex = -1 ;
//            bgAttrbutes.frame = frame ;
//            [ self.itemAttributes addObject:bgAttrbutes ];
//
//        }
//    }
//
//
//}
