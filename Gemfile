source( 'https://rubygems.org' )

gem( 'rails',         '4.2.0' )                                                             # The essential Ruby on Rails gem.

gem( 'bcrypt',        '3.1.9' )                                                             # Includes password-encrypting function BCrypt.
gem( 'haml-rails'             )                                                             # Allows HTML code to be written in HAML, a kind of HTML shorthand.
gem( 'jbuilder',      '2.0.0' )                                                             # Builds JSON APIs with ease.
gem( 'jquery-rails'           )                                                             # Instates jQuery as the JavaScript library.
gem( 'jquery-ui-rails'        )                                                             # Enables jQuery UI.
gem( 'pg',           '0.18.1' )                                                             # PostgreSQL database gem.
gem( 'sass-rails',    '4.0.3' )                                                             # Allows the use of SCSS for style sheets.
gem( 'uglifier',      '1.3.0' )                                                             # Compresses JavaScript assets.
gem( 'will_paginate', '3.0.7' )                                                             # Paginates long lists or tables.

gem( 'tzinfo',                   { :platforms => [ :x64_mingw, :mingw, :mswin ] } )         # Provides Windows with the necessary zoneinfo files.
gem( 'tzinfo-data',              { :platforms => [ :x64_mingw, :mingw, :mswin ] } )         # Provides Windows with the necessary zoneinfo files.

gem( 'therubyracer',             { :platforms => [ :ruby ] } )
gem( 'execjs',                   { :platforms => [ :ruby ] } )
gem( 'whenever',                 { :platforms => [ :ruby ], :require => false } )

group( :development ) do
    gem( 'web-console', '~> 2.0' )                                                          # Provides a console on exception pages or when <%= console %> is in views.
end

group( :development, :test ) do
    gem( 'faker' )                                                                          # Generates fake information for tests and development.
end

group( :doc ) do
    gem( 'sdoc', '0.4.0',        { :require => false } )                                    # Wrapper for the rdoc command line tool.
end

group( :test ) do
    gem( 'minitest-reporters' )                                                             # Provides a clearer assessment of test results.
    gem( 'win32console',         { :platforms => [ :x64_mingw, :mingw, :mswin ] } )         # Provides colored test output in Windows.
end