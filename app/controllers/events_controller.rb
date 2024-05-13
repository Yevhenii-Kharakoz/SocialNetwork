class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:create, :edit, :update, :destroy, :new]
  before_action :set_event, only: [:destroy]


  def index
    @events = Event.all
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event
      if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
        end
      end
    end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Событие было успешно удалено.'
  end

  def show
    @event = Event.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to events_path, alert: "Event not found."
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: 'Событие успешно создано!'
    else
      render :new
    end
  end

  private

  def check_admin
    redirect_to root_path, alert: 'Нет доступа!' unless current_user.admin?
  end

  def set_event
    @event = Event.find_by(id: params[:id])
    redirect_to events_url, alert: 'Событие не найдено.' unless @event
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end
end

