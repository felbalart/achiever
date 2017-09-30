ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :name, :role

  actions :all, except: [:show]

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :current_sign_in_at
    column :sign_in_count
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :password if resource == current_user
      f.input :password_confirmation if resource == current_user
      f.input :role
    end
    f.actions
  end

end
