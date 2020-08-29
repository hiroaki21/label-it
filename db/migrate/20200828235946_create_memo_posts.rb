class CreateMemoPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :memo_posts do |t|
      t.references :post, index: true, foreign_key: true
      t.references :memo, index: true, foreign_key: true
      t.timestamps
    end
  end
end
