class PokemonPresenter

  attr_accessor :name, :url, :detail, :sprites, :photo, :weight, :type, :abilites, :base_experience, :species, :moves, :description

  def initialize(pokemon)
    pokemon = pokemon.with_indifferent_access
    @name = pokemon["name"].capitalize
    @url = pokemon["url"]
    @detail = nil
  end

  def detail
    poke_service = PokeService.new
    @detail = poke_service.pokemon_detail(@url)
  end

  def sprites
    @sprites ||= @detail["sprites"]
  end

  def photo
    detail if @detail.nil?
    sprites["front_default"]
  end

  def weight
    @detail["weight"]
  end

  def type
    types = @detail["types"]
    types.map {|k,_v| k["type"] }.map {|k,_v| k["name"] }
  end

  def abilities
    @detail["abilities"].map {|k,_v| k["ability"] }.map {|k,_v| k["name"].gsub('-', ' ').capitalize }
  end

  def species
    @detail["species"]["name"]
  end

  def moves
    @detail["moves"].map {|k,_v| k["move"] }.map {|k,_v| k["name"] }
  end

  def base_experience
    @detail["base_experience"]
  end

  def description
    "With Base Exp of #{base_experience} #{@name}comes from the #{species} specie
    and wiil give you about of #{moves.size} moves ( #{moves.first(3).join(',')} )
    ".first(100) + " ... "
  end
end
