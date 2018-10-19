class CreateTravels < ActiveRecord::Migration[4.2]
  def change
    create_table :travels do |t|
      t.string :location
      t.string :activity
      t.date :date

      t.timestamps null: false
     end
  end
end
