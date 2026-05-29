public import Initialization_Primitives

extension Fixture {
    /// The canonical `Initiable` shape for a Copyable value type: starts in its
    /// empty state (`count == 0`).
    public struct Empty: Initiable, Equatable {
        public var count: Int

        public init() {
            self.count = 0
        }
    }
}
