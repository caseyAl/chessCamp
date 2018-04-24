class FakeAdmin < ActiveRecord::Migration[5.1]
  def up
  	admin = User.new
  	admin.username = "basey"
  	admin.password = "secret"
  	admin.password_confirmation = "secret"
  	admin.role = "admin"
  	admin.save
  end

  def down
  	admin = User.find_by_username "basey"
  	User.delete admin 
  end
end
