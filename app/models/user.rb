class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email, :password

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{ |stuff| stuff.slug == slug }
  end

  def authenticate(user)
    binding.pry
    @user = User.find_by(username: user)
    if !@user.nil?
      @user
    else
      false
    end

  end



end
