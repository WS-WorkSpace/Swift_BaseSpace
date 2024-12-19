//
//  CustomClosure.swift
//  Swift_Base
//
//  Created by 王爽 on 2024/12/19.
//

import Foundation

/// View的闭包
public typealias ViewClosure = ((UITapGestureRecognizer?, UIView, NSInteger) ->Void)
/// 手势的闭包
public typealias RecognizerClosure = ((UIGestureRecognizer) ->Void)
/// UIControl闭包
public typealias ControlClosure = ((UIControl) ->Void)
