# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_posts, through: :likes, source: :post

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  
  has_many :liked_posts, through: :likes, source: :post

  delegate :birthday, :introduction, :age, to: :profile, allow_nil: true

  def has_written?(post)
    posts.exists?(id: post.id)
  end

  def display_name
    if profile && profile.nickname
      profile.nickname 
    else
      self.email.split('@').first
    end
  end

  def prepare_profile
    profile || build_profile
  end

  def has_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def follow!(user)
    user_id = is_instance?(user)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)
    user_id = is_instance?(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end
  
  def has_followed?(user)
    is_instance?(user)
    following_relationships.exists?(following_id: user.id)
  end

  private
  def is_instance?(user)
    if user.is_a?(User)
      user_id = user.id
    else
      user_id = user
    end
  end
end
