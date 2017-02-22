class CreateTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testimonials do |t|
      t.text :story
      t.string :name
    end
  end
end
