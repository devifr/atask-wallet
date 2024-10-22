list_stock_name = ["Stock 1" "Stock 2" "Stock 3"]

list_stock_name.each do |stock|
  Team.find_or_create_by!(name: stock)
end
