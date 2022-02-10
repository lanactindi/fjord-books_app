# frozen_string_literal: true

class FollowRelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by(id: params[:following_id])
    return unless @user

    @active_relationship = current_user.follow(@user)
    @active_relationship.save
    redirect_to @user, notice: t('controllers.common.notice_create', name: User.model_name.human)
  end

  def destroy
    @user = FollowRelationship.find_by(id: params[:id])&.following
    return unless @user

    @passive_relationship = current_user.unfollow(@user)
    @passive_relationship.destroy
    redirect_to @user, notice: t('controllers.common.notice_destroy', name: User.model_name.human) 
  end
end
