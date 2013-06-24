module SessionsHelper        #session_helper.rb 4 metodi


  # Sign in method: store the remember token in a permanent cookie (it lasts for 20 years...)
  # and set the user performing the sign in as the current user
  def sign_in(user)                             #1 permette di fare login mette il member token dell'utente e lo mette nel cookie
    cookies.permanent[:remember_token] = user.remember_token       #token è stato poi memorizzato, salvandolo in un cookie che scadrà 20 anni dopo la sua creazione
    # self is mandatory to tell Rails that current_user is a method already defined and not a variable to be created
    self.current_user = user # equivalent to: self.current_user=(user)         poi prende l'utente appena creato e lo mette come utente corrente.   self.current_user è un metodo che è definito li sotto.
  end

  # Set current user method: set the user performing the sign in as the current user      # user - The User to be used as current user in the session
  def current_user=(user)         #sarebbe il setter in java
    @current_user = user
  end

  # Get current user method: get the user corresponding to the remember token only if @current_user is undefined
  def current_user                           #sarebbe il getter in java. Se è nullo vado nel db  e lo prendo se non è nullo restituisce subito current_user.
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # Is the current user signed in?
  def signed_in?
    !current_user.nil?
  end

  # Sign out method: clear the current user instance variable and delete the corresponding cookie
  def sign_out                   # In sign_out il current_user viene impostato come nullo
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # Check if the given user is also the current user (for authorization purposes)
  #
  # user - The User to check the authorization for
  def current_user?(user)
    user == current_user
  end

end