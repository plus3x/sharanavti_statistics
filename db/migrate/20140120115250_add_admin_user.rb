class AddAdminUser < ActiveRecord::Migration
  def self.up
    user = User.create!( email: 'admin@sharanavti.ru', password: 'admin@sharanavti.ru' )
  end

  def self.down
    user = User.find_by email: 'admin@sharanavti.ru'
    user.destroy
  end
end
