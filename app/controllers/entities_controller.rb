class EntitiesController < ApplicationController
  before_action :authenticate_user!
  def new
    @user = current_user
    @entity = Entity.new(author: @user)
    respond_to do |format|
      format.html do
        render :new
      end
    end
  end

  def create
    @entity = Entity.new(entity_params)
    @entity.author = current_user
    format.html do
      if @entity.save
        redirect_to entities_path
      else
        render :new
      end
    end

    redirect_to entities_path
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end
