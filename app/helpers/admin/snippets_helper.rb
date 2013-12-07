module Admin::SnippetsHelper

  # Returns the form arguments required to create or update the snippet
  def snippet_form_values(snippet)
    [:admin, snippet]
  end

end
