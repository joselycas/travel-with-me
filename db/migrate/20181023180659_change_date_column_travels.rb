class ChangeDateColumnTravels < ActiveRecord::Migration[5.2]
  def change
    rename_column :travels, :date, :travel_date
  end
end
