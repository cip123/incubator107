class Workshop < ActiveRecord::Base
  translates :name, :description, :with_whom, :bring_along, :whereabouts, :notification, :donation
  has_many :events
  has_many :workshop_participants
  has_many :participants, :through => :workshop_participants

  belongs_to :city
  belongs_to :group
  validates :city_id, presence: true 
  default_scope -> {includes :translations}

  just_define_datetime_picker :release_date


  accepts_nested_attributes_for :events
  accepts_nested_attributes_for :participants

  def self.published time_range 
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
      if ( entry[2] <= Date.today.end_of_month ) 
        this_month_workshops[entry[0]] = entry[1] unless this_month_workshops[entry[0]].present?
      else
        next_month_workshops[entry[0]] = entry[1] unless next_month_workshops[entry[0]].present?
      end
    end

    return [this_month_workshops, next_month_workshops]
  end


  private
  def self.retrieve_records time_range, locale

    Workshop.joins(:events, :translations).where(published: true, workshop_translations: {locale: locale }, events: { start_date: time_range } ).order("events.start_date").pluck(:id, :name, :start_date)

  end

end
