class KarmaPoint < ActiveRecord::Base
  attr_accessible :user_id, :label, :value
  belongs_to :user

  validates :user, :presence => true
  validates :value, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}
  validates :label, :presence => true
  after_create :increment_total_karma
  after_destroy :decrement_total_karma

  def increment_total_karma
    total_karma_pt = TotalKarmaPt.find_by_user_id(user_id)
    total_karma_pt.total_karma += value
    total_karma_pt.save
  end

  def decrement_total_karma
    total_karma_pt = TotalKarmaPt.find_by_user_id(user_id)
    total_karma_pt.total_karma -= value
    total_karma_pt.save
  end
end
