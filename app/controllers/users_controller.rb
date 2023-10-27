class UsersController < ApplicationController
  def index; end

  def show
    return unless params[:id] == 'sign_out'

    sign_out
    redirect_to root_path
  end
end
