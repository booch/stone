Collections
===========

When writing a program, we frequently want to work with multiple values at the same time.
A Collection is a set of values gathered together, that can be treated as a single value.
The individual elements of a Collection can be easily iterated through as well.


List
----

The simplest collection is a List.
As the name suggests, a List is an ordered set of items.
A List has a type specifier, which specifies the types of values within the List.
If the values in the List are all of different types, the type specifier will by Any.
You won't normally need to explicitly include the type specifier, but you'll see it in output.

~~~ stone
List()
#= List[Any]()

List(1, 2, 3)
#= List[Number.Integer](Number.Integer(1), Number.Integer(2), Number.Integer(3))

List(1, 1 + 1, 1 + 1 + 1)
#= List[Number.Integer](Number.Integer(1), Number.Integer(2), Number.Integer(3))

List(1, "abc", FALSE)
#= List[Any](Number.Integer(1), Text("abc"), Boolean(Boolean.FALSE))
~~~