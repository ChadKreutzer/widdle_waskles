class CreateTestemonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testemonials do |t|
      t.string :review
      t.string :name
    end
  end
end
