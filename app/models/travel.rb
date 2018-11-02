class Travel <  ActiveRecord::Base
  belongs_to :user
  validates_presence_of :location, :activity, :travel_date

  # def has_required_fields?
  #  self.location && self.activity && self.travel_date
  # end

end
