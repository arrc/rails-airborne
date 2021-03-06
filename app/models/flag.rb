# == Schema Information
#
# Table name: flags
#
#  id            :integer          not null, primary key
#  message       :text
#  user_id       :integer
#  flagable_type :string
#  flagable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :flagable, polymorphic: true
end
