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
    select('first_name,last_name,username,email,total_karma').joins(:total_karma_pt).order('total_karma DESC')
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
