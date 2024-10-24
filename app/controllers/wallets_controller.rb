class WalletsController < ApplicationController
  before_action :set_wallet, only: [ :show, :update, :destroy ]

  def index
    @wallets = Wallet.all
    render json: @wallets
  end

  def show
    render json: @wallet
  end

  def create
    return render json: @wallet, status: :ok if has_wallet?
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      render json: @wallet, status: :created
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def update
    debugger
    if @wallet.update(balance: wallet_params[:balance])
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @wallet.destroy
    head :no_content
  end

  def my_wallet
    @wallet = current_user.wallet
    if @wallet
      render json: @wallet, status: :ok
    else
      render json: { error: "Wallet not found" }, status: :not_found
    end
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Wallet not found" }, status: :not_found
  end

  def wallet_params
    params.require(:wallet).permit(:balance, :walletable_type, :walletable_id)
  end

  def has_wallet?
    @wallet = Wallet.find_by(walletable_type: params[:wallet][:walletable_type], walletable_id: params[:wallet][:walletable_id])
  end
end
