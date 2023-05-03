class ProyectosController < ApplicationController
  def index
  end

  def show
  end

  def new
      @proyecto = Proyecto.new
      @proyecto.instituciones.build
  end

  def create
  end

  def edit
  end

  def update
  end

  def institucion
      @data = '<div>
                   <label for="proyecto_instituciones_attributes_0_nominstitucion">Nominstitucion</label>
                   <input type="text" name="proyecto[instituciones_attributes][0][nominstitucion]" id="proyecto_instituciones_attributes_0_nominstitucion">
               </div>'
      @idx = (Time.now.to_f*1000.0).to_i
      respond_to do |format|
             #format.html { render html:@data}
             format.html { render partial: 'fields_institucion'}
      end 
  end


end
