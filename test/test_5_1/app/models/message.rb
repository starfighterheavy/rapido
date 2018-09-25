class Message < ApplicationRecord
  belongs_to :comlink

  def to_param
    token
  end
end
