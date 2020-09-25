class MemoPost < ApplicationRecord
  belongs_to :memo
  belongs_to :post, dependent: :delete
end
