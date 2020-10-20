require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ログイン前' do
    it 'タスクの新規作成画面に遷移できないこと'
    it 'タスクの編集画面に遷移できないこと'
  end

  describe 'ログイン後' do
    context '入力値が正常な場合' do
      it 'タスクの新規作成が出来ること、マイページに新規作成したタスクが表示されること'
      it 'タスクの編集画面が出来ること'
      it 'タスクの削除が出来ること'
    end

    context 'タイトルが未入力の場合' do
      it 'タスクの新規作成に失敗すること'
      it 'タスクの編集に失敗すること'
    end

    it '他のユーザーのタスクの編集ページにせんいできないこと'
    it '他のユーザーの編集ページに遷移できないこと'
  end
end
