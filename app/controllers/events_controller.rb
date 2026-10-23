class EventsController < ApplicationController
  before_action :find_event, only: [ :show, :edit ]
  skip_before_action :authenticate, only: [ :index, :show ]

  def index
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

  def edit

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

  def our_post?
    @foreign_post = false
    our_helper do
      @foreign_post = true
    end
  end

  def our_helper
    event = Event.find(params[:id])
    id = event.host.id
    unless id == cookies.encrypted[:clubhouse_ticket]
      yield
    end
  end
end