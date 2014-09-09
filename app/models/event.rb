class Event < ActiveRecord::Base
  default_scope { order(start_date: :asc) }
  belongs_to :location
  belongs_to :workshop
  validates_numericality_of :duration, :greater_than_or_equal_to => 0 
  validates :start_date, presence: true
  has_many :registrations

  default_scope -> {includes :workshop}

  just_define_datetime_picker :start_date

  def self.current time_range
    entries = retrieve_records(time_range, I18n.locale)
    # we are trying with the default locale, but this means that it is all of nothing situation
    # if a few entries are found only those will be displayed. If this is not acceptable we can change
    # the logic to use subsequent queries for localization
    if (entries.count == 0) 
      entries = retrieve_records time_range, I18n.default_locale
    end
    return entries
  end
  def self.within_period(start_time, end_time) 
    where('start_date >= ? AND start_date < ?', start_time, end_time)
  end 

  # BUG in Active Admin
  def name 
    result = I18n.l(start_date, :format => '%A') 
    result += "@#{location.name}" if location.name
  end

  def description
    result = I18n.l(start_date, :format => '%A') 
    result += "@#{location.name}" if location.name
    start_time = (start_date).strftime('%H:%M') 
    end_time = (start_date  + duration*60).strftime('%H:%M')
    result += ", #{I18n.l(start_date, :format => '%d %B')} #{I18n.t(:from)} #{start_time} #{I18n.t(:to)} #{end_time}"
  end

  private
  def self.retrieve_records time_range, locale
    return Event.joins(:workshop => :translations).where(workshops: {published: true}, events: { start_date: time_range }, 'workshop_translations.locale' => locale ).order("start_date").pluck(:id, :name, :start_date)
  end



end
