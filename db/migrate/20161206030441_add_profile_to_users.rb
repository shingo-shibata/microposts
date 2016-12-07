class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :birth_day, :date
    add_column :users, :region, :string
    add_column :users, :profile, :string
  end
end
