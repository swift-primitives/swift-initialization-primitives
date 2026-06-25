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
//  Array+Initiable.swift
//  swift-initialization-primitives
//
//  Standard-library integration: Array is a growable discipline that begins empty.
//

public import Initiable

/// `Array` begins in its canonical empty state via the standard library's
/// parameterless `init()`. The conformance is infallible, so `Failure` infers to
/// `Never` and no call site needs `try`.
extension Array: Initiable {}
