class User <  ActiveRecord::Base

  has_many :travels
  has_secure_password

  def slug
    user_name.downcase.gsub(" ","-") if user_name
  end




  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end


end
