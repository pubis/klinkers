class PagesController < ApplicationController
  def home
    redirect_to overview_path if current_user
  end
end