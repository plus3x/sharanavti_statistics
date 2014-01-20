class User < ActiveRecord::Base
  belongs_to :role
  has_secure_password
  
  before_validation on: :create do
    self.email = email.downcase if attribute_present?('email')
    self.role ||= Role.find_by(title: 'client')
  end
  
  validates_format_of   :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates_presence_of :email, :password
  validates_associated  :role
  validates_length_of   :password, minimum: 5
  
  def admin?
    role.title == 'admin'
  end
  
  def client?
    role.title == 'client'
  end
  
  def can?(controller, action)
    role.permit?(controller, action)
  end
end
