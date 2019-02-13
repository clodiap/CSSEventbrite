class UsersController < ApplicationController
before_action :authenticate_user!, only: [:show, :edit]
before_action :verify_user_rights, only: [:show, :edit]
  
  def show
  	@user = User.find(params[:id])
    puts "*"*17
    @user.event_creations.each do |event|
      puts event.title
    end
    puts "*"*17
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	post_params = params[:user]

  	if @user.update(first_name: post_params[:first_name], last_name: post_params[:last_name], description: post_params[:description])
  		redirect_to user_path(params[:id])
  	else
  	  flash[:danger] = "Il manque des informations"
  	  render :new 
  	end
  end

private
  
  def verify_user_rights
  	unless current_user == User.find(params[:id])
  	flash[:danger] = "Vous ne pouvez pas faire ça !!"
    redirect_to user_path(current_user.id)
    end
  end

end


