module PokemonsHelper
  include Pagy::Frontend

  POKEMON_TYPES = {
    grass: 'text-bg-success',
    steel: 'text-bg-success',
    fire: 'text-bg-danger',
    water: 'text-bg-info',
    air: 'text-bg-info',
    electric: 'text-bg-info',
    normal: 'text-bg-primary',
  }.with_indifferent_access

  def pokemon_type(type)
    POKEMON_TYPES[type]
  rescue
    POKEMON_TYPES[:normal]
  end

end
