//
//  BaseTableViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/3.
//

import UIKit

class BaseTableViewController: BaseViewController {
    private lazy var dataArr = [String]()
    var configModelArr: [String] {
        get {
            return dataArr
        }
        set(newValue) {
            dataArr = newValue
        }
    }

    lazy var mTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
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
        return dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
}

/*
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     // 定义一个cell的标识
     let cellID = "CellID"
     // 从缓存池中取出cell
     var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
     // 如果缓存池中没有cell, 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
     if cell == nil {
         cell = JhBaseTableViewCell(style: .value1, reuseIdentifier: cellID)
     }
     //        cell?.selectionStyle = .none //不显示选中颜色
     cell?.accessoryType = .disclosureIndicator // 显示最右边的箭头
     cell?.textLabel?.text = dataArr[indexPath.row] as? String
     cell?.textLabel?.font = JhFont(17)
     return cell!
 }
 */

extension BaseTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 取消选中

        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text ?? ""
        Lg.log("- 选中cell : \(text)")
        clickCellBlock?(indexPath, text)
    }
}
