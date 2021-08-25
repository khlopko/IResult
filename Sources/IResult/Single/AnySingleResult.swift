//
//  AnySingleResult.swift
//

import Combine

public struct AnySingleResult<T>: SingleResult {

    public typealias Element = T

    public var changePublisher: PassthroughSubject<ElementChangeType, Never> { box.changePublisher }

    public var element: Element? { box.element }
    public let box: AnySingleResultBase<Element>

    public init<R>(_ concrete: R) where R: SingleResult, R.Element == Element {
        box = singleResultTypeErasure.box(concrete)
    }

}

open class AnySingleResultBase<T>: SingleResult {

    public typealias Element = T

    public var changePublisher: PassthroughSubject<ElementChangeType, Never> { fatalError() }

    public var element: Element? { fatalError() }

}
