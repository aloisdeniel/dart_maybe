# maybe

[![Pub](https://img.shields.io/pub/v/maybe.svg)](https://pub.dartlang.org/packages/maybe)

No more null check with an dart equivalent of Maybe (Haskel, Elm) / Option (F#).

## Usage

The key is that you need to call the `some` or `when` to access your potential value so you are forced to check its status before using it.

### `some` : extracting some value

```dart
final maybe = Maybe.some("hello world");
final value = some(maybe, "default"); // == "hello world"
```

```dart
final maybe = Maybe<String>.nothing();
final value = some(maybe, "default"); // == "default"
```

### `nothing` : testing if some value

```dart
final maybe = Maybe.some("hello world");
final value = nothing(maybe); // false
```

```dart
final maybe = Maybe<String>.nothing();
final value = nothing(maybe); // true
```

### `when` : triggering an action

```dart
// Defining a value
var maybe = Maybe.some("hello world");
when(maybe, iSome: (v) {
    print(v); // "hello world"
});

// Defining nothing
maybe = Maybe.nothing();
when(maybe, isSome: (v) {
    print(v); // not called!
});

// By default, null as value is considered as nothing
maybe = Maybe<String>.some(null);
when(maybe, isSome: (v) {
    print(v); // not called!
});

// ... but you can explictly activate null values
maybe = Maybe<String>.some(null, nullable: true);
when(maybe, isSome: (v) {
    print(v); // called with null
});

// You can add a default value when nothing
maybe = Maybe<String>.some(null);
when(maybe, isSome: (v) {
        print(v); // "hello world"
    }, 
    defaultValue: () => "hello world");
```