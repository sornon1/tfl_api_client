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

module TflApi
  # This is the client class that allows direct access to the subclasses and to
  # the TFL API. The class contains methods that perform GET and POST requests
  # to the API.
  #
  class Client
    # Parameters that are permitted as options while initializing the client
    VALID_PARAMS = %w( app_id app_key ).freeze

    # Initialize a Client object with TFL API credentials
    #
    # @param args [Hash] Arguments to connect to TFL API
    #
    # @option args [String] :app_id  the application id generated by registering an app with TFL
    # @option args [String] :app_key the application key generated by registering an app with TFL
    #
    # @return [TflApi::Client] a client object to the TFL API
    #
    # @raise [ArgumentError] when required options are not provided.
    #
    def initialize(args)
      args.each do |key, value|
        if value && VALID_PARAMS.include?(key.to_s)
          instance_variable_set("@#{key.to_sym}", value)
        end
      end if args.is_a? Hash

      # Ensure the Application ID is given
      unless @app_id
        raise ArgumentError, "Application ID (app_id) is required to interact with TFL's APIs"
      end

      # Ensure the Application ID is given
      unless @app_key
        raise ArgumentError, "Application Key (app_key) is required to interact with TFL's APIs"
      end
    end
  end
end
