require 'faraday'
require 'json'

class UnsplashService
  def self.fetch_random_logo
    access_key = 'SuPXGqGpPv32qZpl9DNNZX7hO-KzwTihkP2cE19sRhs'
    url = "https://api.unsplash.com/photos/?client_id=SuPXGqGpPv32qZpl9DNNZX7hO-KzwTihkP2cE19sRhs"

    response = Faraday.get(url, {}, { "Authorization" => "Client-ID #{access_key}" })
    result = JSON.parse(response.body)  
    # require 'pry';binding.pry

    photo_url = result[0]["urls"]["small"]
    # require 'pry';binding.pry
  end
end
