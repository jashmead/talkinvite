module PeopleHelper

  def gravatar_for(person, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(person.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: person.name, class: "gravatar")
  end

end
