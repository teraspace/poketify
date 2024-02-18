require 'rest-client'

class PokeService

  POKE_API_URL = 'https://pokeapi.co/api/v2/pokemon'

  def initialize(options={})
    @options = options
    @offset = options[:offset] || 0
    @limit = options[:limit] || 20
    @id = options[:id]
    @response = nil
  end

  def pokemons
    url = "#{POKE_API_URL}?offset=#{@offset}&limit=#{@limit}"
    @response = request_pokemon(url)
  end

  def pokemon(id)
    url = "#{POKE_API_URL}/#{id.to_i}"
    @response = request_pokemon(url)
    @response["url"] = url
    @response
  end

  def pokemon_detail(url)
    return if url.nil?

    @response = nil
    @response = request_pokemon(url)
  end

  def species_detail(url)
    return if url.nil?

    @response = nil
    @response = request_pokemon(url)
  end

  def evolution_chain(url)
    return if url.nil?

    @response = nil
    @response = request_pokemon(url)
  end

  private

  def request_pokemon(url)

    resp = nil
    bailed_resp = nil

    cached_resp = Rails.cache.fetch("#{url}", expires_in: 12.hours) do
      begin
        resp = RestClient.get(url)
      rescue RestClient::MovedPermanently, RestClient::ImATeapot, RestClient::Unauthorized, RestClient::Forbidden => error
        raise PokeApiPermanentError, error.message
      rescue RestClient::NotFound, RestClient::ExceptionWithResponse => error
        raise PokeApiPermanentError, error.message
      else
        bailed_resp = JSON.parse(resp.body)
      end
    end

    Rails.cache.delete("#{url}") if cached_resp.class != Hash

    cached_resp == nil ? bailed_resp : cached_resp
  end
end
