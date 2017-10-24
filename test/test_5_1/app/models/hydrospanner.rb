class Hydrospanner < ActiveRecord::Base
  belongs_to :account

  def to_h
    {
      name: name
    }
  end
end
