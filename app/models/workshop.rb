class Workshop < ActiveRecord::Base
  translates :name, :description, :with_whom, :bring_along, :whereabouts, :notification, :donation
  #default_scope :conditions => {:enabled => true}
  has_many :events
  scope :published, -> { where(enabled: true) }
  validates :city_id, presence: true 


  def self.this_month
      where("release_date > ? and release_date < ?", Date.today.at_beginning_of_month, Date.today.at_beginning_of_month.next_month)

  end

  def self.next_month
    if (Time.now.mday.to_i > 20 )
      where("release_date > ? and release_date < ?", Date.today.at_beginning_of_month.next_month, Date.today.at_beginning_of_month.next_month.next_month)
    end
  end

end
