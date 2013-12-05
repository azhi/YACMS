module HasClearUrl
  extend ActiveSupport::Concern

  included do
    def self.generate_clear_url_from(field)
      acts_as_url field.to_sym,
                  url_attribute: :clear_url,
                  only_when_blank: true,
                  sync_url: true
    end

    def clear_url=(value)
      self[:clear_url] = value.to_url if value.present?
    end

    validates :clear_url, presence: true, uniqueness: true

    def find_by_clear_url(url)
      where(clear_url: url).first
    end
  end

  def to_param
    clear_url
  end
end
