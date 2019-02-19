class PostImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    process resize_to_fill: [500, 300]
  end

  version :large do
    process resize_to_fill: [850, 500]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
