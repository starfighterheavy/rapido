class Comlink < ApplicationRecord
  has_many :messages

  def to_param
    token
  end

  def to_h
    {
      token: token
    }
  end

  def keys
    to_h.keys
  end
end
