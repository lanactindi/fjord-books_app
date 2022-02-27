# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :active_relationships, class_name: 'FollowRelationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy, inverse_of: :follower
  has_many :passive_relationships, class_name: 'FollowRelationship',
                                   foreign_key: 'following_id',
                                   dependent: :destroy, inverse_of: :following
  has_many :followings, through: :active_relationships
  has_many :followers, through: :passive_relationships
  has_one_attached :avatar

  def follow(other_user)
    active_relationships.create!(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by_following_id!(other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
