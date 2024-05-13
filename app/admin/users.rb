ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :city, :name, :bio

  # Добавьте кнопку на индексной странице для создания фейкового пользователя
  action_item :create_fake_user, only: :index do
    link_to 'Create Fake User', create_fake_admin_users_path, method: :post
  end

  # Экшн для создания фейкового пользователя
  collection_action :create_fake, method: :post do
    User.create!(
      email: Faker::Internet.email,
      password: '123456',
      password_confirmation: '123456',
      name: Faker::Name.name,
      bio: Faker::Lorem.sentence,
      city: Faker::Address.city
    )
    redirect_to collection_path, notice: "Fake user created successfully."
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :city
      f.input :name
      f.input :bio
    end
    f.actions
  end

  controller do

    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end
end
