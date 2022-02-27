# frozen_string_literal: true

class FollowRelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    redirect_to @user, notice: t('controllers.common.notice_create', name: User.model_name.human)
  end

  def destroy
    @user = FollowRelationship.find(params[:id])&.following
    current_user.unfollow(@user)
    redirect_to @user, notice: t('controllers.common.notice_destroy', name: User.model_name.human) 
  end
end
