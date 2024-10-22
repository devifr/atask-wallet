list_user = [
  { name: "User 1", email: "user1@mail.com" },
  { name: "User 2", email: "user2@mail.com" },
  { name: "User 3", email: "user3@mail.com" }
]

list_user.each do |user_data|
  user = User.find_or_initialize_by(user_data)
  user.password = "123123123"
  user.save
end
