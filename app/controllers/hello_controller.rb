class HelloController < ApplicationController
  skip_before_action :protected_pages
  def world
  end
end
