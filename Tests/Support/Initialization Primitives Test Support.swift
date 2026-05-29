//
//  Initialization Primitives Test Support.swift
//  swift-initialization-primitives
//
//  Shared test fixtures and generic helpers for the Initiable surface.
//

public import Initialization_Primitives

/// Namespace for test fixtures — concrete `Initiable` conformers and the
/// generic empty-construction helpers shared by the test target.
///
/// Fixtures live in Test Support (per [TEST-010] / [TEST-019]) so the test
/// target consumes them through a single `import
/// Initialization_Primitives_Test_Support`, and so generic file-scope helpers
/// stay out of files that also declare `@Test` functions.
public enum Fixture {}

extension Fixture {
    /// Generic empty-construction over any `Initiable` conformer.
    ///
    /// Exercises that `Initiable.init()` is callable through a generic
    /// constraint — the payoff of the shared capability: code that builds a
    /// fresh empty value without knowing the concrete type.
    public static func make<T: Initiable>() -> T {
        T()
    }

    /// Generic empty-construction admitting `~Copyable` conformers.
    ///
    /// Confirms the protocol's `~Copyable` suppression flows through a generic
    /// call site: a move-only growable discipline can still be constructed
    /// empty generically.
    public static func makeMoveOnly<T: Initiable & ~Copyable>() -> T {
        T()
    }
}
