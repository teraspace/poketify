module PaginationHelper
  def current_page
    params[:page] || 1
  end

  def page_list(collection)
    (1..collection.total_pages)
  end

  def prev_button(collection)
    link_to "&laquo;".html_safe, pokemons_path({page: (current_page.to_i >1 ? current_page.to_i-1 : 1), limit: collection.limit, offset: 0}), data: { turbo: false }
  end

  def page_item(collection, page)
    active =  (page.to_i == current_page.to_i ? 'active' : ' ')
    link_to page, pokemons_path({page: page, limit: collection.limit, offset: (collection.offset * (page))-20}), data: { turbo: false }, class: active
  end

  def last_button(collection)
    link_to collection.total_pages, pokemons_path({page: collection.total_pages, limit: collection.limit, offset: (collection.offset * (collection.total_pages))-20}), data: { turbo: false }, class: (collection.total_pages.to_i==params[:page].to_i ? 'active' : '')
  end

  def next_button(collection)
    link_to "&raquo;".html_safe, pokemons_path({page: current_page.to_i + 1, limit: collection.limit, offset: collection.offset}), data: { turbo: false }
  end
end
