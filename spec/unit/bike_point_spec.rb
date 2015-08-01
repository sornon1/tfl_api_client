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

require_relative '../spec_helper'


describe TflApi::Client::BikePoint do
  let!(:client) { TflApi::Client.new(app_id: 123, app_key: 456) }
  let!(:bike_point) { TflApi::Client::BikePoint.new(client) }
  let(:sample_response) do
    [{
      'id' => 1,
      'url' => 'https://someurl/path/to/resource',
      'name' => 'Test Response',
      'additionalProperties' => [
          { 'foo' => 'bar', 'age' => 1234 },
          { 'baz' => 'foo', 'age' => 5678 }
      ]
    }]
  end
  
  describe '#locations' do
    before  { allow(client).to receive(:api_get_request).with('/BikePoint').and_return(sample_response) }
    subject { bike_point.locations }

    it { is_expected.to be_an(Array) }
    it { is_expected.to eq(sample_response) }
  end

  describe '#location' do
    before  { allow(client).to receive(:api_get_request).with('/BikePoint/SOME_ID').and_return(sample_response.first) }
    subject { bike_point.location('SOME_ID') }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to eq(sample_response.first) }
  end

  describe '#locations_within_locus' do
    let(:query) { { latitude: 1, longitude: 2, radius: 3 } }
    before  {  allow(client).to receive(:api_get_request).with('/BikePoint', query).and_return(sample_response) }
    subject { bike_point.locations_within_locus(query[:latitude], query[:longitude], query[:radius]) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to eq(sample_response) }
  end

  describe '#locations_within_bounding_box' do
    let(:query) { { sw_latitude: 1, sw_longitude: 2, ne_latitude: 3, ne_longitude: 4 } }
    before  { allow(client).to receive(:api_get_request).with('/BikePoint', query).and_return(sample_response) }
    subject { bike_point.locations_within_bounding_box(query[:sw_latitude], query[:sw_longitude],
                                                       query[:ne_latitude], query[:ne_longitude]) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to eq(sample_response) }
  end

  describe '#search' do
    let(:query) { { query: 'St. James Park' } }
    before  { allow(client).to receive(:api_get_request).with('/BikePoint/Search', query).and_return(sample_response) }
    subject { bike_point.search(query[:query]) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to eq(sample_response) }
  end

end