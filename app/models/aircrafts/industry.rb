# == Schema Information
#
# Table name: industries
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Industry < ApplicationRecord
  has_many :aircraftindustries
  has_many :aircrafts,  through: :aircraftindustries

  accepts_nested_attributes_for :aircrafts
end
