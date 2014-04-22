class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
 

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    if signed_in?
      redirect_to(root_url)
    else
    @user = User.new
    end
  end

  def create
    if signed_in?
      redirect_to(root_url)
    else
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
     end
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user 
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])

    unless current_user?(user)
      user.destroy
      flash[:success] = "User deleted." 
    else
      flash[:error] = "You can't destroy yourself"
    end
    redirect_to users_url
  end

  def edit
  end




  private

	def user_params
	  params.require(:user).permit(:name, :email, :password,
	                                   :password_confirmation)
  end
      # Before filters


  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def signed_in_user
    unless signed_in?
      redirect_to signin_url, notice: "Please sign in." 
      store_location
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end


end
