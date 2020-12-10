class Addingcomments < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :custcomment, :string
    add_column :projects, :engcomment, :string
  end
end
