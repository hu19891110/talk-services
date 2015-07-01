should = require 'should'
service = require '../../src/service'
{prepare, cleanup, req} = require '../util'
magnumci = service.load 'magnumci'

describe 'Magnumci#Webhook', ->

  before prepare

  it 'receive webhook', (done) ->
    magnumci.sendMessage = (message) ->
      message.quote.title.should.eql '[FAIL] drips #1 (master - master) by Magnum CI'
      message.quote.text.should.eql 'Test build'
      message.quote.redirectUrl.should.eql 'http://magnum-ci.com/projects/2986/builds/172696'
      done()

    req.body = require './magnumci_assets/fail.json'
    req.integration = _id: 1

    magnumci.receiveEvent 'service.webhook', req
    .catch done

  after cleanup