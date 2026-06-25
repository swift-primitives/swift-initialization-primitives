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
//  Initializing.swift
//  swift-initialization-primitives
//
//  The active gerund alias for the initialization producer protocol.
//

/// The active-capability gerund alias for ``Initialization/Protocol``.
///
/// Per `operation-domain-naming-and-organization.md` §4.1, the active producer
/// protocol is declared as the nested `Initialization.\`Protocol\`` and exported at
/// module scope under its gerund reading so conformance and constraint sites read as
/// English:
///
/// ```swift
/// struct ZeroFactory: Initializing {                       // "is initializing"
///     func make() -> Int { 0 }
/// }
///
/// func run<I: Initializing>(_ i: borrowing I) throws(I.Failure) -> I.Element {
///     try i.make()
/// }
/// ```
///
/// `Initialization.\`Protocol\`` remains the canonical declaration the alias targets.
/// Unlike `Iterator`, the initialization domain has **no** result-noun witness alias
/// (the result-noun `Initialization` is already the namespace; §5.2 gate 3 fails), so
/// `Initializing` is the domain's sole top-level operation alias.
public typealias Initializing = Initialization.`Protocol`
