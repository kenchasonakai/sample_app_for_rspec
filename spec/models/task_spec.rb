require 'rails_helper'

RSpec.describe Task, type: :model do
  it "タイトルとステータスがあれば有効なこと" do
    user = create(:user)
    task = build(:task, user: user)
    expect(task).to be_valid
  end

  it "タイトルがなければ無効なこと" do
    user = create(:user)
    task = build(:task, user: user, title: "")
    task.valid?
    expect(task.errors[:title]).to include("can't be blank")
  end

  it "ステータスがなければ無効なこと" do
    user = create(:user)
    task = build(:task, user: user, status: "")
    task.valid?
    expect(task.errors[:status]).to include("can't be blank")
  end

  it "タイトルが重複していたら無効なこと" do
    user = create(:user)
    task = create(:task, user: user)
    task1 = build(:task, user: user)
    task1.valid?
    expect(task1.errors[:title]).to include("has already been taken")
  end
end
