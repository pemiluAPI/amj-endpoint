class AmjCity < ActiveRecord::Base
  belongs_to :province

  delegate :nama, to: :province, prefix: true
end
