class ProjectController < ApplicationController 

  def engchecklist
  end



#Project Create Function
  def create
    project = Project.new(project_params.merge({customer_id: current_user.id}.merge({engineer_id: default_engineer.id}))) 
    if project.save  
      session[:project_id] = project.id
      redirect_to '/custdashboard'
    else 
      flash[:register_errors] = project.errors.full_messages
      redirect_to '/inspectionform'
    end
  end


  
    
  

  
  
  
  
  
  
  
  
  def custapprove
    puts 'Customer Approved'
    project = Project.custapprove!
    end
    def custnote
      console.log ("custnote worked")
    puts 'Customer provided additional comments'
    project = Project.custnote!
    end



  private 
    def project_params
      params.require(:project).permit(:Inspec_name, :Inspec_address, :Elect_name, :Elect_address,
      :Elect_email, :fp_name, :Fp_representative, :fp_address, :fp_email, :Project_scope, :Project_number, :pslid)
    end

  private
    def current_user
      @current_user ||= Customer.find(session[:customer_id]) if session[:customer_id]
    end

  private
    def current_project
      @current_project ||= Project.find(session[:customer_id]) if session[:customer_id]
    end

  private
    def default_engineer
      @default_engineer||= Engineer.find(2)
    end
end 

    


