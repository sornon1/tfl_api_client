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
      # @return [Array] An array of hashes containing all BikePoints and their details
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


      # Returns all BikePoint locations known by the TFL service within a
      # particular position or place (a locus).
      #
      # @param latitude  [String] the latitude value
      # @param longitude [String] the longitude value
      # @param radius    [String] the radius of the area to cover
      #
      # @return [Array] An array of hashes containing all BikePoints and their details
      #
      def locations_within_locus(latitude, longitude, radius)
        uri_params = { latitude: latitude, longitude: longitude, radius: radius }
        @client.api_get_request('/BikePoint', uri_params)
      end

      def locations_within_bounding_box(sw_latitude, sw_longitude, ne_latitude, ne_longitude)
        uri_params = { sw_latitude: sw_latitude, sw_longitude: sw_longitude,
                       ne_latitude: ne_latitude, ne_longitude: ne_longitude }
        @client.api_get_request('/BikePoint', uri_params)
      end

      def search(query)
        # /BikePoint/Search?query=<query>
      end
    end
  end
end
