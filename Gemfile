source( 'https://rubygems.org' )

gem( 'rails',         '4.1.1' )                                                             # The essential Ruby on Rails gem.

gem( 'bcrypt-ruby',   '3.1.2' )                                                             # Includes password-encrypting function BCrypt.
gem( 'haml-rails'             )                                                             # Allows HTML code to be written in HAML, a kind of HTML shorthand.
gem( 'jbuilder',      '2.0.0' )                                                             # Builds JSON APIs with ease.
gem( 'jquery-rails'           )                                                             # Instates jQuery as the JavaScript library.
gem( 'sass-rails',    '4.0.3' )                                                             # Allows the use of SCSS for style sheets.
gem( 'uglifier',      '1.3.0' )                                                             # Compresses JavaScript assets.

gem( 'tzinfo',                   { :platforms => [ :x64_mingw, :mingw, :mswin ] } )         # Provides Windows with the necessary zoneinfo files.
gem( 'tzinfo-data',              { :platforms => [ :x64_mingw, :mingw, :mswin ] } )         # Provides Windows with the necessary zoneinfo files.

group( :development, :test ) do
    gem( 'sqlite3'                      )                                                   # SQLite database gem.
end

group( :doc ) do
    gem( 'sdoc', 	            '0.4.0',                    { :require => false } )         # Wrapper for the rdoc command line tool.
end

group( :production ) do
    gem( 'pg',                 '0.17.1' )                                                   # PostgreSQL database gem.
end