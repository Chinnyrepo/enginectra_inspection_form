class EngineerController < ApplicationController

  skip_before_action :verify_authenticity_token



  def singupc; end



  def singine; end



  def signupe; end



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

    end

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

      session[:engineer_id] = engineer.id

      redirect_to '/signine'

    else

      flash[:register_errors] = engineer.errors.full_messages

      redirect_to '/signupe'

    end

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
#      flash.now[:notice] = "Await the approval from the customer"
#      end
  end



  # update status function

  # def updatestatus

  # @status = Project.where(engineer_id: 2).last.pluck(:workflow_state)

  # if status == "engnote"

  #   @engdone = "Provided additional comments on the scope letter."

  #   @engnext = " Awaiting Customer review/approval."



  # end



 # private
  def engcomment_params

    params.require(:project).permit(:engcomment)

  end



  def engineer_params

    params.require(:engineer).permit(:email, :password, :password_confirmation)

  end



#  private

def engapproval_params

  params.require(:project).permit(:engapproval)

end



  def current_projectID

    @current_projectID ||= Project.select(:id).where(engineer_id: current_user.id).last

  end



  def current_user

    @current_user ||= Engineer.find(session[:engineer_id]) if session[:engineer_id]

  end

end
end
