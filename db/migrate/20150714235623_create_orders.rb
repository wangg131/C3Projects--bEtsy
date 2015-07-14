class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.float :revenue
      t.integer :merchant_id
      t.integer :payment_id

      t.timestamps null: false
    end
  end
end
