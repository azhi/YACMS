module Admin::AttachmentsHelper

  # Returns the form arguments required to create or update the attachment
  def attachment_form_values(attachment)
    [:admin, attachment]
  end

end
