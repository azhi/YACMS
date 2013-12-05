class Page < ActiveRecord::Base
  include HasClearUrl
  generate_clear_url_from :title

  acts_as_nested_set
  include TheSortableTree::Scopes

  scope :in_menu, ->{ where(show_in_menu: true) }
end
