module NewspapersHelper
  def writer_full_name(newspaper)
    newspaper.user.first_name.capitalize + " " + newspaper.user.last_name.capitalize
  end

  def switch(direction)
    if direction == 'asc'
      'desc'
    elsif direction == 'desc'
      'asc'
    else
      ''
    end
  end
end
