class EventsController < ApplicationController
before_action :authenticate_user!, only: [:new]

  def index
  	@all_events = Event.all
  end

  def show
  	@event = Event.find(params[:id])
    @event_end_date = Event.end_date(params[:id])
  end

  def new
  	@event = Event.new
  end

  def create
    @event = Event.new(title: params[:title], description: params[:description], price: params[:price].to_i, location: params[:location], administrator: current_user, start_date: (params[:hour] +" "+ params[:day]), duration: params[:duration])
    # ajout image événement
    @event.event_picture.attach(params[:event_picture])

  	if @event.save
  		redirect_to root_path
  	else
  	  flash[:danger] = "Il manque des informations"
  	  render :new
  	end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    post_params = params[:event]
    # update image de l'événement si le champs n'est pas vide
    if (params[:event_picture]) != nil
      @event.event_picture.attach(params[:event_picture])
    end

    if @event.update(title: post_params[:title], description: post_params[:description], price: post_params[:price].to_i, location: post_params[:location], start_date: post_params[:start_date], duration: post_params[:duration])
      redirect_to event_path(params[:id])
    else
      flash[:danger] = "Il manque des informations"
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:notice] = "Vous avez supprimé un potin avec succès"
    redirect_to root_path
  end

private



end
