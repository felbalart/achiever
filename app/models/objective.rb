class Objective < ApplicationRecord
  belongs_to :user
  belongs_to :period

  attr_accessor :obj1
  attr_accessor :obj2
  attr_accessor :obj3
  attr_accessor :obj4
  attr_accessor :obj5
  attr_accessor :obj6

  validates_presence_of :text

  scope :from_period_state, ->(state) { joins(:period).where("periods.state = '#{state}'") }
  scope :from_open_period, -> { from_period_state(:open) }
  scope :from_closed_period, -> { from_period_state(:closed) }
  scope :from_evaluation_period, -> { from_period_state(:evaluation) }
end

# == Schema Information
#
# Table name: objectives
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  period_id  :integer
#  text       :string
#  achieved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_objectives_on_period_id  (period_id)
#  index_objectives_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (period_id => periods.id)
#  fk_rails_...  (user_id => users.id)
#
