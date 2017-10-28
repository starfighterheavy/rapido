class Message < ApplicationRecord
  belongs_to :comlink

  def to_h
    {
      content: content
    }
  end

  def to_param
    token
  end
end
