class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process resize_to_fill: [400, 400]
  end

  version :medium do
    process resize_to_fill: [500, 300]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url(*)
    "default_avatar_#{version_name}.png"
  end
end
