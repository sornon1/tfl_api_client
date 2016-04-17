#
# Copyright (c) 2015 - 2016 Luke Hackett
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

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../../cassettes', __FILE__)
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # Replace the real Application ID and Application Key with some fake data
  config.before_record do |interaction|
    interaction.request.uri.gsub!(/app_id=([^&]+)/, 'app_id=TFL_APP_ID')
    interaction.request.uri.gsub!(/app_key=([^&]+)/, 'app_key=TFL_APP_KEY')
  end

  # Prevent VCR from matching on Application ID and Application Key
  config.default_cassette_options = {
      match_requests_on: [:method, VCR.request_matchers.uri_without_param(:app_id, :app_key)]
  }
end
