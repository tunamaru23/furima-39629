require 'rails_helper'

RSpec.describe PurchaseRecordShipping, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user: user)
      @purchase_record_shipping = FactoryBot.build(:purchase_record_shipping, user_id: user.id, item_id: item.id)
    end

    context '商品が購入できる場合' do
      it 'すべての情報を正しく入力していれば商品を購入できる' do
        expect(@purchase_record_shipping).to be_valid
      end

      it '建物名はなくても任意入力のため商品を購入できる' do
        @purchase_record_shipping.building_name = ''
        expect(@purchase_record_shipping).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it '郵便番号が空の場合' do
        @purchase_record_shipping.postal_code = ''
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include "Postal code can't be blank"
      end

      it '都道府県名が選択されていない場合' do
        @purchase_record_shipping.region_id = '1'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Region は配送先を選んでください'
      end

      it '市区町村の欄が空の場合' do
        @purchase_record_shipping.city = ''
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'City は市町村区を記入してください'
      end

      it '番地の欄が空の場合' do
        @purchase_record_shipping.house_number = ''
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'House number は番地を記入してください'
      end

      it '電話番号の欄が空の場合' do
        @purchase_record_shipping.telephone = ''
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Telephone は数字のみかつ10桁以上11桁以下の電話番号を入力してください'
      end

      it '郵便番号に-(ハイフン)がない場合' do
        @purchase_record_shipping.postal_code = '8930000'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end

      it '郵便番号の-(ハイフン)の前が3桁の数字ではない場合' do
        @purchase_record_shipping.postal_code = '43999-032'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Postal code はハイフン(-)の前が3桁とハイフン(-)の後が4桁の数字でないと無効です'
      end

      it '郵便番号の-(ハイフン)後が4桁の数字ではない場合' do
        @purchase_record_shipping.postal_code = '43400-77'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Postal code はハイフン(-)の前が3桁とハイフン(-)の後が4桁の数字でないと無効です'
      end

      it '郵便番号に数字以外の入力がある場合' do
        @purchase_record_shipping.postal_code = 'テスト'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)',
                                                                          'Postal code はハイフン(-)の前が3桁とハイフン(-)の後が4桁の数字でないと無効です'
      end

      it '電話番号の欄に-(ハイフン)が含まれる場合' do
        @purchase_record_shipping.telephone = '090-3333-3333'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Telephone は数字のみかつ10桁以上11桁以下の電話番号を入力してください'
      end

      it '電話番号が10桁未満の場合' do
        @purchase_record_shipping.telephone = '090333333'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Telephone は数字のみかつ10桁以上11桁以下の電話番号を入力してください'
      end

      it '電話番号が11桁より大きい場合' do
        @purchase_record_shipping.telephone = '090333333332222'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Telephone は数字のみかつ10桁以上11桁以下の電話番号を入力してください'
      end

      it '電話番号の欄に文字が含まれる場合' do
        @purchase_record_shipping.telephone = '0909999999だ'
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include 'Telephone は数字のみかつ10桁以上11桁以下の電話番号を入力してください'
      end

      it 'tokenが空の場合' do
        @purchase_record_shipping.token = nil
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include "Token can't be blank"
      end

      it 'user_idが紐づいていない場合' do
        @purchase_record_shipping.user_id = nil
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include "User can't be blank"
      end

      it 'item_idが紐づいていない場合' do
        @purchase_record_shipping.item_id = nil
        @purchase_record_shipping.valid?
        expect(@purchase_record_shipping.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end