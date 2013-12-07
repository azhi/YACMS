class AddCompanyNameToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :company_name, :string
  end
end
