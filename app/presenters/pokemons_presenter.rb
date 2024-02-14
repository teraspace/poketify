class PokemonsPresenter < BasePresenter

  def initialize(data, item_presenter)
    @count = data["count"]
    @next = data["next"]
    @previous = data["previous"]
    @item_presenter = item_presenter
    @results = map_response(data["results"])
  end

  private

  def map_response(data)
    data.map! do |k, _v|
      @item_presenter.new k
    end
  end

end
