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

describe '/Cabwise Integration', type: :feature do

  describe '#search' do
    let!(:client) { authorised_client.cabwise }

    context 'with an authorised client' do
      context 'with valid longitude and latitude values' do
        let(:longitude) { 51.5007292 }  # Big Ben
        let(:latitude)  { -0.1246254 }

        it 'should return the given taxi and minicab details' do
          VCR.use_cassette('cabwise/authorised_client_cabwise_search_valid_values') do
            results = client.search(latitude, longitude)
            expect(results).to be_kind_of(Hash)
            expect(results['Operators']).to be_kind_of(Hash)
            expect(results['Header']).to be_kind_of(Hash)
          end
        end
      end

      context 'with invalid longitude and latitude values' do
        let(:longitude) { 'foo' }
        let(:latitude)  { 'bar' }

        it 'should raise an exception' do
          VCR.use_cassette('cabwise/authorised_client_cabwise_search_invalid_values') do
            expect {
              client.search(latitude, longitude)
            }.to raise_error(TflApi::Exceptions::ApiException)
          end
        end
      end
    end

    context 'with an unauthorised client' do
      let!(:client) { unauthorised_client.cabwise }
      let(:longitude) { 51.5007292 }  # Big Ben
      let(:latitude)  { -0.1246254 }

      it 'should raise an exception' do
        VCR.use_cassette('cabwise/unauthorised_client_cabwise_search') do
          expect {
            client.search(latitude, longitude)
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end

end