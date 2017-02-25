class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :before_filename
      t.string :after_filename
      t.string :caption
    end
  end
end
