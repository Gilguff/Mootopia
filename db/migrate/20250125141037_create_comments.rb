class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :post
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
