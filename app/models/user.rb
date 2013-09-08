class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :status, :user_id
  has_secure_password
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
 
  belongs_to :user

  before_save do |u|
    if u.status == ''
      u.status = nil
    end
  end

  def verified
  	self.user != nil
  end

  def verified_by
  	self.user
  end

  def access_level
    levels = {'Admin' => 4, 'Officer' => 3, 'Member' => 2, 'Verified' => 1, 'Untrusted' => -1}
    if levels.has_key?(self.status) then levels[self.status] else 0 end
  end
end

# add email validation