class Post < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :title, presence: true
  validates :explanation, presence: true

  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_one_attached :image

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo_transparent.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
