Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'eposnow_admin_sidebar_menu',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/eposnow_sidebar_menu'
)