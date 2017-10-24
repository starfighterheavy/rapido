class Toolbox < ActiveRecord::Base
  belongs_to :account
  has_many :hydrospanners

  def to_h
    {
      name: name
    }
  end
end
