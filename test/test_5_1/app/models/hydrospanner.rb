class Hydrospanner < ActiveRecord::Base
  belongs_to :toolbox

  validates :name, presence: true

  def to_param
    name
  end

  def to_h
    {
      name: name
    }
  end

  def keys
    to_h.keys
  end
end
