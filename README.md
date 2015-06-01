CoffeeLint No Explicit Parens
===============================
[![Build Status](https://travis-ci.org/tarruda/coffeelint-no-explicit-parens.png)](https://travis-ci.org/tarruda/coffeelint-no-explicit-parens)

[CoffeeLint](http://www.coffeelint.org/) plugin for prohibiting explicit parens in function calls.

Usage
-----

Install it:

```
$ npm install --save-dev coffeelint-no-explicit-parens
```

Use it:

```json
{
  "no_explicit_parens": {
    "module": "coffeelint-no-explicit-parens",
    "level": "ignore",
    "strict": true
  }
}
```


It is possible to use this rule with `no_implicit_parens` if both are configured
with `strict` set to `false`. This would lead to coffeelint enforcing a mixed
style for parens: Explicit for single line calls and implicit for multi line
calls. For example:

```coffee
# good
myFunction(a, b, c)
# good
myFunction a, ->
  console.log('hello!')
# good
myFunction(a, -> console.log('hello!'))
# bad
myFunction a, b, c
# bad
myFunction(a, ->
  console.log('hello!')
)
# bad
myFunction(a, -> console.log('hello!')
)
```
