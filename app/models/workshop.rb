class Workshop < ActiveRecord::Base
  translates :name, :what, :where, :who, :bring_along
end
