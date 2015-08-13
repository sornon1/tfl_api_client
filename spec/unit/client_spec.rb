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

require 'logger'
require_relative '../spec_helper'

describe TflApi::Client do
  let(:nil_log_path) { '/dev/null' }

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

      it 'should set the log level to INFO' do
        expect(client.log_level).to eq(Logger::INFO)
      end

      it 'should set the log location to STDOUT' do
        expect(client.log_location).to eq(STDOUT)
      end
    end

    context 'when providing optional attributes' do
      it 'should allow a custom host' do
        client = TflApi::Client.new(app_id: 12345, app_key: 6789, host: 'http://myhost.com', log_location: nil_log_path)
        expect(client.host).to eq(URI.parse('http://myhost.com'))
      end

      it 'should allow a custom log level' do
        client = TflApi::Client.new(app_id: 12345, app_key: 6789, log_level: Logger::DEBUG)
        expect(client.log_level).to eq(Logger::DEBUG)
      end

      it 'should allow a custom log location' do
        client = TflApi::Client.new(app_id: 12345, app_key: 6789, log_location: '/dev/null')
        expect(client.log_location).to eq('/dev/null')
      end

      context 'when setting a custom logger' do
        let!(:logger) { Logger.new('/dev/null') }

        it 'should create a valid client object' do
          client = TflApi::Client.new(app_id: 12345, app_key: 6789, logger: logger)
          expect(client.logger).to eq(logger)
        end

        it 'should not allow a custom logger that is not a logger' do
          expect {
            TflApi::Client.new(app_id: 12345, app_key: 6789, logger: 'some_logger')
          }.to raise_error(ArgumentError)
        end

        it 'should not allow setting the log level with a custom logger' do
          expect {
            TflApi::Client.new(app_id: 12345, app_key: 6789, logger: logger, log_level: Logger::ERROR)
          }.to raise_error(ArgumentError)
        end

        it 'should not allow setting the log location with a custom logger' do
          expect {
            TflApi::Client.new(app_id: 12345, app_key: 6789, logger: logger, log_location: nil_log_path)
          }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '#bike_point' do
    it 'should return a Client::BikePoint object' do
      expect(test_client.bike_point).to be_an_instance_of(TflApi::Client::BikePoint)
    end
  end

  describe '#get' do
    subject(:client) { test_client }

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

    context 'when the resource requires authorisation' do
      before { stub_api_request(:get, 'SomeUnauthorisedResource', { status: 401 }) }
      subject { -> { client.get('/SomeUnauthorisedResource') } }

      it { is_expected.to raise_exception(TflApi::Exceptions::Unauthorized) }
    end

    context 'when the resource forbids access' do
      before { stub_api_request(:get, 'SomeForbiddenResource', { status: 403 }) }
      subject { -> { client.get('/SomeForbiddenResource') } }

      it { is_expected.to raise_exception(TflApi::Exceptions::Forbidden) }
    end

    context 'when the resource is not found' do
      before { stub_api_request(:get, 'SomeNotFoundResource', { status: 404 }) }
      subject { -> { client.get('/SomeNotFoundResource') } }

      it { is_expected.to raise_exception(TflApi::Exceptions::NotFound) }
    end

    context 'when the resource has malfunctioned' do
      before { stub_api_request(:get, 'SomeInternalErrorResource', { status: 500 }) }
      subject { -> { client.get('/SomeInternalErrorResource') } }

      it { is_expected.to raise_exception(TflApi::Exceptions::InternalServerError) }
    end

    context 'when the resource is unavailable' do
      before { stub_api_request(:get, 'SomeUnavailableResource', { status: 503 }) }
      subject { -> { client.get('/SomeUnavailableResource') } }

      it { is_expected.to raise_exception(TflApi::Exceptions::ServiceUnavailable) }
    end

    context 'when the resource errors unexpectedly' do
      before { stub_api_request(:get, 'SomeUnknownErrorResource', { status: 444 }) }
      subject { -> { client.get('/SomeUnknownErrorResource') } }

      it { is_expected.to raise_exception(TflApi::Exceptions::ApiException) }
    end
  end

  describe '#inspect' do
    let!(:client) { TflApi::Client.new(app_id: 12345, app_key: 6789) }
    subject { client.inspect }

    it { is_expected.to_not include('app_id=12345') }
    it { is_expected.to_not include('app_key=6789') }
    it { is_expected.to include('host=https://api.tfl.gov.uk') }
    it { is_expected.to include('log_level=1') }
    it { is_expected.to include('log_location=#<IO:<STDOUT>>') }
  end
end
