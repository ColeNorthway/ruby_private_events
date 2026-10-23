class EventsController < ApplicationController
  before_action :find_event, only: [ :show, :edit ]
  before_action :our_user?, only: [ :edit, :update, :destroy ]
  before_action :our_event?, only: [ :show, :index ]
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