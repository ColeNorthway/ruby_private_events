class EventsController < ApplicationController
  skip_before_action :authenticate, only: [ :index, :show ]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @event = Event.find(params[:id])
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
  end

  private

  def event_params
    params.expect(event: [ :name, :date, :location ])
  end
end
