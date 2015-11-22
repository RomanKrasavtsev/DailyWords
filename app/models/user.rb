class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :cards, dependent: :destroy

  validates :password, confirmation: true
  validates :email, uniqueness: true
end
