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

require_relative '../spec_helper'

describe '/AirQuality Integration', type: :feature do
  let!(:authorised_accident_stats)   { authorised_client.air_quality }
  let!(:unauthorised_accident_stats) { unauthorised_client.air_quality }

  describe '#location' do
    context 'with an authorised client' do
      it 'should return the air quality details as currently reported' do
        VCR.use_cassette('air_quality/authorised_client_details') do
          details = authorised_accident_stats.details
          expect(details).to be_kind_of(Hash)
          expect(details).not_to be_empty
        end
      end
    end

    context 'with an unauthorised client' do
      it 'should raise an exception' do
        VCR.use_cassette('air_quality/unauthorised_client_details') do
          expect {
            unauthorised_accident_stats.details
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end
end