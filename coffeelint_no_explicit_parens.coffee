module.exports = class NoExplicitParens

  rule:
    name: 'no_explicit_parens'
    strict: true
    level: 'ignore'
    message: 'Explicit parens are forbidden'
    description: """
      This rule prohibits explicit parens on function calls.
      <pre>
      <code># Some folks don't like this style of coding.
      myFunction(a, b, c)
      myFunction()
      myFunction(a, ->
        console.log(a)
      )
      # And would rather it always be written like this:
      myFunction a, b, c
      do myFunction
      myFunction a, ->
        console.log(a)
      </code>
      </pre>
      Explicit parens are permitted by default, since sometimes they can
      improve readability. If strict is false, function calls contained in one
      line are allowed to have explicit parens.
      """

  tokens: ['CALL_END']

  lintToken: (token, tokenApi) ->
    if not token.generated and tokenApi.config[@rule.name].strict
      return true

    i = -1
    line = token[2].first_line
    while t = tokenApi.peek(i)
      # Check previous tokens until CALL_START is found.
      if t[0] is 'CALL_START'
        # If the call started on the same line, allow it.
        return line isnt t[2].first_line
      i--
