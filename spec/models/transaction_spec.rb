require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "association" do
    it "belongs_to source_wallet as Wallet" do
      association = Transaction.reflect_on_association(:source_wallet)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("Wallet")
    end

    it "belongs_to target_wallet as Wallet" do
      association = Transaction.reflect_on_association(:target_wallet)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("Wallet")
    end

    it "belongs_to executed_by as User" do
      association = Transaction.reflect_on_association(:executed_by)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq("User")
      expect(association.foreign_key).to eq('user_id')
    end
  end
end
