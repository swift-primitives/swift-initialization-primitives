# ``Initialization_Primitives``

@Metadata {
    @DisplayName("Initialization Primitives")
    @TitleHeading("Swift Institute — Primitives Layer")
}

The initialization operation domain — producing a value from nothing.

## Overview

`Initialization Primitives` is the umbrella over the **initialization** operation
domain. Initialization is a *relation/value* domain — a nullary value-producer that
carries no per-step state — so, per the ecosystem's operation-domain naming
(`operation-domain-naming-and-organization.md` §3), its namespace is the **deverbal
noun** ``Initialization`` rather than an agent noun, matching the package name.

The domain has the two protocols every operation domain has:

- **Passive** — ``Initiable`` ("can be constructed empty"), the top-level `-able`
  attachable declaring a single `init()`. It is the empty-construction half shared by
  every *growable discipline* — `Set`, `Array`, `Dictionary`. The *mutation* that makes
  a discipline grow (`insert`, `append`, `updateValue`) is family-specific and is
  deliberately not part of ``Initiable``.
- **Active** — ``Initializing`` (`Initialization.\`Protocol\``), a factory that produces
  a value via `make()`. Hold a type-erased factory as
  `Initialization.Witness<Element, Failure>`. Every `Copyable` ``Initiable`` type yields
  its canonical witness through the ``Initiable/initializer`` bridge.

### Typed throws

`init()` and `make()` are `throws(Failure)`, with `Failure` defaulting to `Never`.
Infallible construction (the common case) pays zero ceremony — `Failure` infers to
`Never` and no call site needs `try`; a fallible conformer carries a precise,
compiler-enforced typed error channel.

### Divergence from `Iterator`

The active surface mirrors `Iterator` in *naming* but diverges on the *contract*, because
a value-producer is a relation, not a stateful machine: `make()` is `borrowing` (not a
`mutating next()`), the element is `~Copyable` but not `~Escapable` and carries no
`@_lifetime`, and ``Initialization/Witness`` is plain `Copyable` (the opposite of
`Iterator.Witness`). There is no result-noun witness alias — the noun `Initialization`
is already the namespace.

`Initiable` suppresses `Copyable` so move-only growable disciplines conform; `Escapable`
is not suppressed. See ``Initiable`` for the full rationale.

## Topics

### Passive capability

- ``Initiable``

### Active producer

- ``Initialization``
- ``Initializing``
