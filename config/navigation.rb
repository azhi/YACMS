# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = SimpleNavigationRenderers::Bootstrap2

  navigation.items do |primary|
    primary.item(:pages,
                 'Menu',
                 '#',
                 :if => proc { Setting.enable_menu && can?(:read, Page) },
                 :class => 'pages') do |pages|
      render_menu(pages)
    end
    primary.item(:posts,
                 'Posts',
                 posts_path,
                 :if => proc { Setting.enable_blog && can?(:read, Post) },
                 :class => 'posts')

    primary.item :admin,
                 'Admin',
                 admin_pages_path,
                 :if => proc { current_user && current_user.admin? }

  end

end
