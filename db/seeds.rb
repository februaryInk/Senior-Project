# Allow separate files for test, development, and production seeds by loading
# one file in accordance with the current environment.
if File.exist?( Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb" ) )
  puts "Loading #{[ 'db', 'seeds', Rails.env.downcase + '.rb' ].join( '/' )}..."
  begin
    # If there is an error that occurs during seeding, the transaction causes
    # all data seeded up to that point to be rolled back. This prevents the 
    # database from being incompletely seeded.
    ActiveRecord::Base.transaction do
      load( Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb" ) )
    end
  rescue StandardError => error
    puts 'Error: ' + error.message
    puts error.backtrace
  end
end
