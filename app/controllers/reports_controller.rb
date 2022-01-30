# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :check_current_user, only: %i[edit update destroy]

  def index
    @reports = Report.all
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.create(report_params)
    redirect_to report_path(@report.id)
  end

  def update
    @report.update(report_params)
    redirect_to report_path(@report.id)
  end

  def destroy
    @report.destroy
    redirect_to reports_path
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
end
