class SmallCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [166, 236]
end
