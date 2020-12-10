class EngineerController < ApplicationController
skip_before_action :verify_authenticity_token

  def singupc
  end

  def singine
  end

  def signupe
  end

  def engdashboard
  end

  def engchecklist
  end

  def index
  end

  def inspectionform
  end

  def make_a_change
  some_special_id = params[:crntproj]
  @value = Project.where(id: :some_special_id)
  puts @value
  end

#Engineer Create Function
  def create
    engineer = Engineer.new(engineer_params) 
    if engineer.save
      session[:engineer_id] = engineer.id 
      redirect_to '/signine'
    else 
      flash[:register_errors] = engineer.errors.full_messages
      redirect_to '/signupe'
    end
end

private 
  def engineer_params
    params.require(:engineer).permit(:email, :password, :password_confirmation)
  end
end

  def some_params
  params.require(:crntproj)
  end

    


