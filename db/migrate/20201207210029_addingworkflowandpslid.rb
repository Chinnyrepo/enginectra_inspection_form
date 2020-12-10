class Addingworkflowandpslid < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :pslid, :string
    add_column :projects, :workflow_state, :string
  end
end
