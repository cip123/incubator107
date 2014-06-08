class Event < ActiveRecord::Base
  default_scope { order(start_date: :asc) }
  belongs_to :location
  validates_numericality_of :duration, :greater_than_or_equal_to => 0 
  validates :start_date, presence: true

  def to_s
    result = I18n.l(start_date, :format => '%A') 
    result += "@#{location.name} " if location.name
    start_time = (start_date).strftime('%H:%M') 
    end_time = (start_date  + duration*60).strftime('%H:%M')
    result+= "#{I18n.l(start_date, :format => '%d %B')} #{I18n.t(:from)} #{start_time} #{I18n.t(:to)} #{end_time}"
  end

end
