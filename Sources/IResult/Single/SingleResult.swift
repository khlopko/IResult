//
//  SingleResult.swift
//

import Combine

public protocol SingleResult {

    associatedtype Element

    var changePublisher: PassthroughSubject<ElementChangeType, Never> { get }

    var element: Element? { get }
    
}
