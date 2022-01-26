# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  rate       :float
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  validates :title, length: { minimum: 2 }
  validates :content, length: { maximum: 140 }

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
end
