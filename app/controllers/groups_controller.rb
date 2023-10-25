class GroupsController < ApplicationController
  before_action { redirect_to splash_index_path unless user_signed_in? }
  def index; end
  def show; end
end
