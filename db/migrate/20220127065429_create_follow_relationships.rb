# frozen_string_literal: true

class CreateFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relationships do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
    add_index :follow_relationships, :follower_id
    add_index :follow_relationships, :following_id
    add_index :follow_relationships, %i[follower_id following_id], unique: true
  end
end
