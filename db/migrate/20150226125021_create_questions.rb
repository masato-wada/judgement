class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.string :title, :null => false, :limit => 256
      t.string :desc, :limit => 1024
      t.datetime :limit_at
      t.integer :del_flg, :limit => 2, :default => 0
      t.timestamps null: false
    end
  end
end
