//
//  Sample.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/5.
//

import UIKit
import WCDBSwift

final class Sample: TableCodable {
    var identifier: Int? = nil
    var description: String? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        case identifier
        case description
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(identifier, isPrimary: true)
        }
    }
}
