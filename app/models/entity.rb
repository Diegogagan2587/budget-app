class Entity < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :group
  validates :name, presence: true
  validates :amount, presence: true
  validates :author, presence: true
  after_save :update_group_transactions_counter

  def update_group_transactions_counter
    group.update(transactions_counter: group.entities.count)
  end
end
