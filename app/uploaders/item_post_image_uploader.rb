class ItemPostImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # store_dir は、アップロードされたファイルの保存先（ディレクトリ）を指定するメソッド
  # ここで public/uploaders/uploads/item_post/item_imageにIDごとに画像を保存する設定をしている
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # キャリーウェーブがアップロードできるファイル形式（拡張子）を制限している
  # extension_allowlist メソッドは、**CarrierWaveが提供するメソッド
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # S3を使用するのに記述した箇所
  # Railsの環境によってファイルの保存方法を切り替えるための設定
  # Rails.env.production? で、trueの場合(つまり本番環境)で storage :fog を使用し、それ以外の環境（開発・テスト）では storage :file する
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end
end
