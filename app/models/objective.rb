class Objective < ApplicationRecord
  belongs_to :user
  belongs_to :period
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
