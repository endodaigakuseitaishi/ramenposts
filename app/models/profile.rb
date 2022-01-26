# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  birthday     :date
#  introduction :text
#  nickname     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  def age
    return '不明' unless birthday.present?
    years = Time.zone.now.year - birthday.year
    days = Time.zone.now.yday - birthday.yday

    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
