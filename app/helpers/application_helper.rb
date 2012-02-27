module ApplicationHelper
  def find_challenge(god_name, level)
    if god_name == 'Additamentum'
      Challenges.addition(level)
    else
      Challenges.addition(level)
    end
  end

  def image_link(image, size = 'medium')
    link_to (image_tag (link_fu image, size)), image_path(image) if image
  end


end
