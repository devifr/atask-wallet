list_team_name = ["Team 1" "Team 2" "Team 3"]

list_team_name.each do |name|
  Team.find_or_create_by!(name: name)
end
