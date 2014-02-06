require "test_helper"

class Encryptors < ActiveSupport::TestCase
  include Support::Swappers

  test 'should match a password created by devise-drupal' do
    hash = Devise::Encryptable::Encryptors::DrupalHash.digest('admin', nil, nil, nil)
    compare = Devise::Encryptable::Encryptors::DrupalHash.compare(hash, 'admin', nil, nil, nil)
    assert_equal true, compare
  end

  test 'should match a password created by Drupal 7' do
    hash = "$S$DSECOTv7C.aNnAAPVG.gOY718Xg5U3jFp11u76sqpKGDM3zm.f4O"
    compare = Devise::Encryptable::Encryptors::DrupalHash.compare(hash, 'admin', nil, nil, nil)
    assert_equal true, compare
  end

end
