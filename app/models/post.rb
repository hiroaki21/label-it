class Post < ApplicationRecord
  has_many :memo_posts, dependent: :destroy
  has_many :memos, :through => :memo_posts
  belongs_to :user

  validates :body,presence: true, length:{maximum:140}

  def self.search(search,id)
    if search != ""
      Post.where('body LIKE(?)', "%#{search}%").where(user_id: "#{id}")
    else
      Post.all.where(user_id: "#{id}")
    end
  end
end
