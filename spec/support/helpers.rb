#
# Copyright (c) 2015 - 2017 Luke Hackett
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

require 'uri'

module Helpers

  # Returns a new instance of the TflApi::Client class using authorised details.
  # All calls to the API using this object should return the expected data.
  #
  # @return [TflApi::Client] A TflApi::Client instance created with valid credentials
  #
  def authorised_client
    # Fail early if the Application private and public keys are not set
    fail 'Please set your app id via the TFL_APP_ID environment variable' unless ENV['TFL_APP_ID']
    fail 'Please set your app key via the TFL_APP_KEY environment variable' unless ENV['TFL_APP_KEY']

    TflApi::Client.new(app_id: ENV['TFL_APP_ID'], app_key: ENV['TFL_APP_KEY'], log_location: '/dev/null')
  end

  # Returns a new instance of the TflApi::Client class using unauthorised details.
  # All calls to the API using this object should result in unauthorised access
  # errors from the TFL API.
  #
  # @return [TflApi::Client] A TflApi::Client instance created with invalid credentials
  #
  def unauthorised_client
    TflApi::Client.new(app_id: 123, app_key: 456, log_location: '/dev/null')
  end

  # Returns a new instance of the TflApi::Client class using test details.
  # This client should only be used within Unit Tests, as the host has been
  # fixed to a dummy value.
  #
  # @return [TflApi::Client] A TflApi::Client instance created with invalid credentials
  #
  def test_client
    TflApi::Client.new(app_id: 12345, app_key: 6789, host: 'https://somehost', log_location: '/dev/null')
  end

  # Performs a HTTP stubbed request for the given method upon the given resource.
  # Optional params can be given to be appended to the URL, whilst the to_return
  # allows for specific return information to be set.
  #
  # @param method [Symbol] The type of stub request, e.g. :get, :post etc
  # @param resource [String] The resource path to stub
  # @param to_return [Hash] Response to return upon issuing the request
  #
  # @option params [Hash] A hash of URL params to add to the URI
  #
  # @return [WebMock::RequestStub] A WebMock::RequestStub instance
  #
  def stub_api_request(method, resource, params={}, to_return)
    params_string = URI.encode_www_form(params)
    uri = URI.parse("https://somehost/#{resource}?#{params_string}&app_id=12345&app_key=6789")
    stub_request(method.to_sym, uri).to_return(to_return)
  end

end