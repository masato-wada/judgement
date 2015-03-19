class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true, :null => false
      t.references :select, index: true, :null => false
      t.integer :active_flg, :limit => 2, :default => 1, :null => false
      t.integer :delete_flg, :limit => 2, :default => 0, :null => false

      t.timestamps null: false
    end
    add_foreign_key :answers, :questions
    add_foreign_key :answers, :selects
  end
end
