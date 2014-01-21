class AddAdminUser < ActiveRecord::Migration
  def self.up
    user = User.create! email: 'admin@admin.com', password: 'admin'
    user.role = Role.find_by title: 'admin'
  end

  def self.down
    User.find_by(email: 'admin@admin.com').destroy
  end
end
