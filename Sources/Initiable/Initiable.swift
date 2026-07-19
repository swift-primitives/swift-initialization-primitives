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
//  Initiable.swift
//  swift-initialization-primitives
//
//  The Initiable attachable — the cross-domain "can be constructed empty" capability.
//

/// A type that can be constructed in its canonical empty state.
///
/// `Initiable` declares one thing and one thing only: a parameterless `init()` that
/// produces the type's canonical empty value — the identity element (`mempty`) of the
/// type's grow operation, **not** an arbitrary default. It is the cross-domain capability
/// shared by every *growable discipline* — `Set`, `Array`, `Dictionary`, and any
/// other container that begins empty and grows. Conformers opt in to "you can make a
/// fresh empty one of me" without committing to any particular element type, storage,
/// or mutation surface.
///
/// `Initiable` is the **passive (`-able`) attachable** of the initialization operation
/// domain (`operation-domain-naming-and-organization.md` §4.2). Its active (`-ing`)
/// counterpart is ``Initializing`` (`Initialization.\`Protocol\``) — the producer of a
/// value from nothing. Like every passive attachable it is declared **top level**, not
/// nested under the ``Initialization`` namespace, because the capability is owned by no
/// single domain: a `Set` is `Initiable`, an `Array` is `Initiable`, a `Dictionary` is
/// `Initiable`; the protocol belongs to none of them.
///
/// ## Typed throws — `Failure`
///
/// `init()` is `throws(Failure)`, with `Failure` defaulting to `Never`. The common case
/// — empty construction that cannot fail (`Set()`, `Array()`, `""`) — pays zero
/// ceremony: `Failure` infers to `Never`, and no call site needs `try`. A conformer
/// whose construction *can* fail (resource acquisition, validation) declares
/// `init() throws(MyError)`, which binds `Failure == MyError` and requires `try` only
/// then. This is the same `Failure: Swift.Error = Never` idiom the active producer
/// ``Initializing`` and `Iterator.\`Protocol\`` carry.
///
/// ## What this protocol does *not* declare
///
/// The *mutation* that makes a discipline grow — `insert`, `append`, `updateValue` — is
/// **not** part of `Initiable`. Those operations are family-specific: their signatures
/// differ (an element for `Set`/`Array`, a key-value pair for `Dictionary`) and there
/// is no cross-domain shape that unifies them. Only empty construction is genuinely
/// shared, so only `init()` lives here. A discipline that wants both "start empty" and
/// "grow" composes `Initiable` with its own mutation primitive; this protocol
/// contributes the first half.
///
/// ## `~Copyable` conformers
///
/// The protocol suppresses `Copyable` so move-only growable disciplines can conform.
/// The ecosystem's growable containers are `~Copyable`-generic — a `Set` whose element
/// is itself `~Copyable` is a move-only `Set` — and such a container must still be able
/// to declare "you can make an empty one." Requiring `Copyable` would lock every
/// move-only discipline out of the shared capability, defeating the purpose. `Copyable`
/// conformers are admitted unchanged; the suppression only *widens* the conformer set.
///
/// `Escapable` is *not* suppressed: an `init()` with no parameters produces a value
/// from nothing, and a non-escapable value has no lifetime source to borrow from at
/// that point. Every realistic conformer (`Set`, `Array`, `Dictionary`) is escapable,
/// so requiring `Escapable` costs nothing and keeps the requirement expressible without
/// immortal-lifetime ceremony.
///
/// ## Conforming
///
/// ```swift
/// extension MyContainer: Initiable {
///     public init() {
///         // construct the empty container
///     }
/// }
/// ```
public protocol Initiable: ~Copyable {
    /// The error type.
    ///
    /// Defaults to `Never` for infallible empty construction, so a conformer
    /// with a non-throwing `init()` pays no ceremony and no call site needs
    /// `try`.
    associatedtype Failure: Swift.Error = Never

    /// Constructs the canonical empty value of this type.
    ///
    /// For a growable discipline this is the empty container — `Set()`, `Array()`,
    /// `Dictionary()` — the starting point a value grows from.
    ///
    /// - Throws: `Failure` if construction can fail; nothing when `Failure == Never`.
    init() throws(Failure)
}
