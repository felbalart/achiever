class Period < ApplicationRecord
  has_many :objectives

  def self.current
    find_by(current: true)
  end
end

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string
#  current    :boolean
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
