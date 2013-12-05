if Rails.env.development? 

  AuthorizedRailsScaffolds.configure do |config|
    # i.e. ['Category', 'User'] for Awesome/FooBar => awesome_category_user_foo_bars_path
    config.parent_models = []

    # toggles if shallow routes should be used
    config.shallow_routes = false
  end

end
