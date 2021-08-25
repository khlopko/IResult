//
//  ChangedIndices.swift
//

import Foundation

///
public struct ChangedIndices {

    ///
    public struct Snapshot {

        ///
        public var isEmpty: Bool { inserted.isEmpty && deleted.isEmpty && updated.isEmpty && moved.isEmpty }

        ///
        public let inserted: [IndexPath]

        ///
        public let deleted: [IndexPath]

        ///
        public let updated: [IndexPath]

        ///
        public let moved: [(from: IndexPath, to: IndexPath)]

        ///
        public func map(_ transform: (IndexPath) -> IndexPath) -> Snapshot {
            .init(
                inserted: inserted.map(transform),
                deleted: deleted.map(transform),
                updated: updated.map(transform),
                moved: moved.map { (transform($0), transform($1)) })
        }

    }

    ///
    public var inserted: [IndexPath] { _inserted.sorted(by: <) }
    private var _inserted: [IndexPath] = []

    ///
    public var deleted: [IndexPath] { _deleted.sorted(by: >) }
    private var _deleted: [IndexPath] = []

    ///
    public var updated: [IndexPath] { _updated.sorted(by: <) }
    private var _updated: [IndexPath] = []

    ///
    public var moved: [(from: IndexPath, to: IndexPath)] { _moved.sorted(by: { $0.from < $1.from }) }
    private var _moved: [(from: IndexPath, to: IndexPath)] = []
    private let indexPathTransform: (IndexPath) -> IndexPath

    ///
    public init(indexPathTransform: @escaping (IndexPath) -> IndexPath = { $0 }) {
        self.indexPathTransform = indexPathTransform
    }

    ///
    public mutating func add(type: ElementChangeType, indexPath: IndexPath?, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                _deleted.append(indexPathTransform(indexPath))
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                _inserted.append(indexPathTransform(newIndexPath))
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                _moved.append((indexPathTransform(indexPath), indexPathTransform(newIndexPath)))
            }
        case .update:
            if let indexPath = indexPath {
                _updated.append(indexPathTransform(indexPath))
            }
        }
    }

    ///
    public mutating func reset() {
        _inserted = []
        _deleted = []
        _updated = []
        _moved = []
    }

}
