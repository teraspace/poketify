require 'rest-client'

class PokeService

  POKE_API_URL = 'https://pokeapi.co/api/v2/pokemon'

  def initialize(options={})
    @options = options
    @offset = options[:offset] || 0
    @limit = options[:limit] || 20
    @response = nil
  end

  def pokemons
    url = "#{POKE_API_URL}?offset=#{@offset}&limit=#{@limit}"
    @response = JSON.parse(request_pokemon(url).body)
  end

  def pokemon_detail(url)
    @response = nil
    cache_id = url.split('/')[6]
    Rails.cache.fetch("pokemon_#{cache_id}", expires_in: 12.hours) do
      @response = JSON.parse(request_pokemon(url).body)
    end
  end

  private

  def request_pokemon(url)
    begin
      resp = RestClient.get(url)
    rescue RestClient::NotFound => error
      raise error.message
    rescue RestClient::Unauthorized, RestClient::Forbidden => error
      puts 'Access denied'
      raise error.message
    rescue RestClient::ImATeapot => error
      puts 'The server is a teapot! # RFC 2324'
      raise error.message
    rescue RestClient::MovedPermanently, RestClient::ExceptionWithResponse => error
      puts 'The server is a teapot! # RFC 2324'
      raise error.message
    else
      puts 'It worked!'
      return resp
    end
  end
end
