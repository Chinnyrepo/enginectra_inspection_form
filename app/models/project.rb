#require 'workflow'

class Project < ApplicationRecord
include Workflow   


workflow do
  state :new do
  event :custapprove, :transitions_to => :awaiting_review
  event :custnote, :transitions_to => :submitted_review
  end
  state :awaiting_review do
  event :review, :transitions_to => :being_reviewed
  end
  state :submitted_review do
  event :recieved_review, :transitions_to => :being_reviewed
  end
  state :being_reviewed do
  event :accept, :transitions_to => :accepted
  event :reject, :transitions_to => :rejected
  end
  state :accepted
  state :rejected
end



   belongs_to :customer
   belongs_to :engineer
end
