class User <  ActiveRecord::Base

  has_many :travels
  has_secure_password

  def self.slug
    self.user_name.downcase.gsub(" ","-")
  end



  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end


end
