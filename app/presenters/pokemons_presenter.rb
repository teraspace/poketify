class PokemonsPresenter < BasePresenter

  attr_accessor :total_pages, :next, :limit, :offset

  def initialize(data, item_presenter)
    @limit = data["limit"] || 20
    @offset = data["offset"] || 0
    @count = data["count"]
    @next = data["next"]
    @previous = data["previous"]
    @page = data["page"] || 1
    @item_presenter = item_presenter
    @results = map_response(data["results"])
    @total_pages = nil
  end

  def offset
    @page * @limit
  end

  def total_pages
    @count / @limit
  end

  def next
    @next
  end

  private

  def map_response(data)
    data.map! do |k, _v|
      @item_presenter.new k
    end
  end

end
