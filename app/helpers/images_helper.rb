module ImagesHelper
  def count_uses(image)
    image.storylet_previews.count + image.storylet_successes.count + image.storylet_failures.count + image.storylet_actions.count + image.qualities.count
  end
end
