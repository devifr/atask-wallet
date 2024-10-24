require 'rails_helper'

RSpec.describe "Authentication API", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { "Content-Type": "application/json" } }

  describe "POST /sign-in" do
    it "Sign In a User" do
      post "/sign-in", params: { email: user.email, password: "password123" }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(json).not_to be_empty
      expect(json["token"]).not_to be_empty
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
