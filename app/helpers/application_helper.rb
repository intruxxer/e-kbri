module ApplicationHelper
  def site_name
    "eKBRI : Indonesian Embassy in South Korea"
  end
  
  def site_url
    if Rails.env.production? then
      uri = "http://id-embassy.kr/"
    end
    if Rails.env.development? then
      uri = "http://localhost:3000/"
    end
  end

  def wicked_pdf_image_tag_for_public(img, options={})
    if img[0] == "/"
      new_image = img.slice(1..-1)
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else
      image_tag "file://#{Rails.root.join('public', 'images', img)}", options
    end
  end

end
