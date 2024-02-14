require 'rails_helper'

RSpec.describe PokemonPresenter, type: :presenter do
  let(:pokemon_presenter) {
    PokemonPresenter.new({"name": "Picachú", "url": "https://example.com/picachu"})
  }

  describe "PokemonPresenter" do
    it 'should be able to present' do
      expect(pokemon_presenter.class).to eq PokemonPresenter
      expect(pokemon_presenter.name).to eq "Picachú"
      expect(pokemon_presenter.url).to eq "https://example.com/picachu"
    end
  end
end
