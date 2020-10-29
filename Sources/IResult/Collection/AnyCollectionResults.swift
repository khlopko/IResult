//
//  AnyCollectionResults.swift
//

import Foundation
import Combine

public struct AnyCollectionResults<T>: CollectionResults {

    public typealias Element = T

    public var changeType: CollectionResultsChangeType { box.changeType }
    public var changePublisher: PassthroughSubject<CollectionResultsEvent, Never> { box.changePublisher }

    public var isEmpty: Bool { box.isEmpty }
    public var numberOfSections: Int { box.numberOfSections }
    public let box: AnyCollectionResultsBase<Element>

    public init<R>(_ concrete: R) where R: CollectionResults, R.Element == Element {
        box = collectionResultsTypeErasure.box(concrete)
    }

    public subscript(indexPath: Index) -> Element { box[indexPath] }

    public func numberOfElements(inSection section: Int) -> Int { box.numberOfElements(inSection: section) }

    public func name(ofSection section: Int) -> String { box.name(ofSection: section) }

}

open class AnyCollectionResultsBase<T>: CollectionResults {

    public typealias Element = T

    public var changeType: CollectionResultsChangeType { fatalError() }
    public var changePublisher: PassthroughSubject<CollectionResultsEvent, Never> { fatalError() }

    public var isEmpty: Bool { fatalError() }
    public var numberOfSections: Int { fatalError() }

    public subscript(indexPath: Index) -> Element { fatalError() }

    public func numberOfElements(inSection section: Int) -> Int { fatalError() }

    public func name(ofSection section: Int) -> String { fatalError() }

}
