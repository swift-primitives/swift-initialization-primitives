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
    /// A hand-written ``Initializing`` (active-producer) conformer: a stateless factory
    /// that produces `0` on each `make()`. Proves the active protocol is satisfiable by
    /// a nominal type (not only by the closure-backed ``Initialization/Witness``) and
    /// that `make()` is reusable through a borrow.
    public struct Zero: Initializing {
        public init() {}

        public func make() -> Int { 0 }
    }
}
