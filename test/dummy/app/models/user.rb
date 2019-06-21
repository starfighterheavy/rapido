class User < ApplicationRecord
  belongs_to :account, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :protocol_droid

  before_create do
    self.account ||= Account.create!
  end

  def name
    email
  end
end
