class ChangeTotalToIntegerForOrders < ActiveRecord::Migration[5.1]
  def change
  	change_column :orders, :total, :integer
  end
end
