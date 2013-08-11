class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :status, :user_id
  has_secure_password
  validates_presence_of :name
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  belongs_to :user

  def verified
  	self.user != nil
  end

  def verified_by
  	self.user
  end

  def access_level
    if self.status == 'Officer'
      3
    elsif self.status == 'Member'
      2
    elsif self.status == 'Verified'
      1
    elsif self.status == 'Untrusted'
      -1
    else
      0
    end
  end
end

# add email validation