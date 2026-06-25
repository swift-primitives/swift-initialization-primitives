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
//  Initialization.Witness.swift
//  swift-initialization-primitives
//
//  The closure-backed initializer witness — nested `Namespace.Witness` form.
//

extension Initialization {
    /// The type-erased initializer witness.
    ///
    /// `Initialization.Witness<Element, Failure>` is a closure-backed implementation
    /// of ``Initialization/Protocol``, for wrapping any factory behind a single
    /// nominal type or constructing a factory directly from a `make()`-shaped closure.
    ///
    /// ## Witness naming — `Namespace.Witness`, no result-noun alias
    ///
    /// Per `operation-domain-naming-and-organization.md` §5, the canonical type-erased
    /// witness is nested as `Namespace.Witness`. The result-noun `Initialization` is
    /// already the namespace, so §5.2 gate 3 ("free in the ecosystem") fails and there
    /// is **no** top-level alias — consumers hold `Initialization.Witness<Element, Failure>`
    /// directly (the `Parser.Witness` row of §5.2's table).
    ///
    /// ## Copyable — the opposite of `Iterator.Witness`
    ///
    /// A nullary factory is a stateless value you store, copy, and call repeatedly, so
    /// the witness is plain `Copyable` (it may live in an `Array`, be reused, …). This
    /// is the relation/value counterpart to `Iterator.Witness`'s `~Copyable`
    /// (single-pass, affine) shape — copyability tracks the machine/relation split.
    ///
    /// ## Copyable-element limitation
    ///
    /// Closure-backed storage limits `Element` to types Swift's closure-capture
    /// machinery accepts. Factories producing move-only or non-escaping elements should
    /// conform to ``Initialization/Protocol`` directly rather than going through the
    /// witness.
    public struct Witness<Element, Failure: Swift.Error>: Initialization.`Protocol` {
        @usableFromInline
        internal let _make: () throws(Failure) -> Element

        /// Construct an initializer from a `make()`-shaped closure.
        ///
        /// A throwing closure must annotate its thrown type — `Initialization.Witness { () throws(MyError) in … }`
        /// — otherwise the closure widens to an untyped (existential) throw and fails to
        /// convert to the typed `Failure` channel.
        @inlinable
        public init(_ make: @escaping () throws(Failure) -> Element) {
            self._make = make
        }
    }
}

extension Initialization.Witness {
    /// Produce a value by invoking the wrapped factory closure.
    ///
    /// Calls the captured `make()`-shaped closure and returns its result, propagating
    /// the typed `Failure` on the conformer's error channel.
    @inlinable
    public borrowing func make() throws(Failure) -> Element {
        try _make()
    }
}

extension Initialization.Witness {
    /// Construct an initializer by type-erasing any conforming factory.
    ///
    /// The source factory must itself admit closure capture (`Copyable`). For
    /// `~Copyable` factories, conform to ``Initialization/Protocol`` directly.
    @inlinable
    public init<Source: Initialization.`Protocol`>(_ source: Source)
    where Source.Element == Element, Source.Failure == Failure {
        self.init { () throws(Failure) -> Element in
            try source.make()
        }
    }
}
