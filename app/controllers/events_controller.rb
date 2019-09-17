class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :destroy, :attend]
  before_action :require_login, only: [:new, :create]

  # GET /events
  # GET /events.json
  def index
    if params[:events].nil? || params[:events][:type] == 'upcoming'
      @events = Event.upcoming.paginate(page: params[:page])
      @header = 'Upcoming Events'
    else
      @events = Event.prev.paginate(page: params[:page])
      @header = 'Previous Events'
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @event_attendees = @event.attendees
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    session[:event_id] = params[:id]
    @event = Event.find(params[:id])
    @users = User.where('id != ?', current_user.id)
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    event_id = session[:event_id]
    event = Event.find(event_id)
    ids = params[:event][:attendee_ids]
    ids.each do |id|
      next if event.events_attendees.exists?(attendee_id: id)
      event.events_attendees.create(attendee_id: id)
    end
    redirect_to event
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :event_date, :location)
    end

    def correct_user
      @event = Event.find(params[:id])
      @creator = User.find(@event.user_id)
      redirect_to(root_url) unless current_user?(@creator)
    end

    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_url
      end
    end

    def logged_in?
      !current_user.nil?
    end
end
