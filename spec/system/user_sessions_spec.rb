require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  describe 'ログイン前' do
    context 'フォームの入力値が正常な場合' do
      let(:user) { create(:user) }

      it 'ログインが成功する' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
			  expect(current_path).to eq root_path
      end
    end

    context '登録されていないパスワードを入力した場合' do
      let(:user) { create(:user) }

      it 'ログインが失敗する' do
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'wrongpassword'
        click_button 'Login'
        expect(page).to have_current_path login_path
			  expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      let(:user) { create(:user) }

      before { login(user) }

      it 'ログアウト処理が成功する' do
        click_link 'Logout'
        expect(page).to have_content 'Logged out'
			  expect(current_path).to eq root_path
      end
    end
  end
end
