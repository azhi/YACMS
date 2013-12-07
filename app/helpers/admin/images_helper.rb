module Admin::ImagesHelper

  # Returns the form arguments required to create or update the image
  def image_form_values(image)
    [:admin, image]
  end

end
