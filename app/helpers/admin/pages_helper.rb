module Admin::PagesHelper

  # Returns the form arguments required to create or update the page
  def page_form_values(page)
    [:admin, page]
  end
end
