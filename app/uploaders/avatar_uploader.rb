class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :standard do
    cloudinary_transformation effect: "brightness:30",
      width: 200, height: 200, crop: :thumb, gravity: :face
  end

  version :navbar do
    cloudinary_transformation effect: "brightness:30",
      width: 40, height: 40, crop: :thumb, gravity: :face
  end
end
