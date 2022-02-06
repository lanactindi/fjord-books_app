# frozen_string_literal: true

class FollowRelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by(id: params[:following_id])
    return unless @user

    @active_relationship = current_user.follow(@user)
    respond_to do |format|
      if @active_relationship.save
        format.html { redirect_to @user, notice: t('controllers.common.notice_create', name: User.model_name.human) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to @user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = FollowRelationship.find_by(id: params[:id])&.following
    return unless @user

    @passive_relationship = current_user.unfollow(@user)
    respond_to do |format|
      if @passive_relationship.destroy
        format.html { redirect_to @user, notice: t('controllers.common.notice_destroy', name: User.model_name.human) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to @user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
