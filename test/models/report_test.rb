# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'report is editable' do
    peter = users(:peter)
    report = reports(:peter)
    assert report.editable?(peter)
  end

  test 'report is not editable' do
    report = reports(:peter)
    gwen = users(:gwen)
    assert_not report.editable?(gwen)
  end

  test '#created_on' do
    report = reports(:peter)
    assert_equal report.created_on, Time.zone.today
    assert_not_equal report.created_on, Time.zone.today - 1
    assert_not_equal report.created_on, Time.zone.today + 1
  end
end
