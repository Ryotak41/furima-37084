class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  # パスワードは英数混合で6文字以上
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  # 名字は全角漢字、ひらがな、カタカナ
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  # 名前は全角漢字、ひらがな、カタカナ
  validates :name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  # 名字カナは全角カタカナのみ
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶ一-]+\z/ }
  # 名前カナは全角カタカナのみ
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヶ一-]+\z/ }
  validates :birthday, presence: true

  has_many  :items
  #has_many  :orders
end
