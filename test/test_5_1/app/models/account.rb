class Account < ActiveRecord::Base
  has_many :toolboxes
  has_many :hydrospanners, through: :toolboxes
end
