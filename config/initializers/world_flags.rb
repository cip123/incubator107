WorldFlags.config do |c|
  c.auto_select!


  # c.flag_list_tag = :div
  # c.flag_tag = :span
  # c.flag_text = ''


  #c.available_locales = [:ro, :en]
  #c.locale_source_priority = [:param, :domain, :browser, :ip]

  #c.languages = languages_hash # fx loaded from a yaml file
  #c.countries = countries_hash # fx loaded from a yaml file
  c.locale_flag_map = {
  	:en => :gb,
  	:ro => :ro
  }
end
  


