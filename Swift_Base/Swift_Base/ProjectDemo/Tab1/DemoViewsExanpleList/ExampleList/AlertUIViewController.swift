//
//  AlertUIViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2023/8/3.
//

import UIKit

class AlertUIViewController: BaseViewController {
    private lazy var modelArr: [[String]] = {
        var dataArr1 = [String]()
        dataArr1 = ["微信ActionSheet", "微信ActionSheet-没有标题", "微信ActionSheet-没有取消", "微信ActionSheet-红色按钮"]
        var dataArr2 = [String]()
        dataArr2 = ["系统Alert", "系统Alert-修改按钮文字", "系统Alert-带标题", "系统Alert-带内容", "系统Alert-只有确认", "系统Alert-3个按钮", "系统Alert-红色按钮",
                    "系统Sheet", "系统Sheet-带标题", "系统Sheet-带内容", "系统Sheet-没有取消", "系统Sheet-红色按钮"]

        return [dataArr1, dataArr2]
    }()

    private func configTableView() {
        navTitle = "弹框"
        view.addSubview(tableView)
    }

    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero)
        tableView.frame = CGRect(x: 0, y: distanceTop, width: kScreenWidth, height: kScreenHeight-distanceTop-distanceBottom)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
}

extension AlertUIViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArr.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "微信弹窗"
        case 1:
            return "系统弹窗"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = modelArr[indexPath.section][indexPath.row]
        return cell
    }
}

extension AlertUIViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 取消选中
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.text ?? ""
        Lg.log(" 选中\(indexPath.section)----\(indexPath.row)-----cell : \(text)")
        alert(indexPath: indexPath)
    }

    func alert(indexPath: IndexPath) {
        // MARK: - "微信弹窗"

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let tempArr = ["action1", "action2", "action3"]
                RDActionSheet.show(title: "标题", largeTitle: "大标题", actionTitles: tempArr, destructive: "action4", cancelTitle: "取消") { index in
                    Lg.log(index)
                }
            case 1:
                let tempArr = ["action1", "action2", "action3"]
                RDActionSheet.show(actionTitles: tempArr) { index in
                    Lg.log(index)
                }
            case 2:
                let tempArr = ["action1", "action2", "action3"]
                RDActionSheet.show(title: "请选择请选择请选择请选择请选择请选择请选择请选择请选择请选择", actionTitles: tempArr, destructive: "action4", cancelTitle: "") { index in
                    Lg.log(index)
                }
            case 3:
                RDActionSheet.show(title: "请选择操作", destructive: "退出登录") { index in
                    Lg.log(index)
                }
            default:
                break
            }
        }

        // MARK: - "系统弹窗"

        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: //
                SystemAlertTool.systemAlert(title: "标题", message: "这是内容") { index in
                    Lg.log(index)
                }
            case 1:
                SystemAlertTool.systemAlert(title: "标题", message: "这是内容", cancelTitle: "取消#", confirmTitle: "确认*") { index in
                    Lg.log(index)
                }
            case 2:
                SystemAlertTool.systemAlert(title: "标题标题标题标题标题标题标题标题") { index in
                    Lg.log(index)
                }
            case 3:
                SystemAlertTool.systemAlert(message: "这是内容这是内容这是内容这是内容这是内容") { index in
                    Lg.log(index)
                }
            case 4:
                SystemAlertTool.systemAlert(title: "标题", message: "这是内容这是内容这是内容", cancelTitle: "", confirmTitle: "好的") { index in
                    Lg.log(index)
                }
            case 5:
                let tempArr = ["action1", "action2", "action3"]
                SystemAlertTool.showSystemAlert(title: "提示", message: "这是内容", actionTitles: tempArr, cancelTitle: "取消", style: .alert) { index in
                    Lg.log(index)
                }
            case 6:
                let tempArr = ["action1", "action2", "action3"]
                let actionStyles = [UIAlertAction.Style.default, UIAlertAction.Style.default, UIAlertAction.Style.destructive]
                SystemAlertTool.showSystemAlert(title: "提示", message: "这是内容", actionTitles: tempArr, cancelTitle: "取消", style: .alert, actionStyles: actionStyles) { index in
                    Lg.log(index)
                }
            case 7:
                let tempArr = ["action1", "action2", "action3"]
                SystemAlertTool.systemActionSheet(title: "标题", message: "这是内容", actionTitles: tempArr) { index in
                    Lg.log(index)
                }
            case 8:
                let tempArr = ["action1", "action2", "action3"]
                SystemAlertTool.systemActionSheet(title: "标题", actionTitles: tempArr) { index in
                    Lg.log(index)
                }
            case 9:
                let tempArr = ["action1", "action2", "action3"]
                SystemAlertTool.systemActionSheet(message: "这是内容", actionTitles: tempArr) { index in
                    Lg.log(index)
                }
            case 10:
                let tempArr = ["action1", "action2", "action3"]
                SystemAlertTool.systemActionSheet(title: "提示", message: "这是内容", actionTitles: tempArr, cancelTitle: "") { index in
                    Lg.log(index)
                }
            case 11:
                let tempArr = ["action1", "action2", "action3"]
                let actionStyles = [UIAlertAction.Style.default, UIAlertAction.Style.default, UIAlertAction.Style.destructive]
                SystemAlertTool.showSystemAlert(title: "提示", message: "这是内容", actionTitles: tempArr, cancelTitle: "取消", style: .actionSheet, actionStyles: actionStyles) { index in
                    Lg.log(index)
                }
            default:
                break
            }
        }
    }
}
