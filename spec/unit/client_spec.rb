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

require 'net/http'
require_relative '../spec_helper'


describe TflApi::Client do

  describe '#initialize' do
    it 'should initialise without an exception' do
      expect(
          lambda do
            TflApi::Client.new(
                app_id: 12345,
                app_key: 123456789
            )
          end
      ).not_to raise_error
    end

    it 'should raise an exception when Application ID is not present' do
      expect(
          lambda do
            TflApi::Client.new(
                app_key: 123456789
            )
          end
      ).to raise_error(ArgumentError)
    end

    it 'should raise an exception when Application Key is not present' do
      expect(
          lambda do
            TflApi::Client.new(
                app_id: 12345
            )
          end
      ).to raise_error(ArgumentError)
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
      url = URI.parse('https://somehost/SomeResource?app_id=12345&app_key=6789')
      allow(Net::HTTP).to receive(:get).with(url).and_return('{"status": "ok"}')

      response = client.api_get_request('/SomeResource')
      expect(response).to eq({'status' => 'ok'})
    end

    it 'should correctly format the request url with optional parameters' do
      url = URI.parse('https://somehost/SomeResource?foo=bar&version=1&app_id=12345&app_key=6789')
      allow(Net::HTTP).to receive(:get).with(url).and_return('{"status": "ok"}')

      response = client.api_get_request('/SomeResource', foo: 'bar', version: 1)
      expect(response).to eq({'status' => 'ok'})
    end

  end

end