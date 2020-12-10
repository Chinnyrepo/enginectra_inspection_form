class Createprojects < ActiveRecord::Migration[5.1]
  def change
  
    create_table :engineers do |t| 
      t.string :email 
      t.string :password_digest
      t.string :seal
      t.timestamps 
    end
    create_table :customers do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
    end
    create_table :projects do |t|
      t.belongs_to :engineer
      t.belongs_to :customer
      t.string :Project_number
      t.string :Project_scope
      t.string :Elect_name
      t.string :Elect_email
      t.string :Elect_address
      t.string :fp_name
      t.string :fp_email
      t.string :fp_address
      t.string :Inspec_name
      t.string :Inspec_address
      t.string :Fp_representative
      t.timestamps
    end    
  end
end

