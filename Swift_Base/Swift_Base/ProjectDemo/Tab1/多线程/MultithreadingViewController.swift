////
////  MultithreadingViewController.swift
////  Swift_Base
////
////  Created by 王爽 on 2024/11/16.
////
//
//import UIKit
//
//
////全局变量默认也是lazy,和静态一样被访问才会执行
//fileprivate var initTask2: Void = {
//   print("initTask2:仅执行一次")
//}()
//
//class MultithreadingViewController: UIViewController {
//
//    private var item: DispatchWorkItem?
//
//    //initTask  类属性全局变量.整个程序运行中,只会初始化一次,返回N次.
//    //默认lazy ,用到的时候才会初始化一次.
//    //线程安全的,因为dispatch_once本身就是线程安全的
//    //里面的代码相当于放在_dispatch_once里面调用了
//    static var initTask: Void = {
//       print("initTask:仅执行一次")
//    }()//这里用等于用一个函数的返回值给initTask初始化.
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .white
//        //        self.GCDTask();
//        //延迟执行
////        self.lazyStrat();
//        self.once();
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //取消任务
//        item?.cancel()
//    }
//    func once(){
//        //方式一:初始化类静态成员变量,仅执行一次
//        let _ = Self.initTask
//        let _ = initTask2
//
//    }
//    func lazyStrat() {
//        //        let senconds = DispatchTime.now() + 3.0;
//        //        let item = DispatchWorkItem {
//        //            print("延迟后3秒打印:",Thread.current)
//        //        }
//        //        DispatchQueue.main.asyncAfter(deadline: senconds, execute: item)
////        private var item: DispatchWorkItem?
//
//        WS_Async.delay(3) {
//            print("延迟后3秒打印:",Thread.current)
//        }
//        //拿到ietm 可以取消任务,这里有bug,主线程任务没有取消
//        item = WS_Async.asyncDelay(4) {
//            print("--->2秒后在子线程做事",Thread.current)
//        } _: {
//            print("--->返回到主线程做事",Thread.current)
//        }
//    }
//    func GCDTask(){
//        //GCD
//        //        print(Thread.current)
//        //        DispatchQueue.global().async {
//        //            print(Thread.current)
//        //            DispatchQueue.main.async {
//        //                print("----->",Thread.current)
//        //            }
//        //        }
//        
//        //        let item = DispatchWorkItem{
//        //            print("------->",Thread.current)
//        //        }
//        //        DispatchQueue.global().async(execute: item)
//        //        item.notify(queue: DispatchQueue.main) {
//        //                print("------->网络请求结束后回调主线程")
//        //        }
//        WS_Async.async {
//            print("直接在子线程做事")
//        }
//        WS_Async.async {
//            print("在子线程做事",Thread.current)
//        } _: {
//            print("返回到主线程做事",Thread.current)
//        }
//        
//    }
//}
