require 'empty_widget'

class Toolbox < ActiveRecord::Base
  belongs_to :account
  has_many :hydrospanners

  validates :name, presence: true

  def build_empty_widget(params)
    EmptyWidget.new(params)
  end

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
