class EntitiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_section = 'Transactions'
    @entities = Entity.all.where(author_id: current_user.id)
  end
  def new
    @current_section = 'New Transaction'
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
    respond_to do |format|
      format.html do
        if @entity.save
          flash[:success] = 'Transaction was successfully created.'
          redirect_to group_path(@entity.group_id)
        else
          flash.now[:error] = 'Transaction could not be created.'
          render :new
        end
      end
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount, :group_id)
  end
end
