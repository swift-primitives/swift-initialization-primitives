# Initialization Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The **initialization** operation domain — producing a value from nothing. It pairs the passive "can be constructed empty" attachable `Initiable` (a single `init()`, shared by every growable discipline — `Set`, `Array`, `Dictionary`, …) with the active producer surface: the `Initialization` namespace, the `Initializing` protocol, and the closure-backed `Initialization.Witness`. Typed throws is first-class — `Failure == Never` means no `try`.

---

## Quick Start

Conform any type that has a canonical empty state to `Initiable`, then construct it generically — without the call site knowing the concrete type:

```swift
import Initialization_Primitives

struct Bag {
    var elements: [Int]

    init() {
        self.elements = []
    }
}

extension Bag: Initiable {}

func fresh<T: Initiable>() -> T { T() }

let bag: Bag = fresh()   // empty Bag, built from the type alone
```

The protocol suppresses `Copyable`, so move-only growable disciplines conform too — a constraint `RawRepresentable`-style "default value" protocols cannot express:

```swift
struct Buffer: ~Copyable, Initiable {
    var count: Int
    init() { self.count = 0 }
}

func fresh<T: Initiable & ~Copyable>() -> T { T() }

let buffer: Buffer = fresh()   // empty move-only Buffer
```

`Initiable` declares **only** empty construction. The mutation that makes a discipline grow — `insert`, `append`, `updateValue` — is family-specific and lives on the conforming type, not in this protocol.

### Typed throws — `Failure == Never` means no `try`

`init()` is `throws(Failure)`, with `Failure` defaulting to `Never`. Infallible empty construction pays zero ceremony; a conformer whose construction can fail carries a precise, compiler-enforced error channel:

```swift
struct Connection: Initiable {
    enum Failure: Error { case unavailable }
    init() throws(Failure) { throw .unavailable }   // binds Failure == Failure
}

let bag = Bag()                    // Failure == Never — no `try`
let conn = try Connection()        // fallible — `try` required, typed error
```

### The active producer — `Initialization.Witness`

The *passive* `Initiable` ("I can be made empty") has an *active* counterpart — `Initializing` (`Initialization.\`Protocol\``), a factory that produces a value via `make()`. Hold a type-erased factory as `Initialization.Witness<Element, Failure>`:

```swift
import Initialization_Primitives
import Initialization_Primitives_Standard_Library_Integration   // for Array: Initiable

let zero = Initialization.Witness<Int, Never> { 0 }
zero.make()                        // 0 — reusable, infallible, no `try`

// Every Copyable Initiable yields its canonical factory:
let factory = Array<Int>.initializer   // Initialization.Witness<[Int], Never>
factory.make()                         // []
```

Initialization is a *relation/value* operation domain, so the namespace is the deverbal noun `Initialization` (not an agent noun `Initializer`) and the witness is plain `Copyable` — the value-producing counterpart to `Iterator`'s stateful machine shape.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-initialization-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Initialization Primitives", package: "swift-initialization-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

The package follows the ecosystem's operation-domain layout (the same one `swift-iterator-primitives` uses), decomposed into focused products with zero external dependencies. Import the umbrella for everything, or a single leaf product for a minimal surface.

| Product | When to import |
|---------|----------------|
| `Initialization Primitives` | The umbrella — the whole domain. Resolves `import Initialization_Primitives` to the namespace, the active `Initializing` protocol, the `Initialization.Witness`, and the passive `Initiable`. |
| `Initiable` | The passive attachable alone — when you only declare or consume the "can be constructed empty" capability. |
| `Initialization Primitive` | The `Initialization` namespace enum alone. |
| `Initialization Protocol` | The active `Initialization.\`Protocol\`` producer + its gerund alias `Initializing`. |
| `Initialization Witness Primitives` | The closure-backed `Initialization.Witness<Element, Failure>`. |
| `Initialization Primitives Standard Library Integration` | Opt-in `Initiable` conformances for the stdlib growable disciplines (`Array`, `ContiguousArray`, `ArraySlice`, `Set`, `Dictionary`, `String`, `Substring`). Kept out of the umbrella so consumers choose the retroactive conformances. |
| `Initialization Primitives Test Support` | The `Initiable` conformer fixtures and the generic empty-construction helper, for test targets. |

`Initiable` is the domain's **passive** (`-able`) attachable, declared at top level — like every passive attachable (`Iterable`, `Parseable`) — because the capability is owned by no single domain: a `Set`, an `Array`, and a `Dictionary` are each `Initiable`, and none owns the protocol. The **active** producer surface lives under the `Initialization` namespace.

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
