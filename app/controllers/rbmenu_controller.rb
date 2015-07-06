class RbmenuController < ApplicationController
  def show
    # collect a list of imageNames and the corresponding urls
    # to pass to the ANgularServies controlling the Users and Flowers
    @flower_urls = get_urls('flowers', '.png')
    @user_urls = get_user_urls()
  end

  private
  # no models in this demo so this placed here
  # collect urls of images from the files in assets/images

  # get a hash of the form { imageName: imageUrl}
  # for all files in the given directory (all files there assumed to be images)
  # which contain the substring 'qualifier'
  def get_urls(directory, qualifier)
    list = Dir.entries("#{Rails.root}/app/assets/images/#{directory}")
    Hash[list.collect{|f|
           [f.split('.')[0],  ActionController::Base.helpers.image_url("#{directory}/#{f}") ] if f.include?(qualifier) }.compact]
  end

  # get a hash of the form { imageName: {full: imageUrl, thumb: thumbUrl, tiny: tinyUrl} }
  # for all the image files in the images/users directory
  # files assumed to have the form  imageName_full.png, imageName_thumb.png, imageName_tiny.png
  def get_user_urls()
     all = {}
     user_file_types =  ['full', 'thumb', 'tiny']
     user_file_types.each do |file_type|
       file_substring ="_#{file_type}"
       urls = get_urls('users',  file_substring)
       urls.each do |key, value|
        user_name = key.split(file_substring)[0]
        all[user_name] ||= {}
        all[user_name][file_type] = value
       end
     end
     all
  end

end
