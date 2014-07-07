class SessionsController < AdminController

  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to admin_path
    else
      flash[:error] = 'Invalid email/password combination'
      render 'sessions/new'
    end
  end

  def destroy
    sign_out
    redirect_to admin_path
  end

end
