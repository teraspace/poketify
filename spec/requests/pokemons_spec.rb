require 'rails_helper'

RSpec.describe "Pokemons", type: :request do
  describe "GET /index" do
    it "render pokemons page" do
      VCR.use_cassette("pokemons_page") do
        get pokemons_url
        expect(response.status).to eq(200)
        expect(document.body).to match_text 'Bulbasaur'
      end
    end
  end

  describe "GET /show" do
    it "render pokemons description page" do
      VCR.use_cassette("pokemons_description_page") do
        get pokemon_url,  {id: 1}
        expect(response.status).to eq(200)
        expect(document.body).to match_text 'Bulbasaur'
        expect(document.body).to match_text 'Description'
      end
    end
  end
end
