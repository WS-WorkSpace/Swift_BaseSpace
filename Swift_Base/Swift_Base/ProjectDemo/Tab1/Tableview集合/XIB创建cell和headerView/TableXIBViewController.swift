//
//  TableXIBViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/11.
//

import UIKit

class TableXIBViewController: UIViewController {
    let dataArr = ["label:a", "label:b,label:label:", "label:clabel:clabel:clabel:clabel:c", "d", "e", "f", "label:label:clabel:clabel:clabel:clabel:clabel:clabel:clabel:clabel:clabel:c"]
    lazy var subTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.frame = kScrollViewFrame
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
//        tableView.RD_registerHeaderFooterNib(XIBTableHeaderView.self)
        /*
         xib创建的view直接赋值给tableview.tableHeaderView会出现view填充不满的问题，右边会有留白现象。即使用Masoty约束frame也没有效果。
         原因：xib创建的view直接赋值给tableview.tableHeaderView会造成约束问题不准确。
         解决办法：先代码创建一个空的UIview,比如叫bgview同时设置frame,把tableview.tableHeaderView = bgview.然后在把xib创建的view添加到bgview上即可。
         */
//        let boundle = Bundle.main.loadNibNamed("XIBTableHeaderView", owner: nil)
//        let viewT = boundle?.first as? XIBTableHeaderView
//        viewT?.backgroundColor = .lightGray
//        tableView.tableHeaderView = viewT
        lazy var headerView = XIBTableHeaderView.loadFromNib()
        tableView.tableHeaderView = headerView
        tableView.register(UINib(nibName: "XIBExampleCell", bundle: nil), forCellReuseIdentifier: XIBExampleCell.CellID)
//        tableView.RD_registerNibCell(XIBExampleCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .yellow
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TableViw示例"
        self.view.addSubview(self.subTableView)
    }
}


extension TableXIBViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArr.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIBExampleCell.CellID, for: indexPath) as? XIBExampleCell
        cell?.leftLab.text = dataArr[indexPath.row]
        cell?.rightImg.image = UIImage(named: "AppIcon-mini") // "APP_NineGridHeadImg"
        cell?.backgroundColor = UIColor.randomColor
        return cell ?? XIBExampleCell()
    }
}

extension TableXIBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
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
