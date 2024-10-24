class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true
  belongs_to :executed_by, class_name: "User", foreign_key: "user_id"
  enum transaction_type: { credit: 0, debit: 1 }

  validates :amount, :transaction_type, presence: true
  validate :valid_transaction
  after_save :calculate_wallet

  private
    def valid_transaction
      if debit? && target_wallet.nil?
        errors.add(:base, "You must provide a target wallet for debit transactions.")
      elsif credit? && source_wallet.nil?
        errors.add(:base, "You must provide a source wallet for debit credit")
      end
    end

    def calculate_wallet
      if debit?
        update_balance(target_wallet)
      else
        update_balance(source_wallet)
      end
    end

    def update_balance(wallet)
      current_balance = wallet.balance
      new_balance = credit? ? current_balance - amount : current_balance + amount
      new_balance = [ new_balance, 0 ].max
      wallet.update(balance: new_balance)
    end
end
