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

describe TflApi::Client::Cabwise do
  let!(:client) { test_client }
  let!(:cabwise) { TflApi::Client::Cabwise.new(client) }
  let(:sample_response) { { foo: {}, bar: [], baz: 'some string' } }

  describe '#search' do
    let!(:latitude) { 1.0 }
    let!(:longitude) { 2.0 }
    let!(:params) { { foo: 'value' } }

    before do
      query = params.merge({ lat: latitude, lon: longitude })
      allow(client).to receive(:get).with('/Cabwise/search', query).and_return(sample_response)
    end

    subject { cabwise.search(latitude, longitude, params) }

    it { is_expected.to be_an(Hash) }
    it { is_expected.to eq(sample_response) }
  end

end