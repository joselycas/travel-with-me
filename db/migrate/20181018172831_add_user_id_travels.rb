class AddUserIdTravels < ActiveRecord::Migration[5.2]
  def change
    add_column :travels, :user_id, :integer
  end
end
