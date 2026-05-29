//
//  Initiable.swift
//  swift-initialization-primitives
//
//  The Initiable attachable — the cross-domain "can be constructed empty" capability.
//

/// A type that can be constructed in its canonical empty state.
///
/// `Initiable` declares one thing and one thing only: a parameterless `init()`
/// that produces the type's empty (or default) value. It is the cross-domain
/// capability shared by every *growable discipline* — `Set`, `Array`,
/// `Dictionary`, and any other container that begins empty and grows. Conformers
/// opt in to "you can make a fresh empty one of me" without committing to any
/// particular element type, storage, or mutation surface.
///
/// `Initiable` is declared at top level — an `-able` attachable adjective, like
/// `Iterable` — rather than nested under a namespace, because the capability is
/// not owned by any one domain. A `Set` is `Initiable`, an `Array` is `Initiable`,
/// a `Dictionary` is `Initiable`; the protocol belongs to none of them.
///
/// ## What this protocol does *not* declare
///
/// The *mutation* that makes a discipline grow — `insert`, `append`,
/// `updateValue` — is **not** part of `Initiable`. Those operations are
/// family-specific: their signatures differ (an element for `Set`/`Array`, a
/// key-value pair for `Dictionary`) and there is no cross-domain shape that
/// unifies them. Only empty construction is genuinely shared, so only `init()`
/// lives here. A discipline that wants both "start empty" and "grow" composes
/// `Initiable` with its own mutation primitive; this protocol contributes the
/// first half.
///
/// ## `~Copyable` conformers
///
/// The protocol suppresses `Copyable` so move-only growable disciplines can
/// conform. The ecosystem's growable containers are `~Copyable`-generic — a
/// `Set` whose element is itself `~Copyable` is a move-only `Set` — and such a
/// container must still be able to declare "you can make an empty one." Requiring
/// `Copyable` would lock every move-only discipline out of the shared capability,
/// defeating the purpose. `Copyable` conformers are admitted unchanged; the
/// suppression only *widens* the conformer set.
///
/// `Escapable` is *not* suppressed: an `init()` with no parameters produces a
/// value from nothing, and a non-escapable value has no lifetime source to borrow
/// from at that point. Every realistic conformer (`Set`, `Array`, `Dictionary`)
/// is escapable, so requiring `Escapable` costs nothing and keeps the requirement
/// expressible without immortal-lifetime ceremony.
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
    /// Constructs the canonical empty value of this type.
    ///
    /// For a growable discipline this is the empty container — `Set()`,
    /// `Array()`, `Dictionary()` — the starting point a value grows from.
    init()
}
