# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:peter)
    visit root_url
    fill_in 'Eメール', with: 'peter@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'a', text: '新規作成'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'
    fill_in '内容', with: 'first report'
    fill_in 'タイトル', with: 'this is first report'
    click_on '登録する'

    assert_text '日報が作成されました。'
    click_on '戻る'
  end

  test 'updating a Report' do
    visit reports_url
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: 'second report'
    fill_in '内容', with: 'this is second report'
    click_on '更新する'

    assert_text '日報が更新されました。'
    click_on '戻る'
  end

  test 'commenting on a Report' do
    visit reports_url
    click_on '詳細', match: :first

    fill_in 'comment_content', with: 'nice report'
    click_on 'コメントする'

    assert_text 'コメントが投稿されました。'
    click_on '戻る'
  end

  test 'destroying a Report' do
    visit reports_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '日報が削除されました。'
  end
end
