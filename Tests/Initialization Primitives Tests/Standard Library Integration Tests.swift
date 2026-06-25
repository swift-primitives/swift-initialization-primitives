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

import Initialization_Primitives_Standard_Library_Integration
import Initialization_Primitives_Test_Support
import Testing

@Suite
struct `Standard Library Integration Tests` {
    @Suite struct Unit {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `Standard Library Integration Tests`.Unit {

    @Test
    func `the growable collections conform and construct empty from the type alone`() {
        let array: [Int] = Fixture.make()
        let contiguous: ContiguousArray<Int> = Fixture.make()
        let slice: ArraySlice<Int> = Fixture.make()
        let set: Set<Int> = Fixture.make()
        let dictionary: [String: Int] = Fixture.make()
        let string: String = Fixture.make()
        let substring: Substring = Fixture.make()

        #expect(array.isEmpty)
        #expect(contiguous.isEmpty)
        #expect(slice.isEmpty)
        #expect(set.isEmpty)
        #expect(dictionary.isEmpty)
        #expect(string.isEmpty)
        #expect(substring.isEmpty)
    }
}

// MARK: - Integration

extension `Standard Library Integration Tests`.Integration {

    @Test
    func `a stdlib conformer's initializer-witness bridge produces a fresh empty value`() {
        let witness = [Int].initializer
        #expect(witness.make().isEmpty)
    }
}
