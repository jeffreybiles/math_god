class AddGodAndChallengeLevelToStorylet < ActiveRecord::Migration
  def change
    add_column :storylets, :god_id, :integer
    add_column :storylets, :challenge_level, :integer
  end
end
