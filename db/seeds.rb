require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

CSV.foreach("db/seed_data_categories.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Categories.create(row.to_hash)
end

CSV.foreach("db/seed_data_reviews.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all}) do |row|
    Reviews.create(row.to_hash)
end

