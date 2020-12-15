
class AddSealimageToEngineers < ActiveRecord::Migration[5.2]
  def change
    add_column :engineers, :sealimage, :string
  end
end
