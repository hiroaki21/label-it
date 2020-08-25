class Post < ApplicationRecord
  validates :body,presence: true, length:{maximum:140}

  belongs_to :user

  def self.search(search)
    if search != ""
      Post.where('body LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
end
