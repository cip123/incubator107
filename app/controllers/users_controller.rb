class UsersController < AdminController

  before_action :signedin_user, only: [:index, :destroy, :edit_profile, :show, :update_profile, :edit, :update]      
  before_action :admin_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit_profile, :show, :update_profile]
  before_action :correct_or_admin_user,  only: [:destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate( page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end


  def edit_profile
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])

    if @user.local_admin?
      @city.users.delete(@user)
      @city.users.inspect

    end

    @user.role = params[:user][:role]

    if @user.local_admin?
      @city.users << @user
    end

    if @user.save
      flash[:success] = "User updated"
      redirect_to edit_user_path(@user)
    else
      puts @user.errors.inspect
      render 'edit'
    end
  end

  def update_profile

    puts params[:user][:password].nil?
    @user = User.find(params[:id])

    puts profile_params[:password].nil?
    if @user.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit_profile'
    end
  end

  def create
    @user = User.new(profile_params)    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Incubator!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end

  # Before filters

  def signedin_user
    redirect_to signin_path unless !current_user.nil?
  end


  def correct_or_admin_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || current_user.admin?(@city)

  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end
