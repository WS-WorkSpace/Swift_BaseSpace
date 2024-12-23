//
//  BaseTableView.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/23.
//

import EmptyDataSet_Swift
import UIKit

enum EmptyDataViewState: Int {
    /// 状态0 - 暂无数据
    case StateNoData = 0
    /// 状态1 -网络请求错误,(网络不可用,请检查网络设置)
    case StateNetWorkError
    /// 状态2 - 重新加载
    case StateLoading
}

private let kNoDataStr = NSAttributedString(string: "暂无数据")
private let kNetWorkErrorStr = NSAttributedString(string: "网络不给力,点击重新加载")
private let kButtonTitleNormal = NSAttributedString(string: "重新加载1")
private let kButtonTitlehigHlighted = NSAttributedString(string: "重新加载2")

class BaseTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initMethod()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    func mReloadEmptyDataSet(){
//        Alamofire.request(T##urlRequest: any URLRequestConvertible##any URLRequestConvertible)
//        self.reloadEmptyDataSet()
        //DZNEmptyDataSet.UIScrollView.reloadEmptyDataSet()

    }
    private func initMethod() {
        backgroundColor = .white
        configIOS11()
        emptyDataSetSource = self
        emptyDataSetDelegate = self

//        ///*  方法一:直接设置 emptyDataSetView
//        /// 方法二:代理中设置
//         self.emptyDataSetView { view in
//             view.titleLabelString(kNoDataStr)
//                 .detailLabelString(kNetWorkErrorStr)
//                 .image(UIImage(named: "Alert_error"))
        ////                 .imageAnimation(imageAnimation)
        ////                 .buttonTitle(kButtonTitleNormal, for: .normal)
        ////                 .buttonTitle(kButtonTitlehigHlighted, for: .highlighted)
        ////                 .buttonBackgroundImage(buttonBackgroundImage, for: .normal)
        ////                 .buttonBackgroundImage(buttonBackgroundImage, for: .highlighted)
        ////                 .dataSetBackgroundColor(backgroundColor)
        ////                 .verticalOffset(verticalOffset)
        ////                 .verticalSpace(spaceHeight)
//                 .shouldDisplay(true)
        ////                 .shouldFadeIn(true)
        ////                 .isTouchAllowed(true)
        ////                 .isScrollAllowed(true)
        ////                 .isImageViewAnimateAllowed(isLoading)
//                 .didTapDataButton {
//                     // Do something
//                     mlog("点击重新加载按钮")
//                 }
//                 .didTapContentView {
//                     // Do something
//                     mlog("点击ContentView")
//                 }
//         }
        /// */

//        // 设置空数据视图
//        emptyDataSetSource = MyEmptyDataSetSource()
//        emptyDataSetDelegate = self
    }

    func setupEmpty() {}

    // MARK: - iOS 适配

    private func configIOS11() {
        /// 适配 iOS 11.0 ,iOS11以后，控制器的automaticallyAdjustsScrollViewInsets已经废弃，所以默认就会是YES
        /// iOS 11新增：adjustContentInset 和 contentInsetAdjustmentBehavior 来处理滚动区域
        if #available(iOS 11.0, *) {
            self.estimatedRowHeight = 0
            self.estimatedSectionHeaderHeight = 0
            self.estimatedSectionFooterHeight = 0
            // 防止列表/页面偏移
            self.contentInsetAdjustmentBehavior = .never
        }
    }
}

extension BaseTableView: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let text = "暂无数据"
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let text = "努力为您查找..."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .center
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        return NSAttributedString(string: "重新加载")
    }

    func buttonImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return UIImage(named: "RDEmptyData.bundle/NullData_reloadData")
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 10
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "Alert_error")
    }
    
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation?{
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 5
        animation.autoreverses = false
        animation.fillMode = .forwards
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        return animation
    }
    /**
      /// 如果设置了customView,其它控件设置无效
     func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
         let view = CustomView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
         return view
     }
     */
}

extension BaseTableView: EmptyDataSetDelegate {
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return numberOfRows(inSection: 0) == 0
    }

    func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        print("点击了UIScrollView")
    }

    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        print("点击了按钮")
    }

    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
