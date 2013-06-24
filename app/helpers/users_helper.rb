module UsersHelper

  # Return the Gravatar (http://gravatar.com) for a given user
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)     #metodo che implementa l’algoritmo di hashing MD. gli ID dei Gravatar sono basati sulla codifica hash MD5 dell’indirizzo mail dell’utente
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")     # l’helper ritorna un image_tag che è il modo Rails di implementare il tag HTML <img>

  end

end