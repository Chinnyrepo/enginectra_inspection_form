class Addingimage < ActiveRecord::Migration[5.2]
  def change
    add_column :engineers, :image, :binary
  end
end
