class TransactionsController < ApplicationController
  def my_transaction
    transactions = current_user.transactions
    render json: transactions
  end

  def create
    ActiveRecord::Base.transaction do
      transaction = current_user.transactions.new(transaction_params)
      assign_wallets(transaction)

      if transaction.save
        render json: transaction, status: :created
      else
        render json: transaction.errors, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Wallet not found" }, status: :not_found
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :source_wallet_id, :target_wallet_id)
  end

  def assign_wallets(transaction)
    if transaction.credit?
      transaction.source_wallet = Wallet.find(transaction_params[:source_wallet_id])
    elsif transaction.debit?
      transaction.target_wallet = Wallet.find(transaction_params[:target_wallet_id])
    end
  end
end
