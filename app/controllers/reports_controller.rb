# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :check_current_user, only: %i[edit update destroy]
  before_action :set_commentable_template, only: :show

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.build(report_params)
    respond_to do |format|
      if @report.save!
        format.html { redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @report.destroy
        format.html { redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human) }
      else
        format.html { render :index }
      end
    end
  end

  private

  def check_current_user
    @user = @report.user
    return redirect_to reports_path unless current_user == @user
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.fetch(:report).permit(:title, :content)
  end

  def set_commentable_template
    @commentable_template = 'reports/show'
  end
end
