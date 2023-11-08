class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_items, only: [:edit, :show, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @user = current_user
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return if current_user == @item.user

    redirect_to root_path
    nil
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if user_signed_in?
      @item.destroy if @item.user == current_user
    else
      redirect_to new_user_session_path
    end
    redirect_to root_path
  end

  private

  def set_items
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :charge_id, :region_id,
                                :number_of_day_id, :price, :image).merge(user_id: current_user.id)
  end

end
