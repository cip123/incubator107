class PasswordResetsController < AdminController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:info] = "Email sent with password reset instructions."
    redirect_to admin_path
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
    	flash[:warning] = "Password reset has expired."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))

    	flash[:info] = "Password has been reset!"
      redirect_to admin_path
    else
      render :edit
    end
  end


end
