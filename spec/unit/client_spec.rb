#
# Copyright (c) 2015 Luke Hackett
#
#     MIT License
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

      it 'should set the host to a "api.tfl.gov.uk" when not present' do
        expect(client.host).to eq('api.tfl.gov.uk')
      end
    end
  end

  describe '#bike_point' do
    it 'should return a Client::BikePoint object' do
      client = TflApi::Client.new(app_id: 12345, app_key: 6789)
      expect(client.bike_point).to be_an_instance_of(TflApi::Client::BikePoint)
    end
  end

  describe '#api_get_request' do
    subject(:client) { TflApi::Client.new(app_id: 12345, app_key: 6789, host: 'somehost') }

    it 'should correctly format the request url' do
      uri = URI.parse('https://somehost/SomeResource?app_id=12345&app_key=6789')
      stub = stub_request(:get, uri).to_return(body: '{"status": "ok"}')
      client.api_get_request('/SomeResource')

      expect(stub).to have_requested(:get, uri).once
    end

    it 'should correctly format the request url with optional parameters' do
      uri = URI.parse('https://somehost/SomeResource?foo=bar&version=1&app_id=12345&app_key=6789')
      stub = stub_request(:get, uri).to_return(body: '{"status": "ok"}')
      client.api_get_request('/SomeResource', foo: 'bar', version: 1)

      expect(stub).to have_requested(:get, uri).once
    end

    it 'should return a json response as a hash on a successful response' do
      uri = URI.parse('https://somehost/SomeResource?app_id=12345&app_key=6789')
      stub_request(:get, uri).to_return(body: '{"status": "ok"}')
      response = client.api_get_request('/SomeResource')

      expect(response).to be_a(Hash)
    end

    it 'should raise exception if the response is not successful' do
      uri = URI.parse('https://somehost/SomeNotFoundResource?app_id=12345&app_key=6789')
      stub_request(:get, uri).to_return(status: 404)

      expect {
        client.api_get_request('/SomeNotFoundResource')
      }.to raise_error(TflApi::Exceptions::ApiException)
    end
  end
end