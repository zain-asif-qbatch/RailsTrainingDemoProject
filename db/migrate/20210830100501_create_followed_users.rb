class CreateFollowedUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :followed_users, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.references :followed_user, null: false, foreign_key: { to_table: :users }

      t.index %i[user_id followed_user_id], unique: true
      t.timestamps
    end
  end
end
