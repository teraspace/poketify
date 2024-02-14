require 'rails_helper'

RSpec.describe PokemonsPresenter, type: :presenter do
  before(:each) do
    VCR.insert_cassette "pokemons"
  end

  let(:poke_service) { PokeService.new }
  let(:pokemons_presenter) { PokemonsPresenter.new(poke_service.pokemons, PokemonPresenter) }

  describe '#pokemons' do
    it "receive pokemons in the presenter" do
      expect(pokemons_presenter.class).to eq PokemonsPresenter
      expect(pokemons_presenter.results.first.class).to eq PokemonPresenter
    end
  end
end
