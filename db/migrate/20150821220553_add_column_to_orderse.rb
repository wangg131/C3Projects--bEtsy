class AddColumnToOrderse < ActiveRecord::Migration
  def change
    add_column :orders, :ship_price, :float 
  end
end
