class GroupsController < ApplicationController
  before_action { redirect_to splash_index_path unless user_signed_in? }
  def index
    @categories = current_user.groups
  end

  def show; end

  def new
    @group = Group.new(
      user: current_user
    )

    respond_to do |format|
      format.html do
        render 'new'
      end
    end
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    respond_to do |format|
      format.html do
        if @group.save
          redirect_to groups_path
        else
          render 'new'
        end
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
