#
# Copyright (c) 2015 Luke Hackett
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require_relative '../spec_helper'


describe TflApi::Client do

  describe '#initialize' do
    context 'mandatory attributes' do
      it 'should raise an exception when Application ID is not present' do
        expect {
          TflApi::Client.new(app_key: 123456789)
        }.to raise_error(ArgumentError)
      end

      it 'should raise an exception when Application Key is not present' do
        expect {
          TflApi::Client.new(app_id: 12345)
        }.to raise_error(ArgumentError)
      end
    end

    context 'default attributes' do
      subject(:client) { TflApi::Client.new(app_id: 12345, app_key: 6789) }

      it 'should set the host to a "https://api.tfl.gov.uk" when not present' do
        expect(client.host).to eq(URI.parse('https://api.tfl.gov.uk'))
      end
    end

    context 'optional attributes' do
      it 'should allow a custom host' do
        client = TflApi::Client.new(app_id: 12345, app_key: 6789, host: 'http://myhost.com')
        expect(client.host).to eq(URI.parse('http://myhost.com'))
      end
    end
  end

  describe '#bike_point' do
    it 'should return a Client::BikePoint object' do
      client = TflApi::Client.new(app_id: 12345, app_key: 6789)
      expect(client.bike_point).to be_an_instance_of(TflApi::Client::BikePoint)
    end
  end

  describe '#get' do
    subject(:client) { TflApi::Client.new(app_id: 12345, app_key: 6789, host: 'https://somehost') }

    context 'when issuing the request' do
      it 'should correctly format the request url' do
        stub = stub_api_request(:get, 'SomeResource', { status: 200, body: '{"status": "ok"}' })
        client.get('/SomeResource')
        expect(stub).to have_requested(:get, 'https://somehost/SomeResource?app_id=12345&app_key=6789').once
      end

      it 'should correctly format the request url with optional parameters' do
        stub = stub_api_request(:get, 'SomeResource', { foo: 'bar', version: 1 }, { body: '{"status": "ok"}' })
        client.get('/SomeResource', foo: 'bar', version: 1)
        expect(stub).to have_requested(:get, 'https://somehost/SomeResource?foo=bar&version=1&app_id=12345&app_key=6789').once
      end
    end

    context 'when the resource requires authorisation' do
      before { stub_api_request(:get, 'SomeUnauthorisedResource', { status: 401 }) }

      it 'should raise an Forbidden exception' do
        expect {
          client.get('/SomeUnauthorisedResource')
        }.to raise_exception(TflApi::Exceptions::Unauthorized)
      end
    end

    context 'when the resource forbids access' do
      before { stub_api_request(:get, 'SomeNotFoundResource', { status: 403 }) }

      it 'should raise an Forbidden exception' do
        expect {
          client.get('/SomeNotFoundResource')
        }.to raise_exception(TflApi::Exceptions::Forbidden)
      end
    end

    context 'when the resource returns successfully' do
      it 'should return a json response as a hash on a successful response' do
        stub_api_request(:get, 'SomeResource', { status: 200, body: '{"status": "ok"}' })
        response = client.get('/SomeResource')
        expect(response).to be_a(Hash)
      end

      it 'should raise an ApiException if the JSON is unparsable' do
        stub_api_request(:get, 'SomeResource', { status: 200, body: 'invalid json' })
        expect {
          client.get('/SomeResource')
        }.to raise_exception(TflApi::Exceptions::ApiException)
      end
    end

    context 'when the resource is not found' do
      before { stub_api_request(:get, 'SomeNotFoundResource', { status: 404 }) }

      it 'should raise a NotFound exception' do
        expect {
          client.get('/SomeNotFoundResource')
        }.to raise_exception(TflApi::Exceptions::NotFound)
      end
    end

    context 'when the resource has malfunctioned' do
      before { stub_api_request(:get, 'SomeInternalErrorResource', { status: 500 }) }

      it 'should raise an InternalServiceError exception' do
        expect {
          client.get('/SomeInternalErrorResource')
        }.to raise_exception(TflApi::Exceptions::InternalServerError)
      end
    end

    context 'when the resource is unavailable' do
      before { stub_api_request(:get, 'SomeUnavailableResource', { status: 503 }) }

      it 'should raise a NotFound exception' do
        expect {
          client.get('/SomeUnavailableResource')
        }.to raise_exception(TflApi::Exceptions::ServiceUnavailable)
      end
    end

    context 'when the resource errors unexpectedly' do
      before { stub_api_request(:get, 'SomeUnknownErrorResource', { status: 444 }) }

      it 'should raise an ApiException' do
        expect {
          client.get('/SomeUnknownErrorResource')
        }.to raise_exception(TflApi::Exceptions::ApiException)
      end
    end
  end
end
