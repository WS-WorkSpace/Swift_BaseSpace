//
//  ReactiveProgrammingViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/20.
//

import RxCocoa
import RxSwift
import UIKit

public enum Event<Element> {
    /// Next element is produced.
    case next(Element)
    /// Sequence terminated with an error.
    case error(Swift.Error)
    /// Sequence completed successfully.
    case completed
}

enum mError: Error {
    case test
}

class ReactiveProgrammingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// 创建、订阅Observable
        /// 方法1
        setupObservable1()
        /// 方法2
        setupObservable2()
    }

    func setupObservable1() {
        // 发消息
//        let observable1 = Observable<Int>.create { observer in
//            print()
//            observer.onNext(11) // 给observer发送消息 11
//            observer.onNext(22)
//            observer.onNext(33)
//            observer.onError(mError.test)
//            observer.onCompleted()
//            return Disposables.create()
//        }

        // jsut 只发送一个元素,of和from 发送一个数组
        // let observable1 = Observable.just(11) // 等价于observer.onNext(11)  observer.onCompleted()
        // let observable1 = Observable.of(1, 2) // 等价于observer.onNext(11) observer.onNext(2)  observer.onCompleted()
        // let observable1 = Observable.from([1, 2, 3])
        // 定时器在主线程下, 2秒后,每隔1秒发一个消息,从0,1,2,3递增
        let observable1 = Observable<Int>.timer(DispatchTimeInterval.seconds(2),
                                                period: .seconds(1),
                                                scheduler: MainScheduler.instance)

        // observable订阅
        // 接收消息
        observable1.subscribe { event in
            switch event {
            case .next(let element):
                print("next", element)
            case .error(let error):
                print("error", error)
            case .completed:
                print("completed")
            }
        }
        observable1.subscribe { element in
            print("next", element)
        } onError: { error in
            print("error", error)
        } onCompleted: {
            print("completed")
        }
//        observable1.subscribe { element in
//            print("next", element)
//        } onError: { error in
//            print("error", error)
//        } onCompleted: {
//            print("completed")
//        } onDisposed: {
//            print("onDisposed")
//        }
    }

    func setupObservable2() {}
}
