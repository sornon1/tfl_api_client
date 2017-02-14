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


describe '/BikePoint Integration', type: :feature do
  let!(:authorised_bike_point)   { authorised_client.bike_point }
  let!(:unauthorised_bike_point) { unauthorised_client.bike_point }

  describe '#locations' do
    context 'with an authorised client' do
      it 'should return all locations' do
        VCR.use_cassette('bike_point/authorised_client_locations') do
          locations = authorised_bike_point.locations
          expect(locations).to be_kind_of(Array)
          expect(locations).to_not be_empty
        end
      end
    end

    context 'with an unauthorised client' do
      it 'should raise an exception' do
        VCR.use_cassette('bike_point/unauthorised_client_locations') do
          expect {
            unauthorised_bike_point.locations
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end

  describe '#location' do
    let(:location_id) { 'BikePoints_10' }

    context 'with an authorised client' do
      it "should return the given location's details" do
        VCR.use_cassette('bike_point/authorised_client_location') do
          location = authorised_bike_point.location(location_id)
          expect(location).to be_kind_of(Hash)
          expect(location['id']).to eq(location_id)
          expect(location['placeType']).to eq('BikePoint')
        end
      end
    end

    context 'with an unauthorised client' do
      it 'should raise an exception' do
        VCR.use_cassette('bike_point/unauthorised_client_location') do
          expect {
            unauthorised_bike_point.location(location_id)
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end

  describe '#locations_within_locus' do
    let(:longitude) { 51.5007292 }  # Big Ben
    let(:latitude)  { -0.1246254 }
    let(:radius)    { 500 }

    context 'with an authorised client' do
      it 'should return all BikePoints within the defined locus' do
        VCR.use_cassette('bike_point/authorised_client_locations_within_locus') do
          locations = authorised_bike_point.locations_within_locus(longitude, latitude, radius)
          expect(locations).to be_kind_of(Hash)
          expect(locations['centrePoint']).to eq([51.5, -0.124])
          expect(locations['places']).to be_kind_of(Array)
          expect(locations['places']).to_not be_empty
        end
      end
    end

    context 'with an unauthorised client' do
      it 'should raise an exception' do
        VCR.use_cassette('bike_point/unauthorised_client_locations_within_locus') do
          expect {
            unauthorised_bike_point.locations_within_locus(longitude, latitude, radius)
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end

  describe '#locations_within_bounding_box' do
    let(:sw_latitude)  { 51.5007292 }  # Big Ben
    let(:sw_longitude) { -0.1246254 }
    let(:ne_latitude)  { 51.5138453 }  # St. Paul's Cathedral
    let(:ne_longitude) { -0.0983506 }

    context 'with an authorised client' do
      it 'should return all BikePoints within the defined bounding box' do
        VCR.use_cassette('bike_point/authorised_client_locations_within_bounding_box') do
          locations = authorised_bike_point.locations_within_bounding_box(sw_latitude, sw_longitude, ne_latitude, ne_longitude)
          expect(locations).to be_kind_of(Array)
          expect(locations).to_not be_empty
        end
      end
    end

    context 'with an unauthorised client' do
      it 'should raise an exception' do
        VCR.use_cassette('bike_point/unauthorised_client_locations_within_bounding_box') do
          expect {
            unauthorised_bike_point.locations_within_bounding_box(sw_latitude, sw_longitude, ne_latitude, ne_longitude)
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end

  describe '#search' do
    let(:search_term) { 'St. James' }

    context 'with an authorised client' do
      it 'should return all BikePoint locations based upon the criteria' do
        VCR.use_cassette('bike_point/authorised_client_search') do
          locations = authorised_bike_point.search(search_term)
          expect(locations).to be_kind_of(Array)
          expect(locations).to_not be_empty
        end
      end
    end

    context 'with an unauthorised client' do
      it 'should raise an exception' do
        VCR.use_cassette('bike_point/unauthorised_client_search') do
          expect {
            unauthorised_bike_point.search(search_term)
          }.to raise_error(TflApi::Exceptions::ApiException)
        end
      end
    end
  end
end