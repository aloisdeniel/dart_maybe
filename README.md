# maybe

No more null check with an dart equivalent of Maybe (Haskel, Elm) / Option (F#).

## Usage

The key is that you need to call the `Maybe.check<T>` method to access your potential value and you are forced to check its status.

```dart
// Defining a value
var maybe = Maybe<String>.some("hello world");
Maybe.when<String>(maybe, some: (v) {
    print(v); // "hello world"
});

// Defining nothing
maybe = Maybe<String>.nothing();
Maybe.when<String>(maybe, some: (v) {
    print(v); // not called!
});

// You can add a default value when nothing
maybe = Maybe<String>.some(null);
Maybe.when<String>(maybe, some: (v) {
        print(v); // "hello world"
    }, 
    defaultValue: () => "hello world");

// By default, null as value is considered as nothing
maybe = Maybe<String>.some(null);
Maybe.when<String>(maybe, some: (v) {
    print(v); // not called!
});

// ... but you can explictly activate null values
maybe = Maybe<String>.some(null, nullable: true);
Maybe.when<String>(maybe, some: (v) {
    print(v); // not called!
});
```