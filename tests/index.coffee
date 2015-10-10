chai = require 'chai'
expect = chai.expect
AutoLaunch = require '../src/'

if process.platform isnt 'win32'
    autoLaunch = new AutoLaunch
        name: 'node-auto-launch test'
        path: '/bin/ls'

    describe 'node-auto-launch', ->
        describe '.isEnabled', ->
            it 'should be disabled', (done)->
                autoLaunch.isEnabled (enabled) ->
                    expect(enabled).to.equal false
                    done()

        describe '.enable', ->
            it 'should enable auto launch', (done) ->
                autoLaunch.enable ->
                    autoLaunch.isEnabled (enabled) ->
                        expect(enabled).to.equal true
                        done()

        describe '.disabled', ->
            it 'should disable auto launch', (done) ->
                autoLaunch.disable ->
                    autoLaunch.isEnabled (enabled) ->
                        expect(enabled).to.equal false
                        done()
