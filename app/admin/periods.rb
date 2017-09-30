ActiveAdmin.register Period do
  permit_params :name, :current, :state
  actions :all, except: [:show]
end