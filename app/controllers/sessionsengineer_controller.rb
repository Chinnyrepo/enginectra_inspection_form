class SessionsengineerController < ApplicationController
   
  def create 
    engineer = Engineer.find_by(email: login_params[:email])
    if engineer && engineer.authenticate(login_params[:password])
      # encrypted version of the customer id is stored in the cookies 
      session[:engineer_id] = engineer.id           
      redirect_to '/engdashboard'
    else
      flash[:login_errors] = ['invalid credentials']
      redirect_to '/signine'
    end
  end

  private
  def login_params
      params.require(:login).permit(:email, :password)
  end

  def destroy
    session[:engineer_id] = nil
    flash[:session] = "You have logged out"
    redirect_to '/index'
  end

  def index
  end
end