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

    for code in tests
      it "#{title} #{result}", ->
        errors = coffeelint.lint(code, config)
        if succeed
          expect(errors).to.be.empty
        else
          expect(errors).to.not.be.empty


  suite 'single line strict parens', true, false, ['myFunction(a1, a2)']

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
  ]

  suite 'single line no strict parens', false, true, ['myFunction(a1, a2)']

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
  ]

  suite 'multi line no strict no parens', false, false, [
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
