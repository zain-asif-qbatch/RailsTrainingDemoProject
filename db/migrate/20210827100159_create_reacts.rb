class CreateReacts < ActiveRecord::Migration[6.1]
  def change
    create_table :reacts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :reaction
      t.references :reactable, polymorphic: true, null: false

      t.index %i[user_id reactable_id reactable_type], unique: true

      t.timestamps
    end
  end
end
