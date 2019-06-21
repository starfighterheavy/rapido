class Account < ActiveRecord::Base
  has_many :toolboxes
  has_many :hydrospanners, through: :toolboxes

  before_create do
    self.api_key ||= SecureRandom::uuid()
  end
end
