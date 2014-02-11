# Devise Drupal

[![Build Status](https://travis-ci.org/jerbob92/devise-drupal.png?branch=master)](https://travis-ci.org/jerbob92/devise-drupal)

Drupal Hash implementation for Devise Encryptable.

## Usage

Add it to your Gemfile

```ruby
gem "devise-drupal"
```

Follow the device-encryptable readme.

Add the `password_salt` methods to your model:

```ruby
class User < ActiveRecord::Base
  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end
end
```

Add the encryptor to your initializor

```
# This on top of your file:
require Rails.root.join('lib', 'devise', 'encryptable', 'encryptors', 'drupal_hash')

# This inside your "Devise.setup do |config|"
config.encryptor = :drupal_hash
```

Beware: updating your encryptor on a database will make the current passwords unusable!

And you're ready to go!

## Contributing

* Fork it
* Write your changes
* Commit
* Send a pull request

## License

GNU GENERAL PUBLIC LICENSE Version 2. 2014 .VDMi/ http://www.vdmi.nl

