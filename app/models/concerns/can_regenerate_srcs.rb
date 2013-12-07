module CanRegenerateSrcs
  def regenerate_img_srcs
    img_regex = /(<img\s+data-image-id="(\d+)"\s+(data-image-resizing-height="(\d+)")?\s*(data-image-resizing-width="(\d+)")?\s*src="(.*)"\s*\/>)/x
    body.scan(img_regex).each do |img|
      img_id = img[1].to_i
      resize_height = img[3].to_i
      resize_width = img[5].to_i

      image = images.find(img_id)
      image_url = !resize_height.zero? || !resize_width.zero? ?
                    image.image.thumb("#{resize_width}x#{resize_height}").url :
                    image.image.url
      self.body = body.gsub(img[6], image_url)
    end
    body
  end

  def regenerate_file_srcs
    file_regex = /(<a\s+data-file-id="(\d+)"\s+href="(.*)"\s*\/?>)/x
    body.scan(file_regex).each do |file|
      attachment_id = file[1].to_i
      attachment = attachments.find(attachment_id)
      attachment_url = attachment.file.url
      self.body = body.gsub(file[2], attachment_url)
    end
    body
  end

  def regenerate_file_srcs!
    regenerate_file_srcs
    save!
  end

  def regenerate_img_srcs!
    regenerate_img_srcs
    save!
  end
end
