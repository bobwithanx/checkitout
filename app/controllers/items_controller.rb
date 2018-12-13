class ItemsController < ApplicationController
  before_action :force_json, only: :search
  def index
    @results = Item.all.includes(:loans, :category)
    @pagy, @items = pagy(@results)
  end

  def search
    @search_term = params[:q]
    @items = Item.available.ransack(brand_or_name_or_inventory_tag_cont: @search_term).result(distinct: true)
  end

  def show
    @item = Item.find(params[:id])
    @pagy, @loans = pagy(@item.loans.includes(:member, :category))
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    # @item = Item.new(params.require(:Item).permit(:brand, :name, :serial_number, :inventory_tag))

    @item = Item.new(item_params)
    # @item.category = params[:category_id]

    if @item.save
      redirect_to items_path
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  private
  def force_json
    request.format = :json
  end

  def item_params
    params.require(:item).permit(:brand, :name, :serial_number, :inventory_tag, :category, :category_id, :image)
  end
end
