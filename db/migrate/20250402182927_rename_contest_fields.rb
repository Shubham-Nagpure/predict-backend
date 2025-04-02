class RenameContestFields < ActiveRecord::Migration[7.2]
  def change
    rename_column :contests, :matche_id, :match_id
    rename_column :contests, :team_size, :integer
    change_column :contests, :name, 'integer USING name::integer'
    change_column :contests, :contest_type, 'integer USING name::integer'
  end
end
