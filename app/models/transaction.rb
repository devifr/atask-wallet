class Transaction < ApplicationRecord
  belongs_to :source_wallet
  belongs_to :target_wallet
  enum transaction_type: { credit: 0, debit: 1 }

  validates :amount, :transaction_type, presence: true
  validate :valid_transaction

  private
    def valid_transaction
      if transaction_type == :debit && target_wallet.nil?
        errors.add(:base, "You must provide a target wallet for debit transactions.")
      elsif transaction_type == :credit && source_wallet.nil?
        errors.add(:base, "You must provide a source wallet for debit credit")
      end
    end
end