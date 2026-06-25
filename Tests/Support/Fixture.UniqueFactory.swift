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
    /// An ``Initializing`` (active-producer) conformer whose `Element` is **move-only**
    /// (`Fixture.Unique`). Compile-proves the headline capability that
    /// `Initialization.\`Protocol\`` admits `Element: ~Copyable` — a factory may
    /// *produce* move-only values, the case the closure-backed `Initialization.Witness`
    /// (Copyable-element-limited) cannot wrap, so it must be exercised through a direct
    /// conformer.
    public struct UniqueFactory: Initializing {
        public init() {}

        public func make() -> Fixture.Unique { Fixture.Unique() }
    }
}
