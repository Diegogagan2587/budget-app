class Group < ApplicationRecord
  belongs_to :user
  has_many :entities
  validates :name, presence: true
  def initialize(attributes = {})
    super
    self.transactions_counter = 0
  end
end
