class FlipkartAPI
  attr_reader :records
  attr_reader :raw_response

  def initialize
    @raw_response = []
    @records = []
  end

  def fetch_records!(start_date = 1.month.ago, end_date = Time.now, status = 'pending')
    api_url = "https://affiliate-api.flipkart.net/affiliate/report/orders/detail/json"
    query_options = {
      'startDate' => start_date.strftime('%Y-%m-%d'),
      'endDate' => end_date.strftime('%Y-%m-%d'),
      'status' => status,
      'offset' => 0
    }
    headers = {
      'Fk-Affiliate-Id' =>  'rohitkuruv',
      'Fk-Affiliate-Token' => '74bc88fff74b471ea9c3819542b01f27'
    }
    @raw_response << HTTParty.get(api_url, query: query_options, headers: headers).parsed_response
    @records << @raw_response[0]['orderList']
    # while !@raw_response.last['next'].empty?
    #   @raw_response << HTTParty.get(api_url, query: query_options, headers: headers).parsed_response
    #   @records << @raw_response[0]['orderList']
    # end
  end
end

class FlipkartAPIRecord
  attr_accessor :status
  attr_accessor :cost
end
