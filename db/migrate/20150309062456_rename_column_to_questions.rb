class RenameColumnToQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :del_flg, :delete_flg
  end
end
