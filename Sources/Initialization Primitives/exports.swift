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
//  exports.swift
//  swift-initialization-primitives
//
//  Umbrella re-export of the initialization-primitives surface. Downstream
//  `import Initialization_Primitives` resolves here and sees the whole domain:
//  the ``Initialization`` namespace, the active ``Initializing`` producer protocol,
//  the ``Initialization/Witness``, and the passive ``Initiable`` attachable.
//

@_exported public import Initiable
@_exported public import Initialization_Primitive
@_exported public import Initialization_Protocol
@_exported public import Initialization_Witness_Primitives
