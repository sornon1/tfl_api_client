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

    TflApi::Client.new(app_id: ENV['TFL_APP_ID'], app_key: ENV['TFL_APP_KEY'])
  end

  # Returns a new instance of the TflApi::Client class using unauthorised details.
  # All calls to the API using this object should result in unauthorised access
  # errors from the TFL API.
  #
  # @return [TflApi::Client] A TflApi::Client instance created with invalid credentials
  #
  def unauthorised_client
    TflApi::Client.new(app_id: 123, app_key: 456)
  end

end