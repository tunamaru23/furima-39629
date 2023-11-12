class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]
  before_action :already_purchase, only: [:index, :create] # 購入者及びログインユーザーと未登録ユーザー

  def index
    # 購入フォームを表示するためのアクション
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']

    @purchase_record_shipping = PurchaseRecordShipping.new
  end

  def create
    # 購入情報を保存するアクション
    @purchase_record_shipping = PurchaseRecordShipping.new(purchase_record_params)

    if @purchase_record_shipping.valid?
      pay_item
      @purchase_record_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def find_item
    # 商品を検索するメソッド
    @item = Item.find(params[:item_id])
  end

  def purchase_record_params
    # 購入情報のパラメータを許可するメソッド
    params.require(:purchase_record_shipping).permit(
      :postal_code, :city, :house_number, :building_name, :telephone, :region_id
    ).merge(
      item_id: params[:item_id], user_id: current_user.id, token: params[:token]
    )
  end

  def already_purchase
    return unless user_signed_in? && (@item.purchase_record.present? || current_user == @item.user)

    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_record_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end