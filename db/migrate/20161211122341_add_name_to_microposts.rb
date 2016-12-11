class AddNameToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :original_name, :string
  end
end
