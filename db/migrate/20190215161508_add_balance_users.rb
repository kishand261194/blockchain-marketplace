class AddBalanceUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :balance, :decimal
  end

  def down
    add_column :users, :balance, :decimal
  end
end
