public import Initialization_Primitives

extension Fixture {
    /// A growable discipline: starts empty (its `Initiable.init()`) and grows
    /// via its own `append`. Demonstrates the intended composition — `Initiable`
    /// supplies the shared empty constructor; the family supplies its own
    /// (non-shared) mutation primitive, which is deliberately *not* part of
    /// `Initiable`.
    public struct Bag: Initiable, Equatable {
        public var elements: [Int]

        public init() {
            self.elements = []
        }
    }
}

extension Fixture.Bag {
    /// Family-specific growth — the mutation half that `Initiable` does not
    /// declare.
    public mutating func append(_ element: Int) {
        elements.append(element)
    }
}
