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
    @response = JSON.parse(request_pokemon.body)
  end

  private

  def request_pokemon
    begin
      url = "#{POKE_API_URL}?offset=#{@offset}&limit=#{@limit}"
      puts url
      resp = RestClient.get(url)
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      puts 'Access denied'
      throw err.response
    rescue RestClient::ImATeapot => err
      puts 'The server is a teapot! # RFC 2324'
      throw err.response
    rescue RestClient::MovedPermanently, RestClient::ExceptionWithResponse => err
      puts 'The server is a teapot! # RFC 2324'
      throw err.response
    else
      puts 'It worked!'
      return resp
    end
  end
end
