class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    user = User.find_by(name: user_params[:name])
    if user == nil
      if user_params[:password] == params[:rpassword]
        if user_params[:password]!= '' && user_params[:password]!=' '
          if @user.save
            redirect_to login_url, :notice => "Signed up!"
          else
            render :new
          end
        else
          redirect_to signup_url, :notice => "ERROR, Password can't be empty"
        end

      else 
        redirect_to signup_url, :notice => "ERROR, password must be equals"
      end
    else
      redirect_to signup_url, :notice => "ERROR username already exits!"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user=User.find_by name: session[:user]
    #@notes = Note.where('user_id LIKE ?', "#{@user.id}")
    #@notes.each do |note|
     # note.destroy
    #end
    User.find(params[:id]).destroy
    redirect_to "/logout", :notice => "The user was successfully destroyed."
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :avatar, :admin)
    end
end