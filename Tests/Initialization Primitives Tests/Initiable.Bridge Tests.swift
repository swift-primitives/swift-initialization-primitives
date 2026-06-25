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

import Initialization_Primitives_Test_Support
import Testing

@Suite
struct `Initiable Bridge Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
}

// MARK: - Unit

extension `Initiable Bridge Tests`.Unit {

    @Test
    func `a Copyable Initiable yields a canonical initializer witness`() {
        let witness = Fixture.Empty.initializer
        #expect(witness.make() == Fixture.Empty())
    }

    @Test
    func `the bridge witness produces a fresh empty value on each call`() {
        let witness = Fixture.Bag.initializer
        var made = witness.make()
        made.append(1)
        // A second call is unaffected by mutation of the first product.
        #expect(witness.make().elements.isEmpty)
    }
}

// MARK: - Edge Case

extension `Initiable Bridge Tests`.`Edge Case` {

    @Test
    func `a fallible conformer requires try and surfaces its typed error`() {
        #expect(throws: Fixture.Fallible.Failure.refused) {
            _ = try Fixture.Fallible()
        }
    }

    @Test
    func `the generic factory threads a fallible conformer's typed error`() {
        #expect(throws: Fixture.Fallible.Failure.refused) {
            let _: Fixture.Fallible = try Fixture.make()
        }
    }

    @Test
    func `a fallible Initiable's initializer witness propagates the typed error`() {
        let witness = Fixture.Fallible.initializer
        #expect(throws: Fixture.Fallible.Failure.refused) {
            try witness.make()
        }
    }
}
