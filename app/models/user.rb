class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '半角英数字で入力してください' },on: :create

  has_many :posts, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
