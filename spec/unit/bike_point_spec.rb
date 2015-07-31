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
    {
      'id' => 1,
      'url' => 'https://someurl/path/to/resource',
      'name' => 'Test Response',
      'additionalProperties' => [
          { 'foo' => 'bar', 'age' => 1234 },
          { 'baz' => 'foo', 'age' => 5678 }
      ]
    }
  end
  
  describe '#locations' do
    it 'should return all known locations' do
      allow(client).to receive(:api_get_request).with('/BikePoint').and_return(sample_response)
      expect(bike_point.locations).to eq(sample_response)
    end
  end

end