class AddDefaultRoles < ActiveRecord::Migration
  def self.up
    Role.create! title:  'admin'
    Role.create! title: 'client'
  end

  def self.down
    Role.find_by(title:  'admin').destroy
    Role.find_by(title: 'client').destroy
  end
end
