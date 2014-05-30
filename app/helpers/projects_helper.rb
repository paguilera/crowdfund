module ProjectsHelper
  def format_pledging_ends_on(project)
    if project.pledging_expired?
      content_tag(:strong, 'All Done!')
    else
      distance_of_time_in_words(Date.today, project.pledging_ends_on) + " remaining"
    end
  end

  def image_for(project)
    if project.image_file_name.blank?
      image_tag 'placeholder.png'
    else
      image_tag project.image_file_name
    end
  end

  def format_pledge_link(project)
    if project.funded?
      content_tag(:strong, "Funded!")
    else
      link_to "Pledge!", new_project_pledge_path(project), class: 'pledge'
    end
  end
end
