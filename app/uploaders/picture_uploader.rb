class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Redimensiona a imagem para ficar no tamanho de no máximo 500x500, mantendo o aspecto e cortando
  # a imagem, se necessário.
  process :resize_to_fill => [500, 500]

  # Dimensões do thumbnail.
  version :thumb do
     process resize_to_fill: [100, 100]
  end

  # Informa os formatos permitidos.
  def extension_whitelist
     %w(jpg jpeg gif png)
  end
end
