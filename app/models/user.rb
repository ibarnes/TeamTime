class User < ActiveRecord::Base
  has_many :clocks
  attr_accessible :email, :password, :password_confirmation,:first_name,:last_name

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates :password,  :presence => true, :on => :create
   validates :email, :uniqueness => { :case_sensitive => false }, :presence => true, :format => {:with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def checkin?
    @clock = Clock.where('user_id = ? and DATE(created_at) = DATE(?) and in_out = ?',id, Date.today, 0).first != nil ? true : false
  end

  def checkout?(date)
    @clock = Clock.where('user_id = ? and DATE(created_at) = DATE(?) and in_out = ?',id, date, 1).first != nil ? true : false
  end



  def inout
    if checkin?
      'Out'
    else
      'In'
    end
  end

  def name
    first_name + ' ' + last_name
  end

  def doneforday?(date) #Used to check if the person has checked in and out for the day
    Clock.find(:all, :conditions => 
        ["created_at >= ? AND created_at <= ? and user_id = ?",
        date.beginning_of_day, date.end_of_day, id]).count > 1
    #Clock.find(:all, :conditions => ["created_at >= ? and created_at < ?", date, date + 1.day]).size == 2
    #Clock.where(:in_out => 2,:user_id => id).count == 2
  end


  def self.authenticate(email, password)
    user = find(:first, :conditions=>[ "lower(email) = ?", email.downcase ])
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
