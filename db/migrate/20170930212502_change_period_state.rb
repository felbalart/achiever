class ChangePeriodState < ActiveRecord::Migration[5.1]
  def change
    change_column :periods, :state, :string
  end
end
