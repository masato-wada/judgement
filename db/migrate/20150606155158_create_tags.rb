class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.string :name, :null => false, :limit => 1024
      t.integer :prioryty, :limit => 2, :default => 99, :null => false

      t.integer :active_flg, :limit => 2, :default => 1, :null => false
      t.integer :delete_flg, :limit => 2, :default => 0, :null => false

      t.timestamps null: false
    end
  end
end
