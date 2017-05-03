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
    # This class communicates with the TFL "/AccidentStats" API to obtain
    # details about Accident Statistics based upon the year the accident
    # occurred.
    #
    class StopPoint

      # Initialize the StopPoint object and store the reference to Client
      # object.
      #
      # @param client [Client] the client object
      #
      # @return [StopPoint] the StopPoint object
      #
      def initialize(client)
        @client = client
      end

      # Returns estimated arrival times for stop point.
      #
      # @return [Array] An array of hashes containing estimated Arrivals at that stop
      #
      def arrivals(stop_point_id)
        @client.get("/StopPoint/#{stop_point_id}/Arrivals")
      end

      # Returns the route sections for all the lines that service the given
      # stop point ids
      #
      # @return [Array] An array of hashes containing lines that service the given stop
      #
      def routes(stop_point_id,service_types = {})
        @client.get("/StopPoint/#{stop_point_id}/Route",service_types)
      end
    end
  end
end
