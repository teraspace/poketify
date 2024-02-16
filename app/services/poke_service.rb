require 'rest-client'

class PokeService

  POKE_API_URL = 'https://pokeapi.co/ap/v2/pokemon'

  def initialize(options={})
    @options = options
    @offset = options[:offset] || 0
    @limit = options[:limit] || 20
    @id = options[:id]
    @response = nil
  end

  def pokemons
    url = "#{POKE_API_URL}?offset=#{@offset}&limit=#{@limit}"
    @response = JSON.parse(request_pokemon(url).body)
  end

  def pokemon(id)
    url = "#{POKE_API_URL}/#{id.to_i}"
    @response = JSON.parse(request_pokemon(url).body)
    @response["url"] = url
    @response
  end

  def pokemon_detail(url)
    return if url.nil?

    @response = nil
    cache_id = url&.split('/')&[6] || @id
    Rails.cache.fetch("pokemon_#{cache_id}", expires_in: 12.hours) do
      @response = JSON.parse(request_pokemon(url).body)
    end
  end

  private

  def request_pokemon(url)
    begin
      resp = RestClient.get(url)
    rescue RestClient::MovedPermanently, RestClient::ImATeapot, RestClient::Unauthorized, RestClient::Forbidden => error
      raise PokeApiPermanentError, error.message
    rescue RestClient::NotFound, RestClient::ExceptionWithResponse => error
      raise PokeApiPermanentError, error.message
    else
      return resp
    end
  end

  def pokemon_unzerializer

  end
end
