require 'spec_helper'

describe User do
  it { should have_many(:karma_points) }

  describe '#valid?' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:username) }
    it { should ensure_length_of(:username).is_at_least(2).is_at_most(32) }

    it { should validate_presence_of(:email) }

    context 'when a user already exists' do
      before { create(:user) }

      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end
  end

  describe '.by_karma' do
    it 'returns users in order of highest-to-lowest karma' do
      user_med   = User.create(first_name: "Joe", last_name: "Noname", username: "Joenoname", email: "joe@dbc.com")
      user_low   = User.create(first_name: "Laura", last_name: "Noname", username: "loenoname", email: "loe@dbc.com")
      user_high  = User.create(first_name: "Charlie", last_name: "Noname", username: "coenoname", email: "coe@dbc.com")
      TotalKarmaPt.create(user_id: user_high.id, total_karma: 1000)
      TotalKarmaPt.create(user_id: user_med.id, total_karma: 500)
      TotalKarmaPt.create(user_id: user_low.id, total_karma: 100)

      User.by_karma.should eq [user_high, user_med, user_low]
    end
  end

  describe '#total_karma' do
    let(:user) { create(:user_with_karma, :total => 500, :points => 2) }

    it 'returns the total karma for the user' do
      user.total_karma.should eq 500
    end
  end

  describe '#full_name' do
    let(:user) { build(:user) }

    it 'returns both the first and last names in a single string' do
      user.first_name = 'John'
      user.last_name  = 'Doe'

      user.full_name.should eq 'John Doe'
    end
  end

  describe '#page' do

    it 'returns the first page of users when there is no input' do
      user = User.create(first_name: "Joe", last_name: "Noname", username: "Joenoname", email: "joe@dbc.com")
      User.page.should eq([user])
    end

    it 'offsets users by 1000 when we look at the next page' do
      user = User.create(first_name: "Joe", last_name: "Noname", username: "Joenoname", email: "joe@dbc.com")
      User.page(2).should eq([])
    end

  end
end
