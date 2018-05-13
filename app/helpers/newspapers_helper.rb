module NewspapersHelper
  def writer_full_name(newspaper)
    newspaper.user.first_name.capitalize + " " + newspaper.user.last_name.capitalize
  end
end
