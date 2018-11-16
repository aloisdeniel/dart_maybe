# maybe

[![Pub](https://img.shields.io/pub/v/maybe.svg)](https://pub.dartlang.org/packages/maybe)

No more null check with an dart equivalent of Maybe (Haskel, Elm) / Option (F#).

## Usage

The key is that you need to call the `some` or `when` to access your potential value so you are forced to check its status before using it.

### `Maybe<T>.nothing` : creating an optional item that is empty

```dart
final maybe = Maybe<String>.nothing();
```

### `Maybe.some` : creating an optional item with a value

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

### `isNothing` : testing if some value

```dart
final maybe = Maybe.some("hello world");
final value = isNothing(maybe); // false
```

```dart
final maybe = Maybe<String>.nothing();
final value = isNothing(maybe); // true
```

### `when` : triggering an action

```dart
var maybe = Maybe.some("hello world");
when(maybe, some: (v) {
    print(v); // "hello world"
});

// Defining nothing
maybe = Maybe.nothing();
when(maybe, some: (v) {
    print(v); // not called!
});

// You can add a default value when nothing
maybe = Maybe<String>.some(null);
when(maybe, some: (v) {
        print(v); // "hello world"
    }, 
    defaultValue: () => "hello world");
```

### `mapSome` : converts a value type to another

```dart
var maybe = Maybe.some("hello world");
var converted = mapSome<String,int>(maybe, (v) => v.length);
var value = some(converted,0); // == 11
```

```dart
var maybe = Maybe<String>.nothing();
var converted = mapSome<String,int>(maybe, (v) => v.length);
var value = some(converted, 0); // == 0
```

## What about quiver's `Optional` ?

The [Optional](https://github.com/google/quiver-dart/blob/master/lib/src/core/optional.dart) type has several similarities with `Maybe`, but there are several subtle differences.

### Optional can be `null`

Let's take a quick example :

```dart
class Update {
  final Optional<String> title;
  final Optional<String> description;

  Update({Optional<String> title, Optional<String> description})
      : this.title = title ?? Optional<String>.absent(),
        this.description = description ?? Optional<String>.absent();
}

final update = Update(title: Optional.of('sample'));

update.title.ifPresent((v) {
    print('title: $v');
});

update.description.ifPresent((v) {
    print('description: $v');
});
```

Thanks to static functions, all can be replaced by :

```dart
class Update {
  final Maybe<String> title;
  final Maybe<String> description;

  Update({this.title this.description});
}

final update = Update(title: Maybe.some('sample'));

when(update.title, some: (v) {
    print('title: $v');
});

when(update.description, some: (v) {
    print('description: $v');
});
```

So, the critical part is that you can forget that `Optional` can be `null` itself and produce exceptions (`update.title.ifPresent` in our example). You are then forced to test its nullity and you come back to the initial problematic. This is where `Maybe` feels more robust to me.

### `absent` is similar to `null`

With `Maybe`, values can be nullable.

In the following example, we explicitly say that the `title` should have a new `null` value.

```dart
class Update {
  final Optional<String> title;
  final Optional<String> description;

  Update({Optional<String> title, Optional<String> description})
      : this.title = title ?? Optional<String>.absent(),
        this.description = description ?? Optional<String>.absent();
}

final update = Update(title: Maybe.some(null, nullable: true);
```

This is really different than having a `nothing` description, which significates that the description shouldn't be modified.

```dart
final update = Update(title: Maybe.nothing();
```