class Admin::DashboardController < Admin::AdminbaseController
  layout 'admin'

  def index
    @users = User.all().count
  end

end