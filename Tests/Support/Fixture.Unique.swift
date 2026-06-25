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
    /// A move-only (`~Copyable`) `Initiable` conformer. Its existence proves the
    /// protocol's `~Copyable` suppression admits non-copyable growable
    /// disciplines — a `Copyable`-requiring `Initiable` would reject this type.
    public struct Unique: ~Copyable, Initiable {
        /// Element count — `0` in the empty state a fresh value starts from.
        public var count: Int

        /// Constructs the empty value (`count == 0`).
        public init() {
            self.count = 0
        }
    }
}
