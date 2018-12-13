class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{ |stuff| stuff.slug == slug }
  end

  def self.is_logged_in?(session)
    session.has_key?(:user_id)
  end


end
