Jupdateserver.controllers :apiv1, :provides => [:json, :xml] do
  get :all, :map => '/updates' do
    @updates = Update.all()
    respond(@updates)  
  end

  get :show, :map => '/updates/:element' do
    @updates = Update.all(:element => params[:element])
    respond(@updates)
  end
end