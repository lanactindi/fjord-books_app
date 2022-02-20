# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:peter)
    visit root_url
    fill_in 'Eメール', with: 'peter@example.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'a', text: '新規作成'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'メモ', with: 'first book'
    fill_in 'タイトル', with: 'this is first book'
    click_on '登録する'

    assert_text '本が作成されました。'
    click_on '戻る'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: 'second book'
    fill_in 'メモ', with: 'this is second book'
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '戻る'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'
  end
end
