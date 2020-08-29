class CreateMemoPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :memo_posts do |t|

      t.timestamps
    end
  end
end
