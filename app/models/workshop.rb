class Workshop < ActiveRecord::Base
  translates :name, :what, :where, :who, :bring_along
  #default_scope :conditions => {:enabled => true}
 scope :published, -> { where(enabled: true) }
 

  def self.this_month
      where("release_date > ? and release_date < ?", Date.today.at_beginning_of_month, Date.today.at_beginning_of_month.next_month)

  end

  def self.next_month
    if (Time.now.mday.to_i > 20 )
      where("release_date > ? and release_date < ?", Date.today.at_beginning_of_month.next_month, Date.today.at_beginning_of_month.next_month.next_month)
    end
  end

end
