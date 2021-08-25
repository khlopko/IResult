//
//  TypeErasure.swift
//

import Foundation
import Combine

// MARK: - Collection

public var collectionResultsTypeErasure: CollectionResultsTypeErasure = _DefaultCollectionResultsTypeErasure()

public protocol CollectionResultsTypeErasure {
    func box<R>(_ concrete: R) -> AnyCollectionResultsBase<R.Element> where R: CollectionResults
}

private struct _DefaultCollectionResultsTypeErasure: CollectionResultsTypeErasure {

    func box<R>(_ concrete: R) -> AnyCollectionResultsBase<R.Element> where R: CollectionResults {
        AnyCollectionResultsBox(concrete)
    }

}

open class AnyCollectionResultsBox<R>: AnyCollectionResultsBase<R.Element> where R: CollectionResults {

    public typealias Element = R.Element

    public override var changeType: CollectionResultsChangeType { concrete.changeType }
    public override var changePublisher: PassthroughSubject<CollectionResultsEvent, Never> { concrete.changePublisher }

    public override var isEmpty: Bool { concrete.isEmpty }
    public override var numberOfSections: Int { concrete.numberOfSections }
    public let concrete: R

    public init(_ concrete: R) {
        self.concrete = concrete
    }

    public override subscript(indexPath: IndexPath) -> Element { concrete[indexPath] }

    public override func numberOfElements(inSection section: Int) -> Int { concrete.numberOfElements(inSection: section) }

    public override func name(ofSection section: Int) -> String { concrete.name(ofSection: section) }

}

// MARK: - Single

public var singleResultTypeErasure: SingleResultTypeErasure = _DefaultSingleResultTypeErasure()

public protocol SingleResultTypeErasure {
    func box<R>(_ concrete: R) -> AnySingleResultBase<R.Element> where R: SingleResult
}

private struct _DefaultSingleResultTypeErasure: SingleResultTypeErasure {

    func box<R>(_ concrete: R) -> AnySingleResultBase<R.Element> where R: SingleResult {
        AnySingleResultBox(concrete)
    }

}

open class AnySingleResultBox<R>: AnySingleResultBase<R.Element> where R: SingleResult {

    public typealias Element = R.Element

    public override var changePublisher: PassthroughSubject<ElementChangeType, Never> { concrete.changePublisher }

    public override var element: Element? { concrete.element }
    public let concrete: R

    public init(_ concrete: R) {
        self.concrete = concrete
    }

}
