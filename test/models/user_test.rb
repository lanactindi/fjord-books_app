# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#follow' do
    peter = users(:peter)
    gwen =  users(:gwen)
    assert_not Relationship.exists?(follower: peter, following: gwen)
    peter.follow(gwen)
    assert Relationship.exists?(follower: peter, following: gwen)
  end

  test '#following?' do
    peter = users(:peter)
    gwen =  users(:gwen)
    assert_not peter.following?(gwen)
    Relationship.create(follower: peter, following: gwen)
    assert peter.following?(gwen)
  end


  test '#followed_by?' do
    peter = users(:peter)
    gwen =  users(:gwen)
    assert_not peter.followed_by?(gwen)
    Relationship.create(follower: gwen, following: peter)
    assert peter.followed_by?(gwen)
  end

  test '#unfollow' do
    peter = users(:peter)
    gwen =  users(:gwen)
    peter.follow(gwen)
    assert Relationship.exists?(follower: peter, following: gwen)
    peter.unfollow(gwen)
    assert_not Relationship.exists?(follower: peter, following: gwen)
  end
end
