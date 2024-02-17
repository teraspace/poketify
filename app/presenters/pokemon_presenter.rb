class PokemonPresenter

  attr_accessor :name, :url, :detail, :sprites, :photo, :weight, :type, :abilites, :base_experience, :species, :moves, :description, :height, :id

  def initialize(pokemon)
    pokemon = pokemon.with_indifferent_access
    @name = pokemon["name"].capitalize
    @url = pokemon["url"]
    @id = pokemon["id"] || id
    @detail = nil
    @evolutions = []
  end

  def id
    @url.split("/")[6]
  end

  def detail
    poke_service = PokeService.new
    @detail = poke_service.pokemon_detail(@url)
  end

  def evolution_chain
    detail if species.nil?

    poke_service = PokeService.new
    url = poke_service.species_detail(species["url"])["evolution_chain"]["url"]
    evolution_chain = poke_service.species_detail(url)
    chain = evolution_chain["chain"]

    parse_evolutions(chain)
  end

  def sprites
    @sprites ||= @detail["sprites"]
  end

  def photo
    detail if @detail.nil?

    sprites["front_default"]
  end

  def weight
    detail if @detail.nil?

    @detail["weight"]
  end

  def height
    detail if @detail.nil?

    @detail["height"]
  end

  def type
    detail if @detail.nil?

    types = @detail["types"]
    types.map {|k,_v| k["type"] }.map {|k,_v| k["name"] }
  end

  def abilities
    detail if @detail.nil?

    @detail["abilities"].map {|k,_v| k["ability"] }.map {|k,_v| k["name"].gsub('-', ' ').capitalize }
  end

  def species
    detail if @detail.nil?

    @detail["species"]
  end

  def moves
    detail if @detail.nil?

    @detail["moves"].map {|k,_v| k["move"] }.map {|k,_v| k["name"].capitalize }
  end

  def base_experience
    detail if @detail.nil?

    @detail["base_experience"]
  end

  def description
    detail if @detail.nil?

    "With Base Exp of #{base_experience} #{@name}comes from the #{species["name"].capitalize} specie
    and wiil give you about of #{moves.size} moves ( #{moves.first(3).join(',')} )
    "
  end

  def evolutions
    detail if @detail.nil?
    evolution_chain if @evolutions.empty?

    @evolutions
  end

  private

  def parse_evolutions(chain)
    return "" if chain.nil?

    @evolutions.push chain["species"] if @evolutions.empty?
    @evolutions.push chain["evolves_to"][0]["species"]
  end
end
