class Page < ActiveRecord::Base
  include CanRegenerateContent
  include HasClearUrl
  generate_clear_url_from :title

  has_and_belongs_to_many :images
  has_and_belongs_to_many :attachments
  has_and_belongs_to_many :snippets

  acts_as_nested_set
  include TheSortableTree::Scopes

  scope :in_menu, ->{ where(show_in_menu: true) }
end
