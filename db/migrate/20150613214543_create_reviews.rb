class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.float :rating
      t.text :body
      t.integer :user_id, :video_id
      t.timestamps
    end
  end
end
