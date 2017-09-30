ActiveAdmin.register Objective do
permit_params :text, :achieved, :user_id, :period_id,
  :obj1, :obj2, :obj3, :obj4, :obj5, :obj6

  actions :all, except: [:show]

  form do |f|
    f.inputs do
      6.times do |i|
        field = i.zero? ? :text : "obj#{i + 1}".to_sym
        f.input field, label: "Objetivo #{i + 1}"
      end
    end
    f.actions
  end

  controller do
    def create
      objs = params[:objective].values.reject(&:blank?)
      if objs.count < 3
        flash[:error] = 'Debe ingresar por lo menos 3 objetivos'
      else
        params[:objective][:user_id] = current_user.id
        params[:objective][:period_id] = Period.current.id
        objs.each { |obj| Objective.create!(user: current_user, period: Period.current, text: obj) }
      end
      super
    end
  end
end
