class Period < ApplicationRecord
  extend Enumerize
  has_many :objectives

  validate :one_current

  def one_current
    currents = Period.where(current: true).to_a
    if self.current
      currents << self unless currents.include?(self)
    else
      currents.delete(self) if currents.include?(self)
    end
    unless currents.count == 1
      errors.add(:current, 'Debe haber 1 periodo actual')
    end
  end

  def self.current
    find_by(current: true)
  end

  enumerize :state, in: [:open, :evaluation, :closed]
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
