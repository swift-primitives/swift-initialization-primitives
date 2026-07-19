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
//  Initialization.Protocol.swift
//  swift-initialization-primitives
//

extension Initialization {
    /// The initialization protocol — the active producer of a value from nothing.
    ///
    /// A type conforming to `Initialization.\`Protocol\`` produces an `Element` on
    /// demand via ``make()``. It is the active (`-ing`) capability of the
    /// initialization domain, exported under the gerund alias ``Initializing``; its
    /// passive (`-able`) counterpart is ``Initiable``.
    ///
    /// ## Maximum permissive shape — and where it diverges from `Iterator`
    ///
    /// `Element` suppresses `Copyable`, so a factory may produce move-only values.
    /// Four shapes deliberately **diverge** from the `Iterator.\`Protocol\`` template —
    /// each forced by the fact that initialization is a *relation/value*, not a
    /// *machine* (these are contract-axis choices, which the naming spec leaves to the
    /// protocol-architecture axis; they are recorded so they are not "corrected" back
    /// toward the iterator shape):
    ///
    /// 1. **No `~Escapable` suppression and no `@_lifetime`.** A value produced from
    ///    nothing has no `self`-state to borrow a lifetime from; the lifetime-dependent
    ///    `~Escapable`-element shape does not type-check for a nullary producer.
    /// 2. **`borrowing func make()`, not `mutating func next()`.** A factory holds no
    ///    per-step state to advance, so it is invoked through a borrow and may be reused.
    /// 3. The witness (``Initialization/Witness``) is plain `Copyable`, the opposite of
    ///    `Iterator.Witness`.
    /// 4. The produce method is `make()`, not a domain-specific verb.
    ///
    /// `Failure` defaults to `Never` for infallible factories; a fallible factory
    /// (resource acquisition, validation) carries a typed error channel, and only then
    /// does a call site require `try`.
    public protocol `Protocol`<Element, Failure>: ~Copyable {
        /// The type of value this initializer produces.
        associatedtype Element: ~Copyable

        /// The error type.
        ///
        /// Defaults to `Never` for infallible initializers.
        associatedtype Failure: Swift.Error = Never

        /// Produce a value.
        ///
        /// `borrowing`: the factory is stateless, so it survives the call and may be
        /// invoked repeatedly.
        ///
        /// - Returns: a freshly produced `Element`.
        /// - Throws: `Failure` if production fails.
        borrowing func make() throws(Failure) -> Element
    }
}
