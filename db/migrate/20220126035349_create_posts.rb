class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :title
      t.text :content
      t.float :rate
      t.timestamps
    end
  end
end
