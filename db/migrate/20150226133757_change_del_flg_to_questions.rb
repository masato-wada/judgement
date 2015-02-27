class ChangeDelFlgToQuestions < ActiveRecord::Migration
  def change
    change_column :questions, :del_flg, :int, :limit => 2, :default => 0, :null => false
  end
end
