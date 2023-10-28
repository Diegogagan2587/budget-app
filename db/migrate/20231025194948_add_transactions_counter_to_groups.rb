class AddTransactionsCounterToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :transactions_counter, :integer
  end
end
