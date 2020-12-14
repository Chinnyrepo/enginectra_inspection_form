class Addfnameandlname < ActiveRecord::Migration[5.1]
  def change
    add_column :engineers, :fname, :string
    add_column :engineers, :lname, :string
    
  end
end
