class EventsController < ApplicationController
  before_action :set_event, except: [:new, :create]
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

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

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
