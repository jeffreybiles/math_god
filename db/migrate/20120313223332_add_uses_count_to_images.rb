class AddUsesCountToImages < ActiveRecord::Migration
  def change
    add_column :images, :uses_count, :integer
    Image.reset_column_information
    Image.all.each do |r|
      Image.update_counters r.id, :uses_count =>
          (r.storylet_previews.count + r.storylet_actions.count +
              r.storylet_failures.count + r.storylet_successes.count +
              r.qualities.count)
    end
  end
end
