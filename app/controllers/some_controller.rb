class SomeController < ApplicationController
skip_before_action :verify_authenticity_token

  def make_a_change
  some_special_id = params[:crntproj]
  @value = Project.where(id: :some_special_id)
  puts @value
end 
  

  def some_params
  params.require(:crntproj)
  end
end
