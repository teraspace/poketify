class PokemonsController < ApplicationController
  include ErrorsManagement

  skip_before_action :protected_pages, only: [:index]

  def index
    poke_service = PokeService.new(offset: pokemons_params[:offset])
    pokemons = poke_service.pokemons

    @pokemons_presenter = PokemonsPresenter.new pokemons, PokemonPresenter
  end

  def show
    poke_service = PokeService.new(offset: pokemons_params[:offset])
    pokemon = poke_service.pokemon(pokemons_params[:id])

    @pokemon_presenter = PokemonPresenter.new pokemon
  end

  private

  def pokemons_params
    params.permit :limit, :offset, :id
  end
end
