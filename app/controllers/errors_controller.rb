class ErrorsController < ApplicationController
  def permanent_error
    render status: :not_found
  end

  def temporal_error
    render status: :internal_server_error
  end
end
