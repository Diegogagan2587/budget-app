class Entity < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :group
  validates :name, presence: true
  validates :amount, presence: true
  validates :author, presence: true
end
