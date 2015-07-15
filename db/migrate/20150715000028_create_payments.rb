class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :credit_card
      t.integer :exp_date
      t.integer :cvv
      t.integer :billing_zip

      t.timestamps null: false
    end
  end
end
