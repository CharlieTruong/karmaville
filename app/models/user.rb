class User < ActiveRecord::Base
  has_many :karma_points
  has_one :total_karma_pt

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
    select('users.id, first_name,last_name,username,email,total_karma').joins(:total_karma_pt).order('total_karma_pts.id')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_karma
    total_karma_pt.nil? ? 0 : total_karma_pt.total_karma
  end

  def self.page(num=nil)
    if num != nil && num > 0
      offset = (num - 1) * 1000
      limit(1000).offset(offset)
    else
      limit(1000)
    end
  end
end
