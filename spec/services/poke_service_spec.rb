require 'rails_helper'

RSpec.describe PokeService, type: :service do

  let(:subject) { PokeService.new }

  describe '#pokemons' do
    it "received a list of pokemons" do
      VCR.use_cassette("poke_service_pokemons") do
        result = subject.pokemons
        expect(result["count"]).to eq 1302
        expect(result["next"]).to eq "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20"
        expect(result["results"].class).to eq Array
      end
    end
  end
end
