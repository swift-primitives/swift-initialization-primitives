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

//
//  Initiable.Bridge.swift
//  swift-initialization-primitives
//
//  The passive→active bridge: every Copyable Initiable yields a canonical witness.
//

extension Initiable where Self: Copyable {
    /// The canonical initializer for this type — a witness that produces a fresh empty
    /// value by calling `init()`.
    ///
    /// This is the passive→active bridge of the initialization domain: every `Copyable`
    /// ``Initiable`` type yields an `Initialization.Witness<Self, Failure>` you can
    /// hold, store, and pass as a first-class factory. It is the initialization
    /// counterpart to `Iterable.makeIterator()` — but `static`, because empty
    /// construction is type-level (the empty `Set` is the same for every `Set` value),
    /// paralleling `Parseable.parser` (`operation-domain-naming-and-organization.md`
    /// §4.2).
    ///
    /// ## Gated on `Copyable`
    ///
    /// The bridge requires `Self: Copyable` because the closure-backed witness captures
    /// a `() -> Self` thunk, which closure capture cannot form for a move-only `Self`.
    /// `~Copyable` conformers remain fully ``Initiable`` and construct directly via
    /// `init()`; they simply have no closure-erased witness — the same
    /// `Copyable`-element limitation ``Initialization/Witness`` documents.
    @inlinable
    public static var initializer: Initialization.Witness<Self, Failure> {
        Initialization.Witness { () throws(Self.Failure) -> Self in
            try Self()
        }
    }
}
