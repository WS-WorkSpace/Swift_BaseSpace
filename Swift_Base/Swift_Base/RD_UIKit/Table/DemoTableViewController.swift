//
//  BaseTableViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/3.
//

import UIKit

class DemoTableViewController: BaseViewController {
    private lazy var dataArr = [String]()
    var modelArr: [String] {
        get {
            return dataArr
        }
        set(newValue) {
            dataArr = newValue
        }
    }

//    private lazy var dataArr: NSMutableArray = {
//        let tempArr = NSMutableArray()
//        return tempArr
//    }()

//    var modelArr: NSMutableArray {
//        get {
//            return dataArr
//        }
//        set(newValue) {
//            dataArr = newValue
//        }
//    }

    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        //        tableView.separatorStyle = .none //不显示分割线
        //        tableView.showsVerticalScrollIndicator = false;
        //        tableView.scrollEnabled = false // 设置tableview 不能滚动
//        tableView.register(T##UINib?, forCellReuseIdentifier: <#T##String#>)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellID)
        tableView.RD_registerCell(UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = BaseBgColor
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        tableView.tableFooterView = UIView()
        return tableView
    }()

    /// 点击Cell Block
    var clickCellBlock: ((_ indexPath: IndexPath, _ text: String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
}

extension DemoTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "aaaa"
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]

//        let repTestDetail:HandyJsonModel = items[indexPath.row]
//        cell.textLabel?.text = repTestDetail.desc

        // 图片转换
        // let url = "tupian.webp"
        // let pngUrl = url.replacingOccurrences(of: ".webp", with: ".png")
//        cell.imageView?.kf.setImage(with: URL(string: "https://img0.baidu.com/it/u=654841015,2231853144&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666"))
        //        print("--------__>",dicT)
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

extension DemoTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }

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
