//
//  ArrayTool.swift
//  WS_Networing_Swift
//
//  Created by 王爽 on 2023/7/13.
//

import Foundation

protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}
func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}
/*
 func isArray(_ value: Any) -> Bool { value is [Any] }
 isArray( ["1", 2] )
 isArray( NSArray() )
 isArray( NSMutableArray() )
 */
func testType() {
    print(isArrayType([Int].self),
          isArrayType(String.self),
          isArrayType([Any].self),
          isArrayType(NSArray.self),
          isArrayType(NSMutableArray.self))
}

extension Array {
    mutating func removeAtIndexes (indexs:[Int]) -> () {
        for index in indexs.sorted(by: >) {
            self.remove(at: index)
        }
    }
    
    
}
