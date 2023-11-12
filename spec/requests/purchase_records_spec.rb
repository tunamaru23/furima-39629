require 'rails_helper'

RSpec.describe 'PurchaseRecords', type: :request do
  describe 'GET /purchase_records' do
    it 'works! (now write some real specs)' do
      get purchase_records_index_path
      expect(response).to have_http_status(200)
    end
  end
end
