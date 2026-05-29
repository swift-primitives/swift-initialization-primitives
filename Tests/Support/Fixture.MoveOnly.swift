public import Initialization_Primitives

extension Fixture {
    /// A move-only `Initiable` conformer. Its existence proves the protocol's
    /// `~Copyable` suppression admits non-copyable growable disciplines — a
    /// `Copyable`-requiring `Initiable` would reject this type.
    public struct MoveOnly: ~Copyable, Initiable {
        public var count: Int

        public init() {
            self.count = 0
        }
    }
}
