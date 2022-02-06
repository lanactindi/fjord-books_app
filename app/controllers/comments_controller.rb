# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: :create

  # POST /comments or /comments.json
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: @commentable.model_name.human)
    else
      flash.now[:alert] = "#{Comment.model_name.human}#{t('errors.messages.blank')}"
      render @commentable_template
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: @commentable.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_commentable
    @commentable = if params[:book_id]
                     Book.find(params[:book_id])
                   elsif params[:report_id]
                     Report.find(params[:report_id])
                   end
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
