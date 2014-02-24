class User < ActiveRecord::Base
  has_many :karma_points

  attr_accessible :first_name, :last_name, :email, :username

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  validates :username,
            :presence => true,
            :length => {:minimum => 2, :maximum => 32},
            :format => {:with => /^\w+$/},
            :uniqueness => {:case_sensitive => false}

  validates :email,
            :presence => true,
            :format => {:with => /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i},
            :uniqueness => {:case_sensitive => false}
#selects top 50 aggregate karma_point objects
#iterate over these
#update a user's total karma with the total karma that got calculated here
  def self.by_karma
    # joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')
    karma_objs = KarmaPoint.select("user_id,sum(value) as total_karma").group(:user_id).order("SUM(value) DESC").limit(50)
    users = karma_objs.map{|karma_obj| karma_obj.user}
  end

  # def total_karma
  #   self.karma_points.sum(:value)
  # end

  def full_name
    "#{first_name} #{last_name}"
  end
end
