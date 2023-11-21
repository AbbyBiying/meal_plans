require 'rails_helper'
require 'rack/test'

describe 'Rack::Attack rate limiting', type: :request do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  describe 'Rack::Attack throttling' do
    let(:endpoint) { '/up' }
    before(:all) do
      @throttle = Rack::Attack.throttles['req/ip']
      @limit = @throttle ? @throttle.instance_variable_get(:@limit) : nil
      @period = @throttle ? @throttle.instance_variable_get(:@period) : nil
    end

    it 'logs rate limit configuration' do
      if @throttle
        puts "Rate Limit: #{@limit} requests per #{@period} seconds"
      else
        puts "Rate limit configuration not found for 'req/ip'"
      end
    end

    it 'returns 429 when rate limit is exceeded' do
      ip_address = '127.0.0.1'

      # Simulate requests from the same IP
      @limit.times do
        get endpoint, {}, 'REMOTE_ADDR' => ip_address
        expect(last_response.status).to eq(200)
      end

      # The next request should exceed the limit
      get endpoint, {}, 'REMOTE_ADDR' => ip_address
      puts "Request #{@limit+1} - Response Status: #{last_response.status}, Body: #{last_response.body}"

      puts "Rack::Attack log:"
      Rails.logger.debug("[Rack::Attack] Throttling IP: #{ip_address}")

      expect(last_response.status).to eq(429)
      expect(last_response.body).to include('Retry later')
    end
  end
end
