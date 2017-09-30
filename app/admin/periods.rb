ActiveAdmin.register Period do
  permit_params :name, :current, :state
  actions :all, except: [:show]

  index do
    id_column
    column :name
    column :current
    column :state_text
    column :created_at
    column do |period|
      unless period.current
        link_to "Definir como actual", set_as_current_period_path(period), method: :post
      end
    end
  end

  member_action :set_as_current, method: :post do
    resource.class.update_all(current: false)
    resource.update(current: true)
    notice = "Periodo '#{resource.name}' definido como actual"
    redirect_to periods_path, notice: notice
  end
end