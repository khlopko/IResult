//
//  AnyCollectionResults.swift
//

import Foundation
import Combine

public struct AnyCollectionResults<T, E>: CollectionResults {

    public typealias Element = T

    public var changePublisher: PassthroughSubject<E, Never> { box.changePublisher }

    public var isEmpty: Bool { box.isEmpty }
    public var numberOfSections: Int { box.numberOfSections }

    public var startIndex: Index { box.startIndex }
    public var endIndex: Index { box.endIndex }

    public let box: AnyCollectionResultsBase<Element, E>

    public init<R>(
        _ concrete: R
    ) where R: CollectionResults, R.Element == Element, R.ChangeEvent == ChangeEvent {
        box = collectionResultsTypeErasure.box(concrete)
    }

    public subscript(indexPath: Index) -> Element { box[indexPath] }

    public func numberOfElements(inSection section: Int) -> Int { box.numberOfElements(inSection: section) }

    public func name(ofSection section: Int) -> String { box.name(ofSection: section) }

    public func index(before i: Index) -> Index { box.index(before: i) }

    public func index(after i: Index) -> Index { box.index(after: i) }

}

open class AnyCollectionResultsBase<T, E>: CollectionResults {

    public typealias Element = T

    public typealias ChangeEvent = E

    public var changePublisher: PassthroughSubject<E, Never> { fatalError() }

    public var isEmpty: Bool { fatalError() }
    public var numberOfSections: Int { fatalError() }

    public var startIndex: Index { fatalError() }
    public var endIndex: Index { fatalError() }

    public subscript(indexPath: Index) -> Element { fatalError() }

    public func numberOfElements(inSection section: Int) -> Int { fatalError() }

    public func name(ofSection section: Int) -> String { fatalError() }

    public func index(after i: Index) -> Index { fatalError() }

    public func index(before i: Index) -> Index { fatalError() }

}
