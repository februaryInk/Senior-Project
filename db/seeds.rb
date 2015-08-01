# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Allow separate files for test, development, and production seeds by loading
# one file in accordance with the current environment.
if File.exist?(Rails.root.join("db", "seeds", "#{ Rails.env.downcase }.rb"))
  begin
    # If there is an error that occurs during seeding, the transaction causes
    # all data seeded up to that point to be rolled back. This prevents the 
    # database from being incompletely seeded.
    ActiveRecord::Base.transaction do
      load(Rails.root.join("db", "seeds", "#{ Rails.env.downcase }.rb"))
    end
  rescue StandardError => e
    puts e
  end
end