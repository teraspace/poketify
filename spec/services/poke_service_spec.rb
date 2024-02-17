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

    it "received details from pokemon" do
      VCR.use_cassette("poke_service_pokemon_detail") do
        result = subject.pokemon_detail("https://pokeapi.co/api/v2/pokemon/35")
        expect(result["id"]).to eq 35
      end
    end

    it "received evolutions from pokemon" do
      VCR.use_cassette("poke_service_pokemon_evolution") do
        result = subject.species_detail("https://pokeapi.co/api/v2/pokemon-species/35/")
        expect(result["id"]).to eq 35
      end
    end

  end

  describe "errrors from pokeapi" do
    before do
      # We send the recuest to a erroneous resource
      stub_const("PokeService::POKE_API_URL", "https://pokeapi.co/ap/v2/pokemon")
    end

    it "received error from PokeService" do
      VCR.use_cassette("poke_service_pokemons_error") do
        expect { subject.pokemons }.to raise_error(PokeApiPermanentError)
      end
    end
  end
end
