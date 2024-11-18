//
//  MultithreadingViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/16.
//

import UIKit

// 全局变量默认也是lazy,和静态一样被访问才会执行
private let initTask2: Void = {
    print("initTask2:仅执行一次")
}()

class MultithreadingViewController: UIViewController {
    private var item: DispatchWorkItem?

    // initTask  类属性全局变量.整个程序运行中,只会初始化一次,返回N次.
    // 默认lazy ,用到的时候才会初始化一次.
    // 线程安全的,因为dispatch_once本身就是线程安全的
    // 里面的代码相当于放在_dispatch_once里面调用了
    static let initTask: Void = {
        print("initTask:仅执行一次")
    }() // 这里用等于用一个函数的返回值给initTask初始化.
    static let initTask3: Int = {
        print("initTask3:仅执行一次")
        return 7
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "多线程"
        // 添加子视图
        setupButtons()
    }

    func setupButtons() {
        view.addSubview(mButton)
        view.addSubview(mSegment)
        view.addSubview(onceButton)
        view.addSubview(lockButton)
    }

    lazy var mButton: UIButton = {
        let titleColor = RD_RandomColor()
        let button = UIButton(frame: .zero)
        button.frame = CGRect(x: 10, y: distanceTop + 50, width: kScreenWidth - 20, height: 60)
        button.titleLabel?.font = RD_Font(16)
        button.setTitle("开启多线程", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = RD_RandomColor().cgColor
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(clicklazyButton), for: .touchUpInside)
        return button
    }()

    @objc func clicklazyButton() {
        GCDTask()
    }

    lazy var mSegment: UISegmentedControl = {
        let dataArr = ["延迟执行", "关闭"]
        let segment = UISegmentedControl(items: dataArr)
        segment.frame = CGRect(x: 0, y: distanceTop + 150, width: 240, height: 60)
        segment.isMomentary = false
        segment.layer.cornerRadius = 5
        segment.clipsToBounds = true
        segment.tintColor = RD_Color(237, 148, 45) // 选中颜色
        segment.backgroundColor = RD_GrayColor(254)
        if #available(iOS 13.0, *) {
            // 文字默认颜色
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
            // 文字选中颜色
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for: .selected)
            // 选中item背景颜色
            segment.selectedSegmentTintColor = RD_Color(237, 148, 45)
        }
        segment.selectedSegmentIndex = 1 // 选中第几个segment 一般用于初始化时选中
        segment.RD_centerX = self.view.RD_centerX
        segment.addTarget(self, action: #selector(self.SegmentChanged(segment:)), for: .valueChanged)
        segment.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        return segment
    }()

    @objc func SegmentChanged(segment: UISegmentedControl) {
        let selectedIndex = segment.selectedSegmentIndex
        if selectedIndex == 0 {
            delayStrat()
        } else {
            item?.cancel()
        }
    }

    lazy var onceButton: UIButton = {
        let titleColor = RD_RandomColor()
        let button = UIButton(frame: .zero)
        button.frame = CGRect(x: 10, y: distanceTop + 250, width: kScreenWidth - 20, height: 60)
        button.titleLabel?.font = RD_Font(16)
        button.setTitle("只执行一次", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = RD_RandomColor().cgColor
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(clickOnceButton(btn:)), for: .touchUpInside)
        return button
    }()

    @objc func clickOnceButton(btn: UIButton) {
        once()
    }

    lazy var lockButton: UIButton = {
        let titleColor = RD_RandomColor()
        let button = UIButton(frame: .zero)
        button.frame = CGRect(x: 10, y: distanceTop + 350, width: kScreenWidth - 20, height: 60)
        button.titleLabel?.font = RD_Font(16)
        button.setTitle("加锁", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = RD_RandomColor().cgColor
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(clickLockButton(btn:)), for: .touchUpInside)
        return button
    }()

    @objc func clickLockButton(btn: UIButton) {
        WS_Async.async {
            print(Thread.current)
            WS_Cache.set("Jack", 1)
        }

        WS_Async.async {
            print(Thread.current)

            WS_Cache.set("Jack", 2)
        }
        print(WS_Cache.get("Jack") as Any)
    }
}

extension MultithreadingViewController {
    func GCDTask() {
        /*
         // 方法一:GCD执行异步操作，然后返回主线程
         DispatchQueue.global().async {
             print(Thread.current) // <NSThread: 0x600001700f80>{number = 8, name = (null)}
             DispatchQueue.main.async {
                 print(Thread.current) // <_NSMainThread: 0x600001700280>{number = 1, name = main}
             }
         }
         // 方法二:DispatchWorkItem(block: <#T##() -> Void#>)，实现异步
         let item = DispatchWorkItem {
             print(Thread.current) // <NSThread: 0x60000175cac0>{number = 4, name = (null)}
         }
         DispatchQueue.global().async(execute: item)
         item.notify(queue: DispatchQueue.main) {
             print("网络请求结束后回调主线程", Thread.current) // 网络请求结束后回调主线程 <_NSMainThread: 0x600001704280>{number = 1, name = main}
         }
          */
        WS_Async.async {
            print("直接在子线程做事")
        }
        WS_Async.async({
            print("在子线程做事", Thread.current)
        }) {
            print("返回到主线程做事1", Thread.current)
        }
    }

    func once() {
        // 方式一:初始化类静态成员变量,仅执行一次
        _ = Self.initTask
        _ = initTask2
        print(Self.initTask3)
    }

    func delayStrat() {
//        //方法1
//        let senconds = DispatchTime.now() + 3.0
//        DispatchQueue.main.asyncAfter(deadline: senconds) {
//            print("延迟后3秒打印:", Thread.current)
//        }
//        //方法2
//        let item = DispatchWorkItem {
//            print("延迟后3秒打印:", Thread.current)
//        }
//        DispatchQueue.main.asyncAfter(deadline: senconds, execute: item)

//        WS_Async.delay(3) {
//            print("延迟后3秒打印:", Thread.current)
//        }

        // 拿到ietm 可以取消任务
        // 注意这里取消的item是包含了异步子线程任务的item,主线程任务没有取消
        item = WS_Async.asyncDelay(4, {
            print("--->4秒后在子线程做事", Thread.current)
        }) {
            print("--->返回到主线程做事", Thread.current)
        }
    }
}

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //取消任务
//        item?.cancel()
//    }
