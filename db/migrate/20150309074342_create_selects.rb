class CreateSelects < ActiveRecord::Migration
  def change
    create_table :selects do |t|
      t.references :question, index: true, :null => false
      t.string :desc, :null => false, :limit => 1024
      t.integer :active_flg, :limit => 2, :default => 1, :null => false
      t.integer :delete_flg, :limit => 2, :default => 0, :null => false

      t.timestamps null: false
    end
    add_foreign_key :selects, :questions
  end
end
