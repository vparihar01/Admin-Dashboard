class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable
  before_create :setup_username
  before_save :setup_role

  has_and_belongs_to_many :roles
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :role_ids

  def cas_extra_attributes=(extra_attributes)
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@#{extra_attributes.inspect}"
    extra_attributes.each do |name, value|
      case name.to_sym
        when :fullname
          self.fullname = value
        when :email
          self.email = value
      end
    end
  end

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  private
  # Default role is "Registered"
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end

  # TODO Need to remove this callback and make email as authenticate
  # Setting up username as deivise need username column to authenticate
  def setup_username
    self.username = self.email
  end

end

