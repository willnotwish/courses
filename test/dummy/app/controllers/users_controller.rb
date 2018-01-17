class UsersController < ApplicationController

  respond_to :html, :json

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    respond_with @users
  end

  # GET /users/1
  def show
    respond_with @user
  end

  # GET /users/new
  def new
    @user = User.new user_params
    respond_with @users
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.create user_params
    respond_with @user

    # if @user.save
    #   redirect_to @user, notice: 'User was successfully created.'
    # else
    #   render :new
    # end
  end

  # PATCH/PUT /users/1
  def update
    @user.update user_params
    respond_with @user
    # if @user.update(user_params)
    #   redirect_to @user, notice: 'User was successfully updated.'
    # else
    #   render :edit
    # end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_with @user, location: :users
    # redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find params[:id]
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit( :name )
    end
end
