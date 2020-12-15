class EngineerController < ApplicationController

  require 'carrierwave/orm/activerecord'

  skip_before_action :verify_authenticity_token

  def singupc; end


  def engprofile; end


  def singine; end

  def signupe; end

  def certificatereport; 
  end


  def completeprofile
    @engineer = Engineer.where(engineer_id: 2)
    # @engineer.image.attach(engprofile_params[:image])
    @engineer.image.attach(io: File.open('app/assets/images/testimage.jpeg'), filename: 'testimage.jpeg', content_type: 'image/jpeg')

    @engineer.lname = (engprofile_params[:lname])
    @engineer.fname = (engprofile_params[:fname])
    @engineer.save
    flash[:notice] = 'successfully updated profile'
    redirect_to "engdashbaord"
  end
  def engprofile_params
    params.require(:engineer).permit(:fname , :lname, :image)
  end



  def engdashboard
    @current_projectID ||= Project.select(:id).where(engineer_id: 2).last
    @status = Project.where(id: @current_projectID).pluck(:workflow_state)
    if @status[0] == 'engnote'
      @engdone = 'Provided additional comments on the scope letter.'
      @engnext = ' Awaiting Customer review/approval.'
    elsif @status[0] == 'custnote'
      @engdone = 'Customer added  additional comments on the scope letter'
      @engnext = 'Review, Edit and provide feedback on the scope letter'
    elsif @status[0] == 'custapproved'
      @engdone = 'Customer Approved of the Scope Letter'
      @engnext = 'Approve Scope Letter, or Provide Additional Feedback'
    elsif @status[0] == 'engapproved'
      @engdone = 'Approved Scope Letter'
      @engnext = 'Issue Certificate Report upon Inspection Completion'
    elsif @status[0] == 'engapprovedA'
      @engdone = 'You approved the Scope Letter'
      @engnext = 'Wait for the customer to approve the Scope Letter'
    elsif @status[0] == "CRsubmitted"
      @engdone = "You issued the Certificate Report to the Customer"
      @engnext = "Hurray! You've completed another project!"
    end

  end

  def submitCR
      @project = Project.where(engineer_id: 2).last
      @project.crsubid = params[:crsubid]
      @project.workflow_state = "CRsubmitted"
      @project.save
      redirect_to '/engdashboard'
  end   

  def engchecklist
    @current_projectID ||= Project.select(:id).where(engineer_id: 2).last
    @custcomm = Project.where(id: @current_projectID).pluck(:custcomment)
    # @custcomm2 = custcomm[0]
  end



  def index; end

  def inspectionform; end

  def make_a_change
    some_special_id = params[:crntproj]
    @value = Project.where(id: :some_special_id)
    puts @value
  end



  # Engineer Create Function
  def create
    engineer = Engineer.new(engineer_params)
  
    if engineer.save
      # cookies[:remember_me] = @verifier.generate([@engineer.id, 2.weeks.from_now])
      session[:engineer_id] = engineer.id
      redirect_to '/signine'
    else
      flash[:register_errors] = engineer.errors.full_messages
      redirect_to '/signupe'
    end
  end

  def engineer_params
    params.require(:engineer).permit(:email, :fname, :lname, :image, :password, :password_confirmation)
  end



  # engineer add comments function
  def engcomment
    @project = Project.where(engineer_id: 2).last
    @project.engcomment = (engcomment_params[:engcomment])
    @project.workflow_state = 'engnote'
    @project.save
    redirect_to '/engdashboard'
  end


  def approved
      @project = Project.where(engineer_id: 2).last
      if @project.custapproval == true
        @project.workflow_state = 'engapproved'
        @project.engapproval = true
        @project.save
        redirect_to '/engdashboard'
      elsif @project.custapproval == false
	@project.workflow_state = 'engapprovedA'
	@project.engapproval = true
	@project.save
        redirect_to "/engdashboard"
      end 
  end

def engcomment_params
  params.require(:project).permit(:engcomment)
end

def engapproval_params
  params.require(:project).permit(:engapproval)
end

def crsubmit_params
 params.require(:project).permit(:subid)
end

def current_projectID
  @current_projectID ||= Project.select(:id).where(engineer_id: current_user.id).last
end

def current_user
  @current_user ||= Engineer.find(session[:engineer_id]) if session[:engineer_id]
end


end
