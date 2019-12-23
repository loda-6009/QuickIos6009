//
//  RequestResult.swift
//  QuickIosComponent
//
//  Created by brownsoo han on 26/11/2018.
//

import Foundation

/// 요청 결과를 담은 모델.
/// 아래문서를 참고
/// http://alisoftware.github.io/swift/async/error/2016/02/06/async-errors/
public enum RequestResult<T> {
    case Success(T)
    case Failure(Error)
}

public extension RequestResult {
    func map<U>(f: (T)->U) -> RequestResult<U> {
        switch self {
        case .Success(let t): return .Success(f(t))
        case .Failure(let err): return .Failure(err)
        }
    }
    func flatMap<U>(f: (T)->RequestResult<U>) -> RequestResult<U> {
        switch self {
        case .Success(let t): return f(t)
        case .Failure(let err): return .Failure(err)
        }
    }
    // Return the value if it's a .Success
    // or throw the error if it's a .Failure
    func resolve() throws -> T {
        switch self {
        case RequestResult.Success(let value): return value
        case RequestResult.Failure(let error): throw error
        }
    }
    // Construct a .Success if the expression returns a value
    // or a .Failure if it throws
    init(_ throwable: () throws -> T) {
        do {
            let value = try throwable()
            self = RequestResult.Success(value)
        } catch {
            self = RequestResult.Failure(error)
        }
    }
}
