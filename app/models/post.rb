class Post < ApplicationRecord
  validates :body,presence: true, length:{maximum:140}

  belongs_to :user

  def self.search(search,id)
    if search != ""
      Post.where('body LIKE(?)', "%#{search}%").where(user_id: "#{id}")
    else
      Post.all.where(user_id: "#{id}")
    end
  end
end
