class Province < ActiveRecord::Base
  has_many :amj_cities
  has_many :amj_provinces
end
