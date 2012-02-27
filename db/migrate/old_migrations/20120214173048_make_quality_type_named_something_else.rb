class MakeQualityTypeNamedSomethingElse < ActiveRecord::Migration
  def up
    remove_column :qualities, :type

    add_column :qualities, :quality_type, :string
  end
end
