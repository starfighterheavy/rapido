class User < ApplicationRecord
  belongs_to :account, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create do
    self.account ||= Account.create!
  end
end
