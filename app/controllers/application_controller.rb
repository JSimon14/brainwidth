class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_not_found(status=:not_found)
	render text: "#{status.to_s.titleize}", status: status
  end
  
  def render_forbidden(status=:forbidden)
  	render text: 'Forbidden', status: :forbidden
  end

  def render_unprocessable(status=:unprocessable_entity)
  	render text: 'Could Not Process your Request', status: :unprocessable_entity
  end

  @task = Task.new
  @category = Category.new


end
