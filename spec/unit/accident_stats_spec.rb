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

describe TflApi::Client::AccidentStats do
  let!(:client) { test_client }
  let!(:accident_stats) { TflApi::Client::AccidentStats.new(client) }
  let(:sample_response) { [{ foo: {}, bar: [], baz: 'some string' }] }

  describe '#details' do
    before  { allow(client).to receive(:get).with('/AccidentStats/2016').and_return(sample_response) }
    subject { accident_stats.details(2016) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to eq(sample_response) }
  end

end