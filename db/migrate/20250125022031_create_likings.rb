class CreateLikings < ActiveRecord::Migration[8.0]
  def change
    create_table :likings do |t|
      t.references :post
      t.references :user

      t.timestamps
    end
  end
end
