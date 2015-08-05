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

module TflApi
  # This module contains classes that define exceptions for various categories.
  #
  module Exceptions
    # This is the base class for Exceptions that is inherited from
    # RuntimeError.
    #
    class ApiException < RuntimeError
      def initialize(message = '')
        super(message)
      end
    end

    # This exception class handles cases where invalid credentials are provided
    # to connect to the TFL API.
    #
    class Unauthorized < ApiException
      def initialize(message = '')
        message = 'Access denied. Please ensure you have valid TFL credentials.' if message.nil? || message.empty?
        super(message)
      end
    end

    # This exception class handles cases where valid credentials are provided
    # to connect to the TFL API, but those credentials do not have the access
    # level to perform the requested task.
    #
    class Forbidden < ApiException
      def initialize(message = '')
        message = 'Access denied. Your credentials do not permit this request.' if message.nil? || message.empty?
        super(message)
      end
    end

    # This exception class handles cases where a requested resource is not found
    # on the remote TFL API.
    #
    class NotFound < ApiException
      def initialize(message = '')
        message = 'Requested resource was not found on the TFL API.' if message.nil? || message.empty?
        super(message)
      end
    end

    # This exception class handles cases where the TFL API returns with a
    # 500 Internal Server Error.
    #
    class InternalServerError < ApiException
      def initialize(message = '')
        message = 'TFL API threw an Internal Server Error. Please try again.' if message.nil? || message.empty?
        super(message)
      end
    end

    # This exception class handles cases where the Jenkins is getting restarted
    # or reloaded where the response code returned is 503
    #
    class ServiceUnavailable < ApiException
      def initialize(message = '')
        message = 'TFL API is currently unavailable. Please try again.' if message.nil? || message.empty?
        super(message)
      end
    end
  end
end