ActiveAdmin.register Objective do
permit_params :text, :achieved, :user_id, :period_id,
  :obj1, :obj2, :obj3, :obj4, :obj5, :obj6

  actions :all, except: [:show]

  filter :user, if: proc { current_user.role.sysadmin? }
  filter :period
  filter :text
  filter :achieved
  filter :created_at
  filter :updated_at


  scope 'Periodo Abierto', default: true do |objs|
    if current_user.role.sysadmin?
      objs.from_period_state(:open)
    else
      objs.where(user: current_user).from_period_state(:open)
    end
  end
  scope 'Periodo Evaluación' do |objs|
    if current_user.role.sysadmin?
      objs.from_period_state(:evaluation)
    else
      objs.where(user: current_user).from_period_state(:evaluation)
    end
  end
  scope 'Todas' do |objs|
    if current_user.role.sysadmin?
      objs
    else
      objs.where(user: current_user)
    end
  end

  index do
    column('Usuario') { |obj| obj.user.name } if current_user.role.sysadmin?
    column :period
    column('Estado Periodo') { |obj| obj.period.state_text }
    column :text
    column('Cumplido') do |obj|
      ("<span class=achieved_#{obj.achieved}>" + {true => 'SI', false => 'NO', nil => 'N/D'}[obj.achieved] + '</span>').html_safe
    end
    actions
  end

  form do |f|
    if Period.current.state.open? && resource.new_record?
      f.inputs do
        6.times do |i|
          field = i.zero? ? :text : "obj#{i + 1}".to_sym
          f.input field, label: "Objetivo #{i + 1}"
        end
      end
      f.actions
    elsif params[:action] == 'edit' && resource.period.state.open?
      f.inputs do
        f.input :text
        f.actions
      end
    elsif params[:action] == 'edit' && resource.period.state.evaluation?
      f.inputs do
        f.input :text, :input_html => { :disabled => true }
        f.input :achieved
        f.actions
      end
    end
  end

  controller do
    def create
      objs = params[:objective].values.reject(&:blank?)
      pre_existing = current_user.objectives.where(period: Period.current)
      if !(objs.count + pre_existing.count).between?(3, 6)
        msg = 'Debes ingresar entre 3 y 6 objetivos para este periodo'
        msg += " (ya tenias #{pre_existing.count} previamente creados.  Ir a 'Editar' para modificarlos)" unless pre_existing.empty?
        flash[:error] = msg
      elsif params[:objective][:text].present?
        params[:objective][:user_id] = current_user.id
        params[:objective][:period_id] = Period.current.id
        objs.each do |obj|
          Objective.create!(user: current_user, period: Period.current, text: obj) unless obj == params[:objective][:text]
        end
      end
      super
    end
  end
end
