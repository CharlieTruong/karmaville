require 'spec_helper'

describe KarmaPoint do
  it { should belong_to(:user) }

  describe '#valid?' do
    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:label) }

    it { should validate_numericality_of(:value).only_integer }
    it { should allow_value(0).for(:value) }
    it { should allow_value(1).for(:value) }
    it { should_not allow_value(-1).for(:value) }
  end

  describe '#save' do
    it "increments the user's total_karma by the value of the karma point" do
      user = User.create(first_name: "Dave", last_name: "Noname", username: "doenoname", email: "doe@dbc.com")
      KarmaPoint.create(user_id: user.id, value: 10, label: "whatever")
      expect(user.total_karma).to eq(10)
    end
  end
end
