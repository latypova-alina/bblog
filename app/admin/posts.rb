ActiveAdmin.register Post do
  actions :all

  permit_params :title, :content, :image, :user_id

  index do
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :content do |post|
      truncate(post.content, length: 120)
    end
    actions
  end

  filter :user, label: "Author", collection: proc { User.authors }

  show do
    attributes_table do
      row :title
      row :image do |post|
        image_tag post.image_url(:medium)
      end
      row :content
      row :author do |post|
        link_to post.user.full_name, admin_user_path(post.user)
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :user_id, label: "Author", as: :select, include_blank: false, collection: User.authors
      f.input :title
      f.input :content, as: :text
      f.input :image, as: :file

      f.submit
    end
  end
end
