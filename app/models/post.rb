class Post < ApplicationRecord
  validates :body,presence: true, length:{maximum:140}

  belongs_to :user

  def self.search(search)
    if search != ""
      Post.where('body LIKE(?)', "%#{search}%").order(id: "DESC")
    else
      Post.all.order(id: "DESC")
    end
  end
end
