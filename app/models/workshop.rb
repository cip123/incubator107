class Workshop < ActiveRecord::Base
  translates :name, :description, :with_whom, :bring_along, :whereabouts, :notification, :donation
  has_many :events, :dependent => :delete_all
  has_many :workshop_requests
  #has_many :registrations, :through => :events

  belongs_to :city
  belongs_to :group
  
  validates :name, presence: true 
  validates :city_id, presence: true 
  default_scope -> {includes :translations}

  just_define_datetime_picker :release_date

  def self.active time_range 
    entries = retrieve_records(time_range, I18n.locale)
    # we are trying with the default locale, but this means that it is all of nothing situation
    # if a few entries are found only those will be displayed. If this is not acceptable we can change
    # the logic to use subsequent queries for localization
    if (entries.count == 0)
      entries = retrieve_records time_range, I18n.default_locale
    end
    this_month_workshops = ActiveSupport::OrderedHash.new 
    next_month_workshops = ActiveSupport::OrderedHash.new 

    entries.each do |entry|      
      if ( Date.parse(entry[2].to_s) <= Date.today.end_of_month ) 
        this_month_workshops[entry[0]] = entry[1] unless this_month_workshops[entry[0]].present? 
      else
        next_month_workshops[entry[0]] = entry[1] unless next_month_workshops[entry[0]].present?
      end
    end

    return [this_month_workshops, next_month_workshops]
  end

  def future_events 
    events.where("workshop_id = ? and start_date > ?", id, Date.today)
  end

  def active?
    return events.count > 0 && events.last.start_date > Date.today
  end

  private
  def self.retrieve_records time_range, locale

    Workshop.joins(:events, :translations).where(published: true, workshop_translations: {locale: locale }, events: { start_date: time_range } ).order("events.start_date").pluck(:id, :name, :start_date)

  end

end
