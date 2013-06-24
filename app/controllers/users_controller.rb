class UsersController < ApplicationController
  #before filter imposta dei filtri che verranno eseguiti prima dell'azione chiamata dal controllore
  # check if the user is logged in (e.g., for editing only his information)
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  # check if the current user is the correct user (e.g., for editing only his information)
  before_filter :correct_user, only: [:edit, :update]
  # check if the current user is also an admin-->l'utente di cui si vuole modificare il profilo sia il proprio
  before_filter :admin_user, only: :destroy


  def show
    # get the user with id :id
    @user = User.find(params[:id])
  end

  def new
    # temporary generate a new user - code to be removed
    @user = User.new
      #@user = User.create(name: 'Luigi', email: 'luigi.derussis@polito.it', password: 'prova123', password_confirmation: 'prova123')
  end

  def create         #crea un nuovo utente anche nel db
    # refine the user variable content with the data passed by the sign up form
    @user = User.new(params[:user])    #crea un nuovo utente utilizzando tutti i dati passati nel form e memorizzando il tutto nella variabile @user
    if @user.save
      ## se il salvataggio dei dati dell’utente nel DB va a buon fine
      flash[:success] = 'Welcome to SWorD'      #  messaggio di benvenuto quando la registrazione dell’utente va a buon fine, utilizzando la variabile speciale (una hash, in realtà)
      redirect_to @user   #bug-->c'era users anzichè user           #  rimandare alla pagina del profilo utente
    else
      render 'new'                  #altrimenti richiamare l'azione new che rimanda al form di registrazione
    end
  end

  def edit          #possibilità di aggiornare il proprio profilo
    # intentionally left empty since the correct_user method (called by before_filter) initialize the @user object
    # without the correct_user method, this action should contain:
    # @user = User.find(params[:id])
  end

  def update      # controlla la buona o la cattiva riuscita dell'aggiornamento e visualizza eventuali messaggi
    # intentionally left empty since the correct_user method (called by before_filter) initialize the @user object
    # without the correct_user method, this action should also contain:
    # @user = User.find(params[:id])
    # check if the update was successfully
    if @user.update_attributes(params[:user])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # re-login the user
      sign_in @user
      # go to the user profile
      redirect_to @user
    else
      # handle a failed update
      render 'edit'
    end
  end

  def index      #La possibilità di vedere, una volta eseguito il login, tutti gli utenti registrati al sito. Per generare un numero di utenti finti -->gemma faker
    # get all the users from the database - without pagination
    # @users = User.all

    # get all the users from the database - with pagination
    @users = User.paginate(page: params[:page], :per_page => 20)   #gli imposto anche un limite di 20 utenti per pagina

  end

  def destroy
    # delete the user starting from her id
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted!'
    redirect_to users_url
  end

  private

  # Show a message and redirect the user to the Sign in page if he is not logged in
  def signed_in_user
    redirect_to signin_url, notice: 'Please sign in' unless signed_in?
    # notice: 'Please sign in' is the same of flash[:notice] = 'Please sign in'
  end

  # Take the current user information (id) and redirect her to the home page if she is not the 'right' user
  def correct_user
    # init the user object to be used in the edit and update actions
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) # the current_user?(user) method is defined in the SessionsHelper
  end

  # Redirect the user to the home page is she is not an admin (e.g., if the user cannot perform an admin-only operation)
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end



