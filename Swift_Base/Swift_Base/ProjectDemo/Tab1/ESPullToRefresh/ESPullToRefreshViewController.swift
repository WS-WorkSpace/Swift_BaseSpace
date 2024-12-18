//
//  ESPullToRefreshViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/27.
//

import ESPullToRefresh
import UIKit

class ESPullToRefreshViewController: UIViewController {
    fileprivate var mDataArray = [JSON]()
    lazy var mTableView: UITableView = {
        let tabview = UITableView()
        tabview.frame = kScrollViewFrame
        tabview.delegate = self
        tabview.dataSource = self
        tabview.backgroundColor = .lightGray
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        return tabview
    }()
    lazy var animationHeader: ESRefreshProtocol & ESRefreshAnimatorProtocol = HeaderAnimatorView.init(frame: CGRect.zero)
    static let ItemCellID = "ESPullToRefreshCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mTableView)
        loadNewData()
        // 添加下拉刷新
        // setupPullToRefresh()
        // 自定义文字
//        setupPullToRefresh(animator: header)
        // 自定义动画
        // setupPullToRefresh(animator: header)
        setupPullToRefresh(animator: animationHeader)
        // 添加上拉加载更多
//        setupLoadMoreData()
        setupLoadMoreData(animator: footer)
        }


    func loadNewData() {
        let url = GlobalConfig.BOOKLIST_URL
        let parameters = ["key": "value"]
        DispatchQueue.global().async {
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { [weak self] response in
                guard let json = response.result.value, let weakSelf = self else { return }
                let dicJson = JSON(json)
                let temp: [JSON] = dicJson["list"].arrayValue
                // 模拟每次加载3个数据
                weakSelf.mDataArray.append(temp[0])
                weakSelf.mDataArray.append(temp[1])
                weakSelf.mDataArray.append(temp[2])
                weakSelf.mTableView.reloadData()
                weakSelf.mTableView.es.stopPullToRefresh()
                weakSelf.mTableView.es.stopLoadingMore()
            })
        }
    }

    deinit {
        print("\(Self.self)已经释放")
    }
}

// MARK: - 设置下拉刷新,和下拉加载更多的方法

extension ESPullToRefreshViewController {
    func setupPullToRefresh(animator: (ESRefreshProtocol & ESRefreshAnimatorProtocol)? = nil) {
        if animator == nil {
            mTableView.es.addPullToRefresh {
                [unowned self] in
                mlog("开始下拉刷新")
                loadNewData()
                //            mTableView.es.stopPullToRefresh()
                /// 在这里做刷新相关事件
                /// ...
                //            /// 如果你的刷新事件成功，设置completion自动重置footer的状态
                //            mTableView.es.stopPullToRefresh(completion: true)
                //            /// 设置ignoreFooter来处理不需要显示footer的情况
                //            mTableView.es.stopPullToRefresh(completion: true, ignoreFooter: false)
            }
        } else {
            mTableView.es.addPullToRefresh(animator: animator!) {
                [unowned self] in
                mlog("开始下拉刷新")
                loadNewData()
            }
        }
    }

    func setupLoadMoreData(animator: (ESRefreshProtocol & ESRefreshAnimatorProtocol)? = nil) {
        mlog("上拉加载更多")
        if animator == nil {
            mTableView.es.addInfiniteScrolling {
                [unowned self] in
                /// 在这里做加载更多相关事件
                loadNewData()
                /// ...
                /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                //            mTableView.es.noticeNoMoreData()
            }
        } else {
            mTableView.es.addInfiniteScrolling(animator: animator!) {
                [unowned self] in
                loadNewData()
            }
        }
    }

    // 自定义下拉上拉 文字提示
    var header: ESRefreshHeaderAnimator {
        let h = ESRefreshHeaderAnimator(frame: CGRect.zero)
        h.pullToRefreshDescription = "下拉刷新"
        h.releaseToRefreshDescription = "松开获取最新数据"
        h.loadingDescription = "下拉刷新..."
        return h
    }

    var footer: ESRefreshFooterAnimator {
        let f = ESRefreshFooterAnimator(frame: CGRect.zero)
        f.loadingMoreDescription = "上拉加载更多"
        f.noMoreDataDescription = "数据已加载完"
        f.loadingDescription = "加载更多..."
        return f
    }
}

extension ESPullToRefreshViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellID, for: indexPath)
        let descString = mDataArray[indexPath.row]["desc"].stringValue
        cell.textLabel?.text = descString
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension ESPullToRefreshViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descString = mDataArray[indexPath.row]["desc"].stringValue
        let contentHeight = descString.RD_getStringHeight(kScreenWidth - 10 - 10, 20)
        let cellHeight = contentHeight + 10 + 10
        return cellHeight
    }
}
