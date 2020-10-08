require 'rails_helper'

RSpec.describe Task, type: :model do
	it "タイトルとステータスがあれば有効なこと" do
		user = create(:user)
		task = build(:task, user_id: user.id)
		expect(task).to be_valid
	end
	it "タイトルがなければ無効なこと" do
		user = create(:user)
		task = build(:task, user_id: user.id, title: "")
		task.valid?
		expect(task.errors[:title]).to include("can't be blank")
	end
	it "ステータスがなければ無効なこと" do
		user = create(:user)
		task = build(:task, user_id: user.id, status: "")
		task.valid?
		expect(task.errors[:status]).to include("can't be blank")
	end
	it "タイトルが重複していたら無効なこと" do
		user = create(:user)
		task = create(:task, user_id: user.id)
		task1 = build(:task, user_id: user.id)
		task1.valid?
		expect(task1.errors[:title]).to include("has already been taken")
	end
end
