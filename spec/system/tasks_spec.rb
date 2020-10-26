require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
	let(:user) { create(:user) }
	let(:task) { create(:task, user: user)}

  describe 'ログイン前' do
    it 'タスクの新規作成画面に遷移できないこと' do
      visit new_task_path
			expect(page).to have_content 'Login required'
			expect(current_path).to eq login_path
		end
    it 'タスクの編集画面に遷移できないこと' do
      visit edit_task_path(task)
			expect(page).to have_content 'Login required'
			expect(current_path).to eq login_path
		end
  end

  describe 'ログイン後' do
		before { login(user) }

    context '入力値が正常な場合' do
      it 'タスクの新規作成が出来ること' do
				visit new_task_path
				fill_in "Title", with: 'task_title'
				fill_in "Content", with: 'task_content'
				select 'doing', from: 'Status'
				fill_in 'Deadline', with: DateTime.new(2020, 10. 31, 0, 00)
				click_button "Create Task"
		    expect(page).to have_content 'Task was successfully created.'
			  expect(current_path).to eq task_path(1)
			end

			it '新規作成したタスクがユーザーマイページに表示されること' do
			  visit new_task_path
				fill_in "Title", with: task.title
				fill_in "Content", with: task.content
				click_button "Create Task"
        visit user_path(user)
				expect(page).to have_content 'first_title'
			  expect(current_path).to eq user_path(user)
			end

      it 'タスクの編集が出来ること' do
			  visit edit_task_path(another_task)
        fill_in "Title", with: task.title
				fill_in "Content", with: task.content
				click_button "Update Task"
				expect(page).to have_content "Task was successfully updated."
			  expect(current_path).to eq task_path(another_task)
			end

      it 'タスクの削除が出来ること' do
			  visit new_task_path
				fill_in "Title", with: task.title
				fill_in "Content", with: task.content
				click_button "Create Task"
			  visit tasks_path
				within first('tbody tr') do
				  page.accept_confirm do
            click_link "Destroy"
          end
				end
        expect(page).to have_content "Task was successfully destroyed."
			  expect(current_path).to eq tasks_path
			end
    end

    context 'タイトルが未入力の場合' do
      let(:user) { create(:user) }
			let(:another_user) { create(:user, email: "another_user@example.com", password: "password", password_confirmation: "password") }
  		let(:task) { build(:task, title: "",  user: user)}
			let(:another_task) { create(:task, title: "another_title", content: "another_content", user: user) }
			before { login(user) }
      it 'タスクの新規作成に失敗すること' do
			  visit new_task_path
				fill_in "Title", with: task.title
				fill_in "Content", with: task.content
				click_button "Create Task"
				expect(page).to have_content "Title can't be blank"
			  expect(current_path).to eq tasks_path
			end

      it 'タスクの編集に失敗すること' do
			  visit edit_task_path(another_task)
        fill_in "Title", with: task.title
				fill_in "Content", with: task.content
				click_button "Update Task"
				expect(page).to have_content "Title can't be blank"
			  expect(current_path).to eq task_path(another_task)
			end

    end
    describe '他のユーザーのタスクを操作出来ないこと' do
      let(:user) { create(:user) }
			let(:another_user) { create(:user, email: "another_user@example.com", password: "password", password_confirmation: "password") }
			let(:another_task) { create(:task, title: "another_title", content: "another_content", user: another_user) }
			before { login(user) }
      it '他のユーザーのタスクの編集ページに遷移できないこと' do
			  visit edit_task_path(another_task)
			  expect(page).to have_content "Forbidden access."
			  expect(current_path).to eq root_path
  		end
  	end
  end
end
