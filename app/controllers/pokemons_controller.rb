class PokemonsController < ApplicationController
  skip_before_action :protect_pages, only: [:index]

  def index
    poke_service = PokeService.new
    pokemons = poke_service.pokemons

    @pokemons_presenter = PokemonsPresenter.new pokemons, PokemonPresenter
  ensure
    flash[:error] = "Unknown error"
  end

  def show
  end
end
