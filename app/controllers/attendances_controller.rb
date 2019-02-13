class AttendancesController < ApplicationController
before_action :authenticate_administrator, only: [:index]
#before_action :already_attendee_or_admin

  def index
  @event = Event.find(params[:event_id])
  @all_attendances = @event.attendances
  end

  def new
  @event = Event.find(params[:event_id])
  @attendance = Attendance.new
  end

  def create
    @event = Event.find(params[:event_id])
    @amount = @event.price*100

    customer = Stripe::Customer.create(
     :email => params[:stripeEmail],
     :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    
    @attendance = Attendance.new(stripe_customer_id: charge[:customer], attendee: current_user, event: @event)

    if @attendance.save
      redirect_to root_path
    else
      flash[:danger] = "Il manque des informations"
      render :new 
    end


  end

  def edit
  end

  def show
  end

private

  def authenticate_administrator
    @event = Event.find(params[:event_id])
    unless current_user == @event.administrator
      flash[:danger] = "Vous n'avez pas accès à cette fonctionnalité"
      redirect_to event_path(params[:event_id])
    end
  end

  def already_attendee_or_admin
    @event = Event.find(params[:event_id])
    if (current_user == @event.administrator) || (@event.attendees.include?(current_user))
      flash[:danger] = "Vous n'avez pas accès à cette fonctionnalité"
      redirect_to event_path(params[:event_id])
    end
  end

end
