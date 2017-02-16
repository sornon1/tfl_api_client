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

describe TflApi::Client::AirQuality do
  let!(:client) { test_client }
  let!(:air_quality) { TflApi::Client::AirQuality.new(client) }
  let(:sample_response) do
    {
      updatePeriod: 'string',
      updateFrequency: 'string',
      forecastURL: 'string',
      disclaimerText: 'string',
      currentForecast: [
          {
              forecastType: 'string',
              forecastID: 'string',
              forecastBand: 'string',
              forecastSummary: 'string',
              nO2Band: 'string',
              o3Band: 'string',
              pM10Band: 'string',
              pM25Band: 'string',
              sO2Band: 'string',
              forecastText: 'string'
          }
      ]
    }
  end

  describe '#details' do
    before  { allow(client).to receive(:get).with('/AirQuality').and_return(sample_response) }
    subject { air_quality.details }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to eq(sample_response) }
  end

end