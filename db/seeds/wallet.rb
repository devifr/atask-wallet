users = User.all
teams = Team.all
stocks = Stock.all
all_data = [ users, teams, stocks ].flatten

all_data.each do |data|
  wallet = Wallet.find_or_create_by!(walletable: data)
  wallet.balance = rand(10000)
  wallet.save
end
