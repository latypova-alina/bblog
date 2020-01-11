ActiveAdmin.register User do
  actions :index, :show

  index do
    column :full_name
    column :role
    actions
  end

  filter :role, as: :select, collection: %i(reader author admin)

  show do
    attributes_table do
      row :full_name
      row :avatar do |user|
        image_tag user.avatar_url(:medium)
      end
      row :email
      row :role
      row :about_info
      row :created_at
    end
  end
end
