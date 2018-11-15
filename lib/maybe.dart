/**
 * The [Maybe] type encapsulates an optional value. A value of 
 * type [Maybe] a either contains a value of type T (built with
 * [Maybe.just]), or it is empty (built with [Maybe.nothing]). 
 */
class Maybe<T> {
  bool _isNothing;
  final T _value;

  /**
   * An empty value.
   */
  Maybe.nothing()
      : this._isNothing = true,
        this._value = null;

  /**
   * Some [value]. 
   * 
   * If [nullable], considered as [nothing] if [value] is null.
   * 
   * If [nothingWhen], considered as [nothing] when predicate is verified.
   */
  Maybe.some(this._value, {bool nullable = false, bool nothingWhen(T value)})
      : this._isNothing = (!nullable && _value == null) ||
            (nothingWhen != null && nothingWhen(_value));

  /**
   * Tests the [maybe] status : executes [some] if it contains a value, [nothing] if not.
   * 
   * When adding [defaultValue], [some] is called with the value instead of [nothing].
   */
  static void when<T>(Maybe<T> maybe,
      {MaybeNothing nothing, MaybeSome<T> some, MaybeDefault<T> defaultValue}) {
    if ((maybe == null || maybe._isNothing) && nothing != null) {
      if (defaultValue != null) {
        some(defaultValue());
      } else {
        nothing();
      }
    } else if (!maybe._isNothing && some != null) {
      some(maybe._value);
    }
  }

  /**
   *  Flattens two nested [maybe] into one. 
   */
  static Maybe<T> flatten<T>(Maybe<Maybe<T>> maybe) {
    if(maybe == null || maybe._isNothing) {
      return Maybe.nothing();
    }

    return maybe._value;
  }

  /**
   * Returns a new lazy [Iterable] with all elements in [maybeIterable] that contain a value.
   *
   * The matching elements have the same order in the returned iterable
   * as they have in [iterator].
   */
  static Iterable<T> filter<T>(Iterable<Maybe<T>> maybeIterable) {
    return (maybeIterable == null)
        ? Iterable.empty<T>()
        : maybeIterable
            .where((v) => v != null && !v._isNothing)
            .map((v) => v._value);
  }

  /**
   * Applies the function [f] to each element that isn't nothing of [maybeIterable] collection 
   * in iteration order.
   */
  static void forEach<T>(Iterable<Maybe<T>> maybeIterable, void f(T element)) {
    if (maybeIterable == null) {
      maybeIterable
          .where((v) => v != null && !v._isNothing)
          .map((v) => v._value)
          .forEach(f);
    }
  }

  /**
   * Returns the number of elements in [maybeIterable].
   */
  static int count<T>(Iterable<Maybe<T>> maybeList) {
    return (maybeList == null)
        ? 0
        : maybeList.where((v) => v != null && !v._isNothing).length;
  }
}

typedef void MaybeNothing();

typedef void MaybeSome<T>(T value);

typedef T MaybeDefault<T>();
