CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production? 
    config.storage    = :aws
    config.aws_bucket = ENV['S3_BUCKET_NAME']
    config.aws_acl    = 'public-read'

    config.aws_credentials = {
      access_key_id:     ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET'],
      region:            ENV['S3_REGION']
    }
  else
    config.storage = :file
  end
end