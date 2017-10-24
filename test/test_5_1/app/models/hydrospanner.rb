class Hydrospanner < ActiveRecord::Base
  belongs_to :toolbox

  def to_h
    {
      name: name
    }
  end
end
