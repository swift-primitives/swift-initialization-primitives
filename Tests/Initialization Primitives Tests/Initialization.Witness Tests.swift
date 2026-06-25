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
struct `Initialization.Witness Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

// MARK: - Unit

extension `Initialization.Witness Tests`.Unit {

    @Test
    func `an infallible witness produces its value with no try`() {
        let witness = Initialization.Witness<Int, Never> { 42 }
        #expect(witness.make() == 42)
    }

    @Test
    func `a stateless witness is reusable across repeated make calls`() {
        let witness = Initialization.Witness<[Int], Never> { [] }
        let first = witness.make()
        let second = witness.make()
        #expect(first == second)
        #expect(first.isEmpty)
    }

    @Test
    func `the witness is Copyable and lives in a collection`() {
        let factories = [
            Initialization.Witness<Int, Never> { 1 },
            Initialization.Witness<Int, Never> { 2 },
        ]
        #expect(factories.map { $0.make() } == [1, 2])
    }
}

// MARK: - Edge Case

extension `Initialization.Witness Tests`.`Edge Case` {

    @Test
    func `a fallible witness propagates its typed error`() {
        let witness = Initialization.Witness<Int, Fixture.Fallible.Failure> {
            () throws(Fixture.Fallible.Failure) -> Int in
            throw .refused
        }
        #expect(throws: Fixture.Fallible.Failure.refused) {
            try witness.make()
        }
    }
}

// MARK: - Integration

extension `Initialization.Witness Tests`.Integration {

    @Test
    func `the witness type-erases a conforming factory`() {
        let erased = Initialization.Witness(Fixture.Zero())
        #expect(erased.make() == 0)
    }

    @Test
    func `a custom Initializing conformer produces through the gerund-aliased protocol`() {
        func run<I: Initializing>(_ factory: borrowing I) throws(I.Failure) -> I.Element {
            try factory.make()
        }
        #expect(run(Fixture.Zero()) == 0)
    }

    @Test
    func `a custom Initializing conformer produces a move-only Element`() {
        let factory = Fixture.UniqueFactory()
        let made = factory.make()
        #expect(made.count == 0)
    }
}
