class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.string :commentable_id, index: true
      t.string :commentable_type, index: true

      t.timestamps
    end
  end
end
