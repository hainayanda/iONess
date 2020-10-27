//
//  Thenable.swift
//  iONess
//
//  Created by Nayanda Haberty (ID) on 21/10/20.
//

import Foundation

public protocol Thenable {
    associatedtype Result
    associatedtype DropablePromise: Dropable
    
    @discardableResult
    func then(run closure: @escaping (Result) -> Void, whenFailed failClosure: @escaping (Result) -> Void) -> DropablePromise
    
    @discardableResult
    func then(run closure: @escaping (Result) -> Void) -> DropablePromise
    
    @discardableResult
    func then(run closure: @escaping (Result) -> Void, whenFailed failClosure: @escaping (Result) -> Void, finally deferClosure: @escaping (Result) -> Void) -> DropablePromise
}

public extension Thenable {
    @discardableResult
    func then(run closure: @escaping (Result) -> Void, whenFailed failClosure: @escaping (Result) -> Void, finally deferClosure: @escaping (Result) -> Void) -> DropablePromise {
        then(
            run: {
                closure($0)
                deferClosure($0)
            },
            whenFailed: {
                failClosure($0)
                deferClosure($0)
            }
        )
    }
}
