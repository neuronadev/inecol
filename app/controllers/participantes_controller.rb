class ParticipantesController < ApplicationController
  def index
  end

  def show
      @participante = Participante.find(params[:id])
      @proyecto = @participante.proyecto
      @inv = @participante.pacademicos #.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'INV')
      @tec = @participante.ptecnicos #.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'TEC')
      @est = @participante.pestudiantes

      @inv_sum = @participante.pacademicos.sum(:porcentaje) #.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'INV').sum('pacademicos.porcentaje')
      @tec_sum = @participante.ptecnicos.sum(:porcentaje) #.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'TEC').sum('pacademicos.porcentaje')
      @tot_porc = @inv_sum.to_f + @tec_sum.to_f
  end

  def new
    @proyecto = Proyecto.find(session[:proyecto_id]) 
    @participante = Participante.new
    @participante.pacademicos.build
    @participante.pestudiantes.build
  end

  def edit
      @participante = Participante.find(params[:id]) 
      @inv_sum = @participante.pacademicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'INV').sum('pacademicos.porcentaje')
      @tec_sum = @participante.ptecnicos.includes(academico: [:tacademico, :persona]).where('tacademicos.clave':'TEC').sum('ptecnicos.porcentaje')
      @tot_porc = @inv_sum.to_f + @tec_sum.to_f
  end

  def update
      @participante = Participante.find(params[:id])
      @participante.update(participante_params)
      respond_to do |format|
           if @participante.save
               format.html { redirect_to participante_path(@participante) }
           else
               if @participante.errors.where(:base).any?
                       flash.now[:error] = @participante.errors.where(:base).first.full_message
               else
                       flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
               end      
               format.html { render :edit, status: :bad_request }
           end
      end
  end

  def create
       @participante = Participante.new(participante_params)
       @proyecto = Proyecto.find(@participante.proyecto_id)
       respond_to do |format|
            if @participante.save
                  session[:step] += 1
                  #format.html { redirect_to new_presupuesto_path } 
                  format.html { redirect_to @participante } 
            else
                  if @participante.errors.where(:base).any?
                          flash.now[:error] = @participante.errors.where(:base).first.full_message
                  else
                          flash.now[:error] = 'La infomación esta incompleta, favor de revisar los errores'
                  end
                  @inv_sum = !params[:participante][:pacademicos_attributes].nil? ? SumParts.new(params[:participante][:pacademicos_attributes]).suma : 0.0
                  @tec_sum = !params[:participante][:ptecnicos_attributes].nil? ? SumParts.new(params[:participante][:ptecnicos_attributes]).suma : 0.0
                  @tot_porc = @inv_sum + @tec_sum
                  format.html { render :new, status: :bad_request }
            end
       end    
  end

  def tipopart
      academico = Academico.find(params[:academico_id])
      data = {nomtipo:academico.tacademico.nomtacademico}
      respond_to do |format|
        format.json { render json:data.to_json }
      end
  end

  private
  def participante_params
       params.require(:participante).permit(
                        :proyecto_id, 
                        :tparticipante_id,
                        pacademicos_attributes:[:id, :academico_id, :responsable, :porcentaje, :_destroy],
                        ptecnicos_attributes:[:id, :academico_id, :porcentaje, :_destroy],
                        pestudiantes_attributes:[:id, :nombre, :nivel_id, :_destroy]
                     )
  end
end

class SumParts
     def initialize(part)
         @part = part
     end
     def suma
         s = 0.0
         if !@part.nil?
               @part.each do |i,v|
                      if !v[:porcentaje].nil?
                              s += v[:porcentaje].to_f
                      end  
               end
         end
         return s
     end
end