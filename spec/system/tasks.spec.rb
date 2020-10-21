require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ログイン前' do
		let(:user) { create(:user) }
		let(:task) { create(:task, user: user)}
    it 'タスクの新規作成画面に遷移できないこと' do
      visit new_task_path
			expect(page).to have_content 'Login required'
		end
    it 'タスクの編集画面に遷移できないこと' do
      visit edit_task_path(task)
			expect(page).to have_content 'Login required'
		end
  end

  describe 'ログイン後' do
    context '入力値が正常な場合' do
      let(:user) { create(:user) }
  		let(:task) { build(:task, user: user)}
			before { login(user) }
      it 'タスクの新規作成が出来ること' do
				visit new_task_path
				fill_in "Title", with: task.title
				fill_in "Content", with: task.content
				click_button "Create Task"
		    expect(page).to have_content 'Task was successfully created.'
			end
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
