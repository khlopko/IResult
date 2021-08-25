//
//  CollectionResults.swift
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import Foundation
import Combine

///
public enum CollectionResultsChangeType {

    ///
    case indexes

    ///
    case snapshot

}

///
public enum CollectionResultsEvent {

    ///
    case will

#if canImport(UIKit) || canImport(AppKit)
    ///
    case snapshot(NSDiffableDataSourceSnapshotReference)
#endif

    case indexes(ChangedIndices)

    ///
    case did

}

/// A type that provides access to the collection of result elements
public protocol CollectionResults {

    /// A type that represents a position in the collection.
    typealias Index = IndexPath

    /// A type representing collection's element.
    associatedtype Element

    /// A type of change used in `CollectionResultsEvent`.
    var changeType: CollectionResultsChangeType { get }

    /// A Combine publisher, which publishes collection events.
    var changePublisher: PassthroughSubject<CollectionResultsEvent, Never> { get }

    /// A Boolean value indicating whether the collection is empty.
    var isEmpty: Bool { get }

    /// The number of sections in collection.
    var numberOfSections: Int { get }

    /// - parameters:
    ///     - position: `Index` of element in collection.
    ///
    /// - returns: An element at given `Index`.
    subscript(position: Index) -> Element { get }

    /// - parameters:
    ///     - section: Index of section in collection.
    ///
    /// - returns: The number of elements at given section.
    func numberOfElements(inSection section: Int) -> Int

    /// - parameters:
    ///     - section: Index of section in collection.
    ///
    /// - returns: Name of section at given index.
    func name(ofSection section: Int) -> String

}
