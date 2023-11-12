class PurchaseRecordShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :region_id, :city, :house_number, :building_name, :telephone, :token, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :region_id, numericality: { other_than: 1, message: 'は配送先を選んでください' }
    validates :city, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は市町村区を記入してください' }
    validates :house_number, presence: { message: 'は番地を記入してください' }
    validates :telephone, format: { with: /\A[0-9]{10,11}\z/, message: 'は数字のみかつ10桁以上11桁以下の電話番号を入力してください' }
    validates :token, presence: true
    validates :user_id
    validates :item_id
  end

  validate :custom_postal_code_validation

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)

    Shipping.create(postal_code: postal_code, region_id: region_id, city: city, house_number: house_number,
                    building_name: building_name, telephone: telephone, purchase_record_id: purchase_record.id)
  end

  private

  def custom_postal_code_validation
    return unless postal_code.present?
    # 郵便番号がハイフンを含む場合、ハイフンの前が3桁でない場合
    return if postal_code.match?(/\A\d{3}-\d{4}\z/)

    errors.add(:postal_code, 'はハイフン(-)の前が3桁とハイフン(-)の後が4桁の数字でないと無効です')
  end
end
