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

require 'tfl_api_client/uri_helper'

module TflApi
  class Client
    # This class communicates with the TFL "/BikePoint" API to obtain details
    # about bike points locations based upon their IDs or by their latitude
    # and longitude values.
    #
    class BikePoint
      include TflApi::UriHelper

      # Initialize the BikePoint object and store the reference to Client object
      #
      # @param client [Client] the client object
      #
      # @return [BikePoint] the BikePoint object
      #
      def initialize(client)
        @client = client
      end

      # Returns all BikePoint locations known by the TFL service
      #
      # @return [hash] A hash containing all BikePoints and their details
      #
      def locations
        @client.api_get_request('/BikePoint')
      end

      # Returns the all details known by the TFL service for the given
      # BikePoint id.
      #
      # @param id [String] the TFL BikePoint id
      #
      # @return [hash] A hash containing the details of the given BikePoint
      #
      def location(id)
        @client.api_get_request("/BikePoint/#{id}")
      end

      def locations_within_locus(latitude, longitude, radius)
        # /BikePoint?lat=<latitude>&lon=<longitude>&radius=<radius>
      end

      def locations_within_bounding_box(sw_latitude, sw_longitude, ne_latitude, ne_longitude)
        # /BikePoint?swLat=<sw_latitude>&swLon=<sw_longitude>&neLat=<ne_latitude>&neLon=<ne_longitude>
      end

      def search(query)
        # /BikePoint/Search?query=<query>
      end
    end
  end
end
