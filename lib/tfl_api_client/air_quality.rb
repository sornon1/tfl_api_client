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

module TflApi
  class Client
    # This class communicates with the TFL "/AirQuality" API to obtain
    # details about London's Air Quality.
    #
    class AirQuality

      # Initialize the AirQuality object and store the reference to Client
      # object.
      #
      # @param client [Client] the client object
      #
      # @return [AirQuality] the AirQuality object
      #
      def initialize(client)
        @client = client
      end

      # Returns all Air Quality details for the current time period (currently
      # every hour).
      #
      # @return [Hash] A hash containing details upon London's Air Quality
      #
      def details
        @client.get('/AirQuality')
      end
    end
  end
end
