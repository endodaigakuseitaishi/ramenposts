# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text
#  rate       :float
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord

  has_one_attached :eyecatch
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :title, length: { minimum: 2 }
  validates :content, length: { maximum: 140 }

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def author_name
    user.display_name
  end

  def comment_count
    comments.count
  end

  def like_count
    likes.count
  end
end
