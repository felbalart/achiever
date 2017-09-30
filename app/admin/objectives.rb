ActiveAdmin.register Objective do
permit_params :text, :achieved

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
        binding.pry
        #.errors.add(:base, 'Debe ingresar por lo menos 3 objetivos')
      end
      super
    end
  end
end
