class SessionsController < ApplicationController
  
  def create 
    customer = Customer.find_by(email: login_params[:email])
    project = Project.where(customer_id: customer.id).last
    if customer && customer.authenticate(login_params[:password])
      # encrypted version of the customer id is stored in the cookies 
      session[:customer_id] = customer.id           
      redirect_to '/custdashboard'
    else
        flash[:login_errors] = ['invalid credentials']
        redirect_to '/signinc'
    end
  end

  private
    def login_params
        params.require(:login).permit(:email, :password)
    end

  def destroy
    session[:customer_id] = nil
    flash[:session] = "You have logged out"
    redirect_to '/index'
  end


  def index
  end

  def engchecklist
    Project.custapprove
  end
end
