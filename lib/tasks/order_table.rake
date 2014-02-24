namespace :order do
  desc "order users by total karma points"
  task :order_users => [:environment] do
    TotalKarmaPt.destroy_all
    pts_by_user = User.select('users.id,SUM(karma_points.value) as total_karma').joins(:karma_points).group('users.id').order('SUM(karma_points.value) DESC')

    pts_by_user.each_slice(20000).each_with_index do |users, index|
      data = users.map do |user|
        [user.id, user.total_karma]
      end
      fields = [:user_id, :total_karma]
      TotalKarmaPt.import(fields, data, :validate => false)
    end
  end
end
