//
//  BaseTableViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/3.
//

import UIKit

class BaseTableViewController: BaseViewController {
    private lazy var modelArr = [String]()
    // 计算属性,设置cell.textLabel
    var configModelArr: [String] {
        get {
            return modelArr
        }
        set(newValue) {
            modelArr = newValue
        }
    }
    func appendModelArr(_ newString:String) {
        modelArr.append(newString)
    }

    lazy var mTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.RD_registerCell(UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = BaseBgColor
        return tableView
    }()

    /// 点击Cell Block
    var clickCellBlock: ((_ indexPath: IndexPath, _ text: String) -> ())?
    /// 子类加载需要调用这个方法
    func configTableView() {
        view.addSubview(mTableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        configTableView()
    }
}

extension BaseTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = modelArr[indexPath.row]
        return cell
    }
}

extension BaseTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 取消选中

        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text ?? ""
        //Lg.log("- 选中cell : \(text)")
        clickCellBlock?(indexPath, text)
    }
    // 设置cell的显示 3D缩放动画
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 设置cell的显示动画为3D缩放
        // xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        // 设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animate(withDuration: 0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
    }
}
