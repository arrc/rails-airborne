# == Schema Information
#
# Table name: manufacturers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end