class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :task
      t.string :species
      t.decimal :price
    end
  end
end
