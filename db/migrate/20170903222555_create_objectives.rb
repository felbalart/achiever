class CreateObjectives < ActiveRecord::Migration[5.1]
  def change
    create_table :objectives do |t|
      t.references :user, foreign_key: true
      t.references :period, foreign_key: true
      t.string :text
      t.boolean :achieved

      t.timestamps
    end
  end
end
