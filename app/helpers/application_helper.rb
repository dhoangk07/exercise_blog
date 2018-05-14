module ApplicationHelper
  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def active_class(controller, action)
    if controller_name == controller && action_name == action
      'active-navigation'
    else
      ''
    end
  end
end
