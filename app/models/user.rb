class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :password


  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{ |stuff| stuff.slug == slug }
  end

  def authenticate(pass)
    @user = User.find_by(password: pass)
    if !@user.nil?
      @user
    else
      false
    end
  end

  def self.is_logged_in?(session)
      session.has_key?(:user_id)
  end


end
