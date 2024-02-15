class HelloController < ApplicationController
  skip_before_action :protect_pages
  def world
  end
end
