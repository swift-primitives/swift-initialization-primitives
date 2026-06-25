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
//  Initialization.swift
//  swift-initialization-primitives
//
//  The Initialization namespace — the relation/value operation domain for
//  producing a value from nothing.
//

/// Namespace for the initialization operation domain.
///
/// `Initialization` is the **deverbal-noun** namespace of a *relation/value*
/// operation domain (`operation-domain-naming-and-organization.md` §3). Producing a
/// value from nothing carries no per-step mutable state you drive, so — unlike the
/// *machine* domains `Iterator` and `Parser`, which take an agent noun — initialization
/// takes the deverbal noun `Initialization`. This also matches the package name, so
/// the namespace costs no rename.
///
/// It hosts the active producer protocol ``Initialization/Protocol`` (exported under
/// the gerund alias ``Initializing``) and the closure-backed type-erased
/// ``Initialization/Witness``. The *passive* attachable ``Initiable`` — "can be
/// constructed empty" — lives at top level, as every `-able` passive protocol does.
///
/// ## No result-noun witness alias
///
/// Per §5.2, a witness gains a top-level result-noun alias only when its deverbal
/// result-noun is *free* in the ecosystem. The result-noun of *initialize* is
/// `Initialization` — already consumed by this namespace — so gate 3 ("free in the
/// ecosystem") fails and there is **no** alias (this is the `Parser.Witness` /
/// `Coder.Witness` row of §5.2's table, not the `Iteration` row). Consumers hold
/// `Initialization.Witness<Element, Failure>` directly.
public enum Initialization {}
