//
//  FuntionalProgrammingViewController.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/18.
//

import UIKit

infix operator >>>: AdditionPrecedence
typealias Fn = (Int) -> Int
func add(_ a: Int) -> (Int) -> Int { { $0 + a }}
func sub(_ a: Int) -> (Int) -> Int {{ $0 - a }}
func multiple(_ a: Int) -> (Int) -> Int {{ $0 * a }}
func divide(_ a: Int) -> (Int) -> Int {{ $0 / a }}
func mod(_ a: Int) -> (Int) -> Int {{ $0 % a }}

// func >>>(_ fn1: @escaping (Int) -> Int, _ fn2: @escaping (Int) -> Int) -> (Int) -> Int {
//    { fn2(fn1($0)) }
// }

func >>> <A, B, C>(_ fn1: @escaping (A) -> B, _ fn2: @escaping (B) -> C) -> (A) -> C {
    { fn2(fn1($0)) }
}

//// 3+10-8
// let fn = add(10) >>> sub(5)
// print(fn(3)) // 8
//// (10-5)*4/2%4
// let fnM = add(10) >>> sub(5) >>> multiple(4) >>> divide(2) >>> mod(4)
// print(fnM(0)) // 2

//func test(_ m:Int, _ n:Int) -> Int{ m/2 + n/2 }
//
//prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
//    { b in { a in fn(a, b) } }
//}
//print((~test)(40)(60)) // 50


class FuntionalProgrammingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Funtional()
    }
    func Funtional() {
        let fn1 = add(10) // +10
        let fn2 = sub(5) // -5
        let fn3 = multiple(4) // *4
        let fn4 = divide(2) // /2
        let fn5 = mod(4) // %4

        // ((num + 10) - 5)*4/2%4
        let num = 0
        let fanalNum = fn5(fn4(fn3(fn2(fn1(num))))) //
        print(fanalNum)

//        compsite(fn1, fn2)(3) // 8
        let fn = add(10) >>> sub(5)
        // 3+10-8
        print(fn(3)) // 8
        // (10-5)*4/2%4
        let fnM = add(10) >>> sub(5) >>> multiple(4) >>> divide(2) >>> mod(4)
        print(fnM(0)) // 2
        
    }

//    func currying(_ v: Int) -> (Int) -> (Int) -> (Int) {
//        // a == 20
//        return { a in
//            //b == 10
//            return{ b in
//                return b + a + v
//            }
//        }
//    }
//    print(currying(10)(20)(30)) //60

    func currying<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
        { b in { a in fn(a, b) } }
    }

//    func add2(_ v1: Int, _ v2: Int, _ v3: Int) -> Int { v1 + v2 + v3 }
//    let curriedAdd2 = currying(add2)
//    print(curriedAdd2(10)(20)(30)) //60
//    func currying<A, B, C, D>(_ fn: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) -> D {
//        { c in { b in { a in fn(a, b, c) } } }
//    }

//    typealias Fn = (Int) -> Int
//    func add(_ a: Int) -> (Int) -> Int { { $0 + a }}
//    func sub(_ a: Int) -> (Int) -> Int {{ $0 - a }}
//    func multiple(_ a: Int) -> (Int) -> Int {{ $0 * a }}
//    func divide(_ a: Int) -> (Int) -> Int {{ $0 / a }}
//    func mod(_ a: Int) -> (Int) -> Int {{ $0 % a }}
//
//    // 函数合成
//    func compsite(_ fn1: @escaping Fn, _ fn2: @escaping Fn) -> Fn {
//        { fn2(fn1($0)) }
//    }

//    infix operator >>> : AdditionPrecedence

    //    typealias Fn = (Int) -> Int
    //    @discardableResult
    //    func add<T: AdditiveArithmetic>(_ a: T = 0) -> (T) -> T {
    //        return { (m: T) in
    //            m + a
    //        }
    //    }
}
