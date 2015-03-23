require 'spec_helper'

describe FlipkartAPI do
  let (:flipkart_api) { FlipkartAPI.new }

  it 'initializes variables properly' do
    expect(flipkart_api.raw_response).to be_a(Array)
    expect(flipkart_api.records).to be_a(Array)
  end

  it 'fetches records from the API' do
    VCR.use_cassette 'flipkart_api' do
      flipkart_api.fetch_records!
      expect(flipkart_api.raw_response[0]).to have_key('orderList')
    end
  end
end
