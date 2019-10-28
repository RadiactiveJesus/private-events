class UsersController < ApplicationController
  include ApplicationHelper

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: %i[check_invites]
  SQL = 'INNER JOIN events ON events.id = rsvps.attended_event_id'
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @events = @user.events.paginate(page: params[:page])
    @prev_events = @user.attended_events.prev.paginate(page: params[:page])
    @upcoming = @user.attended_events.upcoming.paginate(page: params[:page])
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

    respond_to do |format|
      if @user.save
        cookies.permanent[:remember_token] = @user.remember_token
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Allows a user to see all of the invitations they have not responded to.
  def check_invites
    @events_attendee = current_user.events_attendee.where(unopened).joins(SQL).order(date: :asc)
    render 'users/events_atendee'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def unopened
      { accepted: false, declined: false }
    end
  
    def accepted
      { accepted: true, declined: false }
    end
  
    def declined
      { accepted: true, declined: false }
    end
end
