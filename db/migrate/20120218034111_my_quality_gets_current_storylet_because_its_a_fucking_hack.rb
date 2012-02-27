class MyQualityGetsCurrentStoryletBecauseItsAFuckingHack < ActiveRecord::Migration
  def change
    add_column :my_qualities, :current_storylet_id, :integer
  end
end
