# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#following? && #follow' do
    peter = users(:peter)
    gwen =  users(:gwen)
    assert_not peter.following?(gwen)
    peter.follow(gwen)
    assert peter.following?(gwen)
  end

  test '#followed_by?' do
    peter = users(:peter)
    gwen =  users(:gwen)
    assert_not peter.followed_by?(gwen)
    gwen.follow(peter)
    assert peter.followed_by?(gwen)
  end

  test '#unfollow' do
    peter = users(:peter)
    gwen =  users(:gwen)
    peter.follow(gwen)
    assert peter.following?(gwen)
    peter.unfollow(gwen)
    assert_not peter.following?(gwen)
  end
end
