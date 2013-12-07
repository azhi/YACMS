# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = SimpleNavigationRenderers::Bootstrap2

  navigation.items do |primary|
    primary.item(:pages,
                 'Pages',
                 admin_pages_path,
                 :if => proc { can? :manage, Page },
                 :class => 'pages',
                 :highlights_on => /^\/page/)
    primary.item(:posts,
                 'Posts',
                 admin_posts_path,
                 :if => proc { Setting.enable_blog && can?(:manage, Post) },
                 :class => 'posts')
    primary.item(:images,
                 'Images',
                 admin_images_path,
                 :if => proc { can?(:manage, Image) },
                 :class => 'images')
    primary.item(:attachments,
                 'Files',
                 admin_attachments_path,
                 :if => proc { can?(:manage, Attachment) },
                 :class => 'attachments')
    primary.item(:users,
                 'Users',
                 admin_users_path,
                 :if => proc { can?(:manage, User) },
                 :class => 'users')
    primary.item(:settings,
                 'Settings',
                 edit_admin_setting_path(Setting.first),
                 :if => proc { can? :manage, Setting },
                 :class => 'settings',
                 :highlights_on => /^\/setting/)

    primary.item(:frontend,
                 'SW to Frontend',
                 root_path)

  end

end
