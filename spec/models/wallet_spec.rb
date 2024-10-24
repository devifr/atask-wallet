require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe "association" do
    it "belongs_to and polymorphic a wallet" do
      association = Wallet.reflect_on_association(:walletable)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:polymorphic]).to be_truthy
    end
  end
end
