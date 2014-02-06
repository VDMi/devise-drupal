require "test_helper"

class Encryptors < ActiveSupport::TestCase
  include Support::Swappers

  test 'should match a password created by drupal' do
    hash = Devise::Encryptable::Encryptors::DrupalHash.digest('admin', nil, nil, nil)
    compare = Devise::Encryptable::Encryptors::DrupalHash.compare(hash, 'admin', nil, nil, nil)
    assert_equal true, compare
  end
end
