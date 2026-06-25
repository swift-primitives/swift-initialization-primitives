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
//  Initialization Primitives Test Support.swift
//  swift-initialization-primitives
//
//  Shared test fixtures and generic helpers for the Initiable surface.
//

public import Initialization_Primitives

/// Namespace for test fixtures — concrete `Initiable` conformers and the
/// generic empty-construction helper shared by the test target.
///
/// Fixtures live in Test Support (per [TEST-010] / [TEST-019]) so the test
/// target consumes them through a single `import
/// Initialization_Primitives_Test_Support`, and so generic file-scope helpers
/// stay out of files that also declare `@Test` functions.
public enum Fixture {}

extension Fixture {
    /// Generic empty-construction over any `Initiable` conformer, copyable or
    /// move-only.
    ///
    /// The `~Copyable` constraint is a suppression, not a requirement: it admits
    /// both copyable conformers (which trivially satisfy it) and move-only ones.
    /// A single factory therefore covers both copyability quadrants and
    /// exercises the payoff of the shared capability — building a fresh empty
    /// value from the type alone, with no knowledge of the concrete type or its
    /// copyability.
    ///
    /// `throws(T.Failure)` threads the conformer's typed error channel through: an
    /// infallible conformer (`Failure == Never`) makes this call site need no `try`,
    /// while a fallible one propagates its precise error type.
    public static func make<T: Initiable & ~Copyable>() throws(T.Failure) -> T {
        try T()
    }
}
