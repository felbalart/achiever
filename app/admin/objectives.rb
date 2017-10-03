ActiveAdmin.register Objective do
permit_params :text, :achieved, :user_id, :period_id,
  :obj1, :obj2, :obj3, :obj4, :obj5, :obj6

  actions :all, except: [:show]
  before_action :check_skip_sidebar, only: :index


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
    column('Objetivo') { |obj| obj.text }
    unless params[:scope] == 'periodo_abierto'
      column('Cumplido') do |obj|
        unless obj.period.state.open?
          ("<span class=achieved_#{obj.achieved}>" + {true => 'SI', false => 'NO', nil => 'N/D'}[obj.achieved] + '</span>').html_safe
        end
      end
      [false, true].each do |value|
        column('Marcar') do |objective|
          if objective.user == current_user && objective.period.state.evaluation?
          link_to "#{value ? '' : 'No '}Cumplido",
                  objective_path(id: objective, objective: { achieved: value }),
                  method: :patch
          end
        end
      end
    end
    actions unless params[:scope] == 'periodo_evaluacion'
  end

  form title: proc { |obj| params[:action] == 'new' ? 'Ingresar Objetivos' : 'Editar Objetivo' } do |f|
    if Period.current.state.open? && resource.new_record?
      f.inputs do
        5.times do |i|
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
    # elsif params[:action] == 'edit' && resource.period.state.evaluation?
    #   f.inputs do
    #     f.input :text, :input_html => { :disabled => true }
    #     f.input :achieved
    #     f.actions
    #   end
    end
  end

  controller do
    def create
      objs = params[:objective].values.reject(&:blank?)
      pre_existing = current_user.objectives.where(period: Period.current)
      if !(objs.count + pre_existing.count).between?(3, 5)
        msg = 'Debes ingresar entre 3 y 5 objetivos para este periodo'
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

    def update
      update! do |format|
        format.html do
          if resource.period.state.evaluation?
            redirect_to objectives_path(scope: 'periodo_evaluacion')
          elsif resource.period.state.open?
            redirect_to objectives_path(scope: 'periodo_abierto')
          end
        end
      end
    end

    def check_skip_sidebar
      skip_sidebar! unless current_user.role.sysadmin?
    end
  end

  csv do
    column :id
    column('Usuario') { |obj| obj.user.name }
    column('Periodo') { |obj| obj.period.name }
    column('Cumplido') { |obj| obj.achieved }
    column :created_at
    column :updated_at
  end
end
