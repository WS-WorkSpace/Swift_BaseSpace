//
//  RDBase.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/11/29.
//

import UIKit
import Foundation
public struct RDBase<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol JKPOPCompatible {}

public extension JKPOPCompatible {
    
    static var jk: RDBase<Self>.Type {
        get{ RDBase<Self>.self }
        set {}
    }
    
    var jk: RDBase<Self> {
        get { RDBase(self) }
        set {}
    }
}

/// Define Property protocol
internal protocol JKSwiftPropertyCompatible {
  
    /// Extended type
    associatedtype T
    
    ///Alias for callback function
    typealias SwiftCallBack = ((T?) -> ())
    
    ///Define the calculated properties of the closure type
    var swiftCallBack: SwiftCallBack?  { get set }
}
