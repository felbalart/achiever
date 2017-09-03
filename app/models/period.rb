class Period < ApplicationRecord
  has_many :objectives
end

# == Schema Information
#
# Table name: periods
#
#  id         :integer          not null, primary key
#  name       :string
#  current    :boolean
#  state      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
