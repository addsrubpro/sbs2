class User < ActiveRecord::Base
  has_one :person
  
  attr_accessor :password           #to create a virtual attribute
  attr_accessible :party_id, :username, :password, :password_confirmation  #:party_id is a hidden field in the new.html.erb
  validates_presence_of :party_id, :username, :password
  validates_confirmation_of :password
  validates_length_of :password, :within => 3..10
  
  validates_length_of :username, :within => 5..10
  validates_uniqueness_of :username
  
  before_save :encrypt_password
  
  #Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end