class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :service
      t.string :pet_type
      t.string :price
    end
  end
end
