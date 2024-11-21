//
//  ReactiveProgrammingViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/20.
//

import RxCocoa
import RxSwift
import UIKit

enum mError: Error {
    case test
}

extension Reactive where Base: UIView {
    var myHidden: Binder<Bool> {
        Binder<Bool>(base) { view, value in
            view.isHidden = value
        }
    }
}

class Dog: NSObject {
    @objc dynamic var name: String?
}

class ReactiveProgrammingViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        /// 创建、订阅Observable
//        setupObservable()
        /// 创建Observer
//        setupObserver()
        /// 创建Observer
//        setupObserver2()
        /// 控制button
        controlButtom()
        /// 监听按钮点击
        monitorButton()
        /// 视频没有了,等待自己研究吧
//        monitorTable()
        /// 监听属性
        monitorProperty()
    }

    func setupObservable() {
        // 发消息
//        let observable = Observable<Int>.create { observer in
//            print()
//            observer.onNext(11) // 给observer发送消息 11
//            observer.onNext(22)
//            observer.onNext(33)
//            observer.onError(mError.test)
//            observer.onCompleted()
//            return Disposables.create()
//        }

        // jsut 只发送一个元素,of和from 发送一个数组
        // let observable = Observable.just(11) // 等价于observer.onNext(11)  observer.onCompleted()
        // let observable = Observable.of(1, 2) // 等价于observer.onNext(11) observer.onNext(2)  observer.onCompleted()
        // let observable = Observable.from([1, 2, 3])
        // 定时器在主线程下, 2秒后,每隔1秒发一个消息,从0,1,2,3递增
        let observable = Observable<Int>.timer(DispatchTimeInterval.seconds(2),
                                               period: .seconds(1),
                                               scheduler: MainScheduler.instance)
        // bind 只能绑定到监听器, bind<Observer: ObserverType>,   label.rx.text也是一个Observer
//        let _ = observable.map { "\($0)" }.bind(to: label.rx.text)
        // self销毁时（deinit）时，会自动调用Disposable实例的dispose
        // 下面self就是视图控制器，会跟随视图控制器的deinit而dispose
        let _ = observable.take(until: rx.deallocated).map { "\($0)" }.bind(to: label.rx.text)

        // observable订阅
        // 接收消息
        // 接收1
//        observable.subscribe { event in
//            switch event {
//            case .next(let element):
//                print("next", element)
//            case .error(let error):
//                print("error", error)
//            case .completed:
//                print("completed")
//            }
//        }
        // 接收2
//        observable.subscribe { element in
//            print("next", element)
//        } onError: { error in
//            print("error", error)
//        } onCompleted: {
//            print("completed")
//        }
        // 接收3
//        observable.subscribe { element in
//            print("next", element)
//        } onError: { error in
//            print("error", error)
//        } onCompleted: {
//            print("completed")
//        } onDisposed: {
//            print("onDisposed")
//        }

        // 立即取消订阅（一次性订阅）
        observable.subscribe { event in
            print(event)
        }.dispose()
//
//        observable.subscribe { event in
//            print(event.element ?? 0)
//        }.disposed(by: bag)
    }

    func setupObserver() {
        let observer = AnyObserver<String>.init { event in
            switch event {
            case .next(let data):
                print(data)
            case .completed:
                print("completed")
            case .error(let error):
                print("error", error)
            }
        }
        Observable.just("给自定义observer").subscribe(observer).dispose()
    }

    func setupObserver2() {
        let binder = Binder<String>(label) { label, text in
            label.text = text
        }
        Observable.just(1).map { "数值是\($0)" }.subscribe(binder).dispose()
        Observable.just(1).map { "数值是\($0)" }.bind(to: binder).dispose()
    }

    func controlButtom() {
        // 直接传一个时间周期,每隔一秒钟
        // Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        let observable = Observable<Int>.timer(.seconds(2),
                                               period: .seconds(1),
                                               scheduler: MainScheduler.instance)

//        let binder = Binder<Bool>(button) { btn, value in
//            btn.isHidden = value
//        }
//        observable.map { $0 % 2 == 0 }.bind(to: binder).disposed(by: bag)
        observable.map { $0 % 2 == 0 }.bind(to: button.rx.myHidden).disposed(by: bag)
    }

    func monitorButton() {
        button.rx.tap.subscribe(onNext: {
            print("按钮被点击了1")
        }).disposed(by: bag)
        let _ = button.rx.controlEvent(.touchUpInside).subscribe(onNext: {
            print("按钮被点击了2")
        })
    }

    func monitorProperty() {
        let dog = Dog()
        dog.rx.observe(String.self, "name")
            .subscribe(onNext: { name in
                print("name is", name ?? "nil")
            }).disposed(by: bag)
        dog.name = "larry"
        dog.name = "乖乖"
    }

//    func monitorTable() {
//        let data = Observable.just([
//            Person(name: "Jack", age: 10),
//            Person(name: "Rose", age: 20)
//        ])
//        data.bind(to: tableView.rx.items(cellIdentifier: "cell")) { _, person, cell in
//            cell.textLabel?.text = person.name
//            cell.detailTextLabel?.text = "\(person.age)"
//        }.disposed(by: bag)
//        tableView.rx.modelSelected(Person.self)
//            .subscribe(onNext: { person in
//                print("点击了", person.name)
//            }).disposed(by: bag)
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
}

/*
 NotificationCenter.default.rx
     .notification(UIApplication.didEnterBackgroundNotification)
     .subscribe(onNext: { notification in
         print("APP进入后台", notification)
     })
     .disposed(by: bag)

 既是Observable，又是Observer
 诸如UISlider.rx.value、UTextField.rx.text这类属性值，既是Observable，又是Observer
 它们是RxCocoa.ControlProperty类型

 Observable.just(0.8).bind(to: slider.rx.value).dispose()

 slider.rx.value.map {
    "当前数值是：\($0)"
 }.bind(to: textField.rx.text).disposed(by: bag)

 textField.rx.text
     .subscribe(onNext: { text in
         print("text is", text ?? "nil")
     }).disposed(by: bag)

 */
