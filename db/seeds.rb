require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# NOTE: for some reason the prices aren't populating in the database -- this might be because we've entered data in with a $ when it's only expecting either an integer or a float, but not totally sure. Need to figure this out.
# XD
CSV.foreach("db/seed_data_products.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Product.create(row.to_hash)
end

CSV.foreach("db/seed_data_merchants.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Merchant.create(
      name: row[:name],
      email: row[:email],
      password_digest: row[:password]
      )
end

CSV.foreach("db/seed_data_reviews.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Review.create(row.to_hash)
end

CSV.foreach("db/seed_data_categories.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
end

# We need to have accurate table schemas for these migrations to work :D

#CSV.foreach("db/seed_data_order_items.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
#    OrderItem.create(row.to_hash)
#end

#CSV.foreach("db/seed_data_orders.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
#    Order.create(row.to_hash)
#end

