//
//  HeaderAnimatorView.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/27.
//

import ESPullToRefresh
import UIKit

// 自定义 https://www.jianshu.com/p/c3f2b8ef9c4b
class HeaderAnimatorView: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public var insets: UIEdgeInsets = .zero
    public var view: UIView { return self }
    public var duration: TimeInterval = 0.3
    public var trigger: CGFloat = 56.0
    public var executeIncremental: CGFloat = 56.0
    public var state: ESRefreshViewState = .pullToRefresh
            
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "self_refresh_1")
        return imageView // self_refresh_1
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
        
    @available(*, unavailable)
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        imageView.center = center
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.imageView.frame = CGRect(x: (self.bounds.size.width - 39.0) / 2.0,
                                          y: self.bounds.size.height - 50.0,
                                          width: 39.0,
                                          height: 50.0)

        }, completion: { _ in
            var images = [UIImage]()
            for idx in 1 ... 8 {
                if let aImage = UIImage(named: "self_refresh_\(idx)") {
                    images.append(aImage)
                }
            }
            self.imageView.animationDuration = 0.5
            self.imageView.animationRepeatCount = 0
            self.imageView.animationImages = images
            self.imageView.startAnimating()
        })
    }
        
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        imageView.stopAnimating()
        imageView.image = UIImage(named: "icon_pull_animation_1")
            
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.refresh(view: view, progressDidChange: 0.0)
        }, completion: { _ in
        })
    }
        
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = max(0.0, min(1.0, progress))
        imageView.frame = CGRect(x: (bounds.size.width - 39.0) / 2.0,
                                 y: bounds.size.height - 50.0 * p,
                                 width: 39.0,
                                 height: 50.0 * p)
    }
        
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
            
        switch state {
        case .pullToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 5 {
                if let aImage = UIImage(named: "self_refresh_\(5 - idx + 1)") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.2
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage(named: "self_refresh_1")
            imageView.startAnimating()
        case .releaseToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 5 {
                if let aImage = UIImage(named: "self_refresh_\(idx)") {
                    images.append(aImage)
                }
            }
            imageView.animationDuration = 0.2
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage(named: "self_refresh_5")
            imageView.startAnimating()
        default:
            break
        }
    }
}
