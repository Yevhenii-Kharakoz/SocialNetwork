class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  def attach_image(image_file)
    image.attach(image_file) if image_file.present?
  end
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "id_value", "updated_at", "user_id"]
  end
end
