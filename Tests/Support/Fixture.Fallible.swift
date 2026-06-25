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
    /// A fallible `Initiable` conformer: its `init()` throws a typed error, binding
    /// `Failure == Fixture.Fallible.Failure`. Proves the typed-throws channel —
    /// `Failure != Never` requires `try` at the call site and through the
    /// ``Initiable/initializer`` bridge, while infallible conformers stay try-free.
    public struct Fallible: Initiable, Equatable {
        /// The typed error this conformer's construction reports.
        public enum Failure: Swift.Error, Equatable {
            case refused
        }

        /// Always fails — the fixture exists to exercise the throwing path.
        public init() throws(Failure) {
            throw .refused
        }
    }
}
