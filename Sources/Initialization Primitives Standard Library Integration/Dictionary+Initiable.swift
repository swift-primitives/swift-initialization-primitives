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
//  Dictionary+Initiable.swift
//  swift-initialization-primitives
//

public import Initiable

/// `Dictionary` begins in its canonical empty state via the standard library's
/// parameterless `init()`. Infallible, so `Failure` infers to `Never`.
extension Dictionary: Initiable {}
