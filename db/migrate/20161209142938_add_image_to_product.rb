class AddImageToProduct < ActiveRecord::Migration
  def change
    add_column :user, :image, :string
  end
end
