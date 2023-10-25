class GroupsController < ApplicationController
  before_action { redirect_to splash_index_path unless user_signed_in? }
  def index
    @categories = current_user.groups
  end

  def show; end
end
