require 'rails_helper'

RSpec.describe User, type: :model do
  describe "association" do
    it "has_one a wallet" do
      association = User.reflect_on_association(:wallet)
      expect(association.macro).to eq(:has_one)
      expect(association.options[:as]).to eq(:walletable)
    end

    it "has_many transactions" do
      association = User.reflect_on_association(:transactions)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid with a name, email, and password' do
        user = User.new(name: 'Devi Firdaus', email: 'devi@mail.com', password: 'password')
        expect(user).to be_valid
      end
    end

    context 'without a name' do
      it 'is not valid' do
        user = User.new(name: nil, email: 'devi@mail.com', password: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:name]).to include("can't be blank")
      end
    end

    context 'without an email' do
      it 'is not valid' do
        user = User.new(name: 'Devi Firdaus', email: nil, password: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end
    end

    context 'with a duplicate email' do
      it 'is not valid' do
        User.create(name: 'Devi Firdaus', email: 'devi@mail.com', password: 'password')
        user = User.new(name: 'Devi Fauzi', email: 'devi@mail.com', password: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("has already been taken")
      end
    end

    context 'without a password' do
      it 'is not valid' do
        user = User.new(name: 'Devi Firdaus', email: 'devi@mail.com', password: nil)
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("can't be blank")
      end
    end

    context 'with a short password' do
      it 'is not valid' do
        user = User.new(name: 'Devi Firdaus', email: 'devi@mail.com', password: 'short')
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end
  end

  describe 'secure password' do
    it 'encrypts the password' do
      user = User.create(name: 'Devi Firdaus', email: 'devi@mail.com', password: 'password')
      expect(user.authenticate('password')).to eq(user)
      expect(user.authenticate('wrong_password')).to be_falsey
    end
  end
end
