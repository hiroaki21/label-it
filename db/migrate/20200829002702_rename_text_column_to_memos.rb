class RenameTextColumnToMemos < ActiveRecord::Migration[6.0]
  def change
    rename_column :memos,:text,:title
  end
end
