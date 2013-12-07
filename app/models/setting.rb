class Setting < ActiveRecord::Base
  belongs_to :home_page, class_name: 'Page'

  class << self
    [:home_page, :home_page_id, :company_name, :enable_blog, :enable_menu].each do |method|
      delegate method, to: :first
    end
  end
end
