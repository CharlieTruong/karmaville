class TotalKarmaPt < ActiveRecord::Base
  attr_accessible :user_id, :total_karma
  belongs_to :user
end
