require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "association" do
    it "has_one a wallet" do
      association = Team.reflect_on_association(:wallet)
      expect(association.macro).to eq(:has_one)
      expect(association.options[:as]).to eq(:walletable)
    end
  end
end
