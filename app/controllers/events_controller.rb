class EventsController < ApplicationController
  # Helpers
  before_action :find_event, only: [ :show, :edit ]

  # Authorization
  before_action :our_user?, only: [ :edit, :update, :destroy ]
  before_action :our_event?, only: [ :show, :index ]

  # Authentication
  skip_before_action :authenticate, only: [ :index, :show ]

  def index
    @user = get_user_via_sess
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.build(event_params)
    @event.host = get_user_via_sess
    if @event.save
      flash[:success] = "Event successfully created"
      redirect_to event_path(@event.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event&.update(event_params)
      flash[:success] = "Event successfully updated"
      redirect_to event_path(@event.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:success] = "Successfully Deleted Event"
    redirect_to events_path
  end

  def attend
    event = Event.find(params[:id])
    user = get_user_via_sess

    if event.host == user
      flash[:error] = "You can only attend events created by other users"
      redirect_to events_path and return
    elsif event.attendees.include?(user)
      flash[:error] = "You cannot reattend an event"
      redirect_to events_path and return
    end

    event.attendees << user
    flash[:success] = "Thanks for attending #{event.name}"
    redirect_to events_path
  end

  def unattend
    event = Event.find(params[:id])
    user = get_user_via_sess

    if event.host == user
      flash[:error] = "You can only un-attend events created by other users"
      redirect_to events_path and return
    elsif !event.attendees.include?(user)
      flash[:error] = "You cannot un-attend an event you are not attending"
      redirect_to events_path and return
    end

    event.attendees.delete(user)
    flash[:success] = "Successfully unattended #{event.name}"
    redirect_to events_path
  end

  private

  def event_params
    params.expect(event: [ :name, :date, :location ])
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def our_user?
    our_helper do
      flash[:error] = "Error you do not have permissions to do that"
      redirect_to events_path
    end
  end

  def our_event?
    # Uses user to cross-reference Event.host
    @user = get_user_via_sess
  end

  def our_helper
    event = Event.find(params[:id])

    id = event.host.id
    unless id == cookies.encrypted[:remember] && id
      yield
    end
  end
end
