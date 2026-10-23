class EventsController < ApplicationController
  skip_before_action :authenticate, only: [ :index, :show ]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
