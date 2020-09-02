class Memo < ApplicationRecord
  has_many :memo_posts, dependent: :destroy
  has_many :posts, :through => :memo_posts
  accepts_nested_attributes_for :memo_posts, allow_destroy: true
  belongs_to :user

  validates :title,presence: true, length:{maximum:30}
  validates :desc, presence: true, length:{maximum:3000}

end
