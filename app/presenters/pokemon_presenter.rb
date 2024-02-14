class PokemonPresenter

  attr_accessor :name, :url

  def initialize(pokemon)
    pokemon = pokemon.with_indifferent_access
    @name = pokemon["name"]
    @url = pokemon["url"]
  end
end
