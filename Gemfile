source( 'https://rubygems.org' )

# The essential Ruby on Rails gem.
gem( 'rails', '4.2.0' )

# Adds browser-specific CSS prefixes automatically.
gem( 'autoprefixer-rails' )

# Prints objects in a readable format.
gem( 'awesome_print' )

# Includes password-encrypting function BCrypt.
gem( 'bcrypt', '3.1.9' )

# Imports the Font Awesome icons.
gem( 'font-awesome-rails' )

# Allows HTML code to be written in HAML, a kind of HTML shorthand.
gem( 'haml-rails' )

# Builds JSON APIs with ease.
gem( 'jbuilder', '2.0.0' )

# Instates jQuery as the JavaScript library.
gem( 'jquery-rails' )

# Enables jQuery UI.
gem( 'jquery-ui-rails' )

# parse, manipulate, and format dates in JavaScript.
gem( 'momentjs-rails' )

# PostgreSQL database gem.
gem( 'pg', '0.18.1' )

# Allows the use of SCSS for style sheets.
gem( 'sass-rails', '4.0.3' )

# Compresses JavaScript assets.
gem( 'uglifier', '1.3.0' )

# Paginates long lists or tables.
gem( 'will_paginate', '3.0.7' )

source( 'https://rails-assets.org' ) do
    
    # draw SVG charts with JavaScript.
    gem( 'rails-assets-chartist' )
    
    # use a DSL to manage cookies with JavaScript.
    gem( 'rails-assets-js-cookie' )
    
    # detect the time zone of a user's browser with JavaScript.
    gem( 'rails-assets-jsTimezoneDetect' )
end


# Provides Windows with the necessary zoneinfo files.
gem( 'tzinfo', { :platforms => [ :x64_mingw, :mingw, :mswin ] } )

# Provides Windows with the necessary zoneinfo files.
gem( 'tzinfo-data', { :platforms => [ :x64_mingw, :mingw, :mswin ] } )


gem( 'therubyracer', { :platforms => [ :ruby ] } )
gem( 'execjs', { :platforms => [ :ruby ] } )


group( :development ) do
    # Provides a console on exception pages or when <%= console %> is in views.
    gem( 'web-console', '~> 2.0' )
end


group( :development, :test ) do
    # Generates fake information for tests and development.
    gem( 'faker' )
end


group( :test ) do
    # Reports code test coverage.
    gem( 'simplecov' )
    
    # Provides colored test output in Windows.
    gem( 'win32console', { :platforms => [ :x64_mingw, :mingw, :mswin ] } )
end
