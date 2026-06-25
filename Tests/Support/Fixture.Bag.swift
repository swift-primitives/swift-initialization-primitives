// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import Initialization_Primitives

extension Fixture {
    /// A growable discipline: starts empty (its `Initiable.init()`) and grows
    /// via its own `append`. Demonstrates the intended composition — `Initiable`
    /// supplies the shared empty constructor; the family supplies its own
    /// (non-shared) mutation primitive, which is deliberately *not* part of
    /// `Initiable`.
    public struct Bag: Initiable, Equatable {
        /// The collected elements — empty in a freshly-constructed `Bag`.
        public var elements: [Int]

        /// Constructs the empty `Bag` (no elements).
        public init() {
            self.elements = []
        }
    }
}

extension Fixture.Bag {
    /// Family-specific growth — the mutation half that `Initiable` does not
    /// declare.
    public mutating func append(_ element: Int) {
        elements.append(element)
    }
}
