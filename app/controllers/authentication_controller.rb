class AuthenticationController < ApplicationController
  def singupc; end

  def custdashboard
    @current_projectID ||= Project.select(:id).where(customer_id: current_user.id).last
    @status = Project.where(id: @current_projectID).pluck(:workflow_state)
    @crsubid = Project.where(id: @current_projectID).pluck(:crsubid)
    if @status[0] == 'engnote'
      @custdone = 'Engineer submitted Additional Comments for the Scope Letter'
      @custnext = ' Review and Approve the Scope Letter, Or Provide Additional Comments'

    elsif @status[0] == 'custnote'
      @custdone = 'Provided additional Notes for the Scope Letter'
      @custnext = " Await Engineer's review and feedback"

    elsif @status[0] == "custapproved"
      @custdone = 'Approved Scope Letter.'
      @custnext = " Await engineer's review and Final Approval."

    elsif @status[0] == "engapproved"
      @custdone = 'Engineer Approved of the Scope Letter.'
      @custnext = " Await Inspection and Issueing of the Certificate Report."

    elsif @status[0] == "engapprovedA"
      @custdone = 'Engineer Approved of the Scope Letter.'
      @custnext = 'Approve the Scope Letter to move forward with the inspection or provide additional comments to keep it in review.'
    
    elsif @status[0] == "CRsubmitted"
      @custdone = 'The Engineer has issued the Certificate Report'
      @custnext = 'Review the Certificate Report in your Checklist'
    end

  end


def custchecklist
  @current_projectID ||= Project.select(:id).where(customer_id: current_user.id).last
  @engcomm = Project.where(id: @current_projectID).pluck(:engcomment)
  # @custcomm2 = custcomm[0]
end



def approved
 
  @project = Project.where(customer_id: current_user.id).last
  @project.workflow_state = 'custapproved'
  @project.custapproval = true
  @project.save
  redirect_to '/custdashboard'



end



def index; end

def inspectionform; end

# def custreview
#   @project = Project.where(customer_id: current_user.id).last
#   @project.workflow_state = "custnote"
#   @project.save
#   redirect_to "/custdashboard"
# end

# customer add comments function
def custcomment
  @project = Project.where(customer_id: current_user.id).last
  @project.custcomment = (custcomment_params[:custcomment])
  @project.workflow_state = 'custnote'
  @project.save
  redirect_to '/custdashboard'
end

# Customer Create Function
def create
  customer = Customer.new(customer_params)
  if customer.save
    session[:customer_id] = customer.id
    redirect_to '/inspectionform'
  else
    flash[:register_errors] = customer.errors.full_messages
    redirect_to '/signupc'
  end
end

private
def current_user
  @current_user ||= Customer.find(session[:customer_id]) if session[:customer_id]
end

private
def custapproval_params
  params.require(:project).permit(:custapproval)
end


private
def custcomment_params
  params.require(:project).permit(:custcomment)
end

private
def customer_params
  params.require(:customer).permit(:email, :password, :password_confirmation)
end



end
