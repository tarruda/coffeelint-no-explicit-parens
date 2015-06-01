assert = require('assert')
coffeelint = require('coffeelint')
{expect} = require('chai')
NoExplicitParens = require('../coffeelint_no_explicit_parens')

coffeelint.registerRule NoExplicitParens


describe 'No explicit parens', ->
  suite = (title, strict, succeed, tests) ->
    config = {
      no_explicit_parens: {
        strict: strict
        level: 'error'
      }
    }

    result = if succeed then 'succeeded' else 'failed'
    i = 1

    for code in tests
      do (code) ->
        it "#{title} #{i++} #{result}", ->
          errors = coffeelint.lint(code, config)
          if succeed
            expect(errors).to.be.empty
          else
            expect(errors).to.not.be.empty

  suite 'single line strict parens', true, false, [
    'myFunction(a1, a2)'
    'myFunction(a1, myFunction2())'
    'myFunction(a1, myFunction2(func()))'
  ]

  suite 'single line strict no parens', true, true, ['myFunction a1, a2']

  suite 'multi line strict parens', true, false, [
    '''
    myFunction(a1, a2,
      a3)
    '''

    '''
    myFunction(a1,
      a2,
      a3)
    '''

    '''
    myFunction(
      a1,
      a2,
      a3)
    '''

    '''
    myFunction(
      a1,
      a2,
      a3
    )
    '''

    '''
    myFunction(
      a1,
      a2,
      a3,
      myFunction2(a21, a22))
    '''

    '''
    myFunction(
      a1,
      a2,
      a3,
      myFunction2(a21, func()))
    '''
  ]

  suite 'single line no strict parens', false, true, [
    'myFunction(a1, a2)'
    'myFunction(a1, myFunction2())'
    'myFunction(a1, myFunction2(func()))'
  ]

  suite 'single line no strict no parens', false, true, ['myFunction a1, a2']

  suite 'multi line no strict parens', false, false, [
    '''
    myFunction(a1, a2,
      a3)
    '''

    '''
    myFunction(a1,
      a2,
      a3)
    '''

    '''
    myFunction(
      a1,
      a2,
      a3)
    '''

    '''
    myFunction(
      a1,
      a2,
      a3
    )
    '''

    '''
    myFunction(
      a1,
      a2,
      a3,
      myFunction2(a21, a22))
    '''

    '''
    myFunction(
      a1,
      a2,
      a3,
      myFunction2(a21, func()))
    '''
  ]

  suite 'multi line no strict no parens', false, true, [
    '''
    myFunction a1, a2,
      a3
    '''

    '''
    myFunction a1,
      a2,
      a3
    '''
  ]

  suite 'multi line callback mixed no strict', false, true, [
    '''
    myFunction 'arg', ->
      stream().pipe(stream2()).pipe(stream3())
    '''
  ]

