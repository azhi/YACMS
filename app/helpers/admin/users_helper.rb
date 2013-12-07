module Admin::UsersHelper

  # Returns the form arguments required to create or update the page
  def user_form_values(user)
    [:admin, user]
  end
end
