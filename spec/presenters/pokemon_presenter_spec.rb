require 'rails_helper'

RSpec.describe PokemonPresenter, type: :presenter do
  describe "PokemonPresenter" do
    it 'should be able to present' do
      @pokemon_presenter = nil
      @pokemon_detail = nil

      VCR.use_cassette("pokemon_presenter") do
        pokemons = PokeService.new.pokemons
        @pokemon_presenter =PokemonPresenter.new pokemons["results"].first

        expect(@pokemon_presenter.class).to eq PokemonPresenter
        expect(@pokemon_presenter.name).to eq "Bulbasaur"
        expect(@pokemon_presenter.url).to eq "https://pokeapi.co/api/v2/pokemon/1/"
      end

      VCR.use_cassette("pokemon_presenter_detail") do
        @pokemon_detail = @pokemon_presenter.detail
        expect(@pokemon_detail).to have_key("id")
        expect(@pokemon_detail).to have_key("name")
        expect(@pokemon_detail).to have_key("weight")
        expect(@pokemon_detail).to have_key("base_experience")
        expect(@pokemon_detail).to have_key("species")
      end

      VCR.use_cassette("pokemon_presenter_evolution") do
        evolution = @pokemon_presenter.evolution_chain
        expect(evolution.first["name"]).to eq "bulbasaur"
        expect(evolution.second["name"]).to eq "ivysaur"
      end

    end
  end
end
