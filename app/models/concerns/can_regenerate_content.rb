module CanRegenerateContent
  def regenerate_images
    img_regex = /(<img\s+data-image-id="(\d+)"\s+(data-image-resizing-height="(\d*)")?\s*(data-image-resizing-width="(\d*)")?\s*src="(.*)"\s*\/>)/x
    body.scan(img_regex).each do |img|
      img_id = img[1].to_i
      resize_height = img[3]
      resize_width = img[5]

      image = images.find(img_id)
      image_url = resize_height || resize_width ?
                    image.image.thumb("#{resize_width}x#{resize_height}").url :
                    image.image.url
      self.body = body.gsub(img[6], image_url)
    end
    body
  end

  def regenerate_files
    file_regex = /(<a\s+data-file-id="(\d+)"\s+href="(.*)"\s*\/?>)/x
    body.scan(file_regex).each do |file|
      attachment_id = file[1].to_i
      attachment = attachments.find(attachment_id)
      attachment_url = attachment.file.url
      self.body = body.gsub(file[2], attachment_url)
    end
    body
  end

  def regenerate_snippets
    snippet_regex = /(<span\s+data-snippet-id="(\d+)"\s*>(.*)<\/span>)/x
    body.scan(snippet_regex).each do |snippet|
      snippet_id = snippet[1].to_i
      snippet_obj = snippets.find(snippet_id)
      content = snippet_obj.render_content
      self.body = body.gsub(snippet[2], content)
    end
    body
  end

  [:regenerate_files, :regenerate_images, :regenerate_snippets].each do |method|
    define_method :"#{method}!" do
      send(method)
      save!
    end
  end
end
