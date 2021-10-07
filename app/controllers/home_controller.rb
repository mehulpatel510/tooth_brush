class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_id

  def index
    render "index"
  end
end
