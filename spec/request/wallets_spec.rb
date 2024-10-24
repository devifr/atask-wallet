require 'rails_helper'

RSpec.describe "Wallets API", type: :request do
  let!(:user) { create(:user) }
  let!(:wallet) { create(:wallet, :for_user, walletable: user) }
  let(:wallet_id) { wallet.id }
  let(:team) { create(:team) }
  let(:token) { JwtTokenService.encode(user_id: user.id) }
  let(:headers) { { "Content-Type": "application/json", "Authorization": "Bearer #{token}" } }

  describe "GET /wallets" do
    it "returns all wallets" do
      get "/wallets", headers: headers
      expect(response).to have_http_status(:success)
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end
  end

  describe "GET /wallets/:id" do
    it "returns the wallet" do
      get "/wallets/#{wallet_id}", headers: headers
      expect(response).to have_http_status(:success)
      expect(json['id']).to eq(wallet_id)
    end

    it "returns a 404 if the wallet is not found" do
      get "/wallets/0", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /wallets" do
    let(:valid_attributes) { { balance: 100.0, walletable_type: 'User', walletable_id: user.id }.to_json }
    let(:new_attribute) { { balance: 50.0, walletable_type: 'Team', walletable_id: team.id }.to_json }
    it "already have a wallet" do
      post "/wallets", params: valid_attributes, headers: headers
      expect(Wallet.count).to eq(1)
      expect(response).to have_http_status(:ok)
      expect(json['balance']).to eq('100.0')
    end

    it "creates a wallet" do
      post "/wallets", params: new_attribute, headers: headers
      expect(Wallet.count).to eq(2)
      expect(response).to have_http_status(:created)
      expect(json['balance']).to eq('50.0')
    end
  end

  describe "PUT /wallets/:id" do
    let(:valid_attributes) { { balance: 200.0 }.to_json }

    it "updates the wallet" do
      put "/wallets/#{wallet_id}", params: valid_attributes, headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['balance']).to eq("200.0")
    end
  end

  describe "DELETE /wallets/:id" do
    it "deletes the wallet" do
      expect {
        delete "/wallets/#{wallet_id}", headers: headers
      }.to change(Wallet, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "returns a 404 if the wallet does not exist" do
      delete "/wallets/0", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
