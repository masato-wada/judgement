class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|

      t.references :question, index: true, :null => false
      t.references :tag, index: true, :null => false

      t.integer :active_flg, :limit => 2, :default => 1, :null => false
      t.integer :delete_flg, :limit => 2, :default => 0, :null => false

      t.timestamps null: false
    end
    add_foreign_key :question_tags, :questions
    add_foreign_key :question_tags, :tags

  end
end
