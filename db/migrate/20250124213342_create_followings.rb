class CreateFollowings < ActiveRecord::Migration[8.0]
  def change
    create_table :followings do |t|
      t.references :followee
      t.references :follower

      t.timestamps
    end
  end
end
