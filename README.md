# maybe

[![Pub](https://img.shields.io/pub/v/maybe.svg)](https://pub.dartlang.org/packages/maybe)

No more null check with an dart equivalent of Maybe (Haskel, Elm) / Option (F#).

## Usage

The key is that you need to call the `some` or `when` to access your potential value so you are forced to check its status before using it.

### `Maybe<T>.nothing` : creating an optionnal item that is empty

```dart
final maybe = Maybe<String>.nothing();
```

### `Maybe.some` : creating an optionnal item with a value

```dart
final maybe = Maybe.some("hello world");
```

```dart
final isNothing = Maybe<String>.some(null); // By default `some` with a null value is converted to `nothing`
final isNotNothing = Maybe<String>.some(null, nullable: true);
```

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
var maybe = Maybe.some("hello world");
when(maybe, iSome: (v) {
    print(v); // "hello world"
});

// Defining nothing
maybe = Maybe.nothing();
when(maybe, isSome: (v) {
    print(v); // not called!
});

// You can add a default value when nothing
maybe = Maybe<String>.some(null);
when(maybe, isSome: (v) {
        print(v); // "hello world"
    }, 
    defaultValue: () => "hello world");
```

### `map` : converts a value type to another

```dart
var maybe = Maybe.some("hello world");
var converted = map<String,int>(maybe, (v) => v.length);
var value = some(converted,0); // == 11
```

```dart
var maybe = Maybe<String>.nothing();
var converted = map<String,int>(maybe, (v) => v.length);
var value = some(converted, 0); // == 0
```