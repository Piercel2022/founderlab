module ApplicationHelper
  include ActionView::Helpers::NumberHelper
    def resource_icon(category)
      case category
      when 'document'
        'fa-file-alt'
      when 'video'
        'fa-video'
      when 'template'
        'fa-copy'
      when 'tool'
        'fa-tools'
      else
        'fa-file'
      end
    end
    
    def render_star_rating(rating)
      full_stars = rating.floor
      half_star = (rating - full_stars) >= 0.5
      empty_stars = 5 - full_stars - (half_star ? 1 : 0)
      
      html = ''
      full_stars.times { html += '<i class="fas fa-star"></i>' }
      html += '<i class="fas fa-star-half-alt"></i>' if half_star
      empty_stars.times { html += '<i class="far fa-star"></i>' }
      
      html.html_safe
    end
end
  