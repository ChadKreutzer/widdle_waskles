class CreateSpecials < ActiveRecord::Migration[5.0]
  def change
    create_table :specials do |t|
      t.string :headline
      t.text :offer
      t.date :expires
    end
  end
end
