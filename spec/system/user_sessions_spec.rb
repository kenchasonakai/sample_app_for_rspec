		describe "ログイン" do
			context 'フォームの入力値が正常な場合' do
				let(:user) { create(:user) }
				it 'ログインが成功する' do
					visit login_path
					fill_in "Email", with: user.email
					fill_in "Password", with: "password"
					click_button "Login"
					expect(page).to have_content "Login successful"
				end
			end

			context '登録されていないパスワードを入力した場合' do
				let(:user) { create(:user) }
				it 'ログインが失敗する' do
					visit login_path
					fill_in "Email", with: user.email
					fill_in "Password", with: "wrongpassword"
					click_button "Login"
					expect(page).to have_current_path login_path
				end
			end
		end
